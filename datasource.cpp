#include "datasource.h"
#include <qlocale.h>

DataSource::DataSource(QObject *parent)
    : QObject{parent},
      m_timer{new QTimer(this)},
      m_count_timer{0},
      m_SwampStatus{new SwampStatus()},
      m_client{new QMqttClient(this)},
      m_is_connected{false},
      m_timestamp{""}
{
    // set socket info and connections
    m_client->setPort(1883);
    m_client->setHostname("10.17.9.20");
    connect(m_client, &QMqttClient::connected, this, &DataSource::connectionEstablished);
    connect(m_client, &QMqttClient::messageReceived, this, &DataSource::handleMessage);

    //-----------------------------------------------------------------------------------
    // trigger timer for HMI timestamps
    //-----------------------------------------------------------------------------------

    m_timer->start(10);
    connect(m_timer, &QTimer::timeout, this, &DataSource::update);
}

void DataSource::update(){

    ++ m_count_timer;
    send_timestamp(m_count_timer);
}


SwampStatus *DataSource::swampData()
{
    return m_SwampStatus;
}

void DataSource::setConnection()
{
    if(!m_is_connected){
        m_client->connectToHost();

    }else{
        qDebug() << "Disconnecting..";
        m_client->disconnectFromHost();
        set_is_connected(false);
    }
}

void DataSource::publishMessage(const QString &topic, const QString &message)
{
    QString value = message + " " +  QString::number(m_count_timer) + " " + "1";
    qDebug() << "topic: " << topic << "value: " << value;
    m_client->publish(topic, value.toUtf8());
}

void DataSource::connectionEstablished()
{
    qDebug() << "Connected!..";

    // do all the subscribes!
    m_client->subscribe(m_SwampStatus->gps_ahrs_status()->latitude()->topic_name(),0);
    m_client->subscribe(m_SwampStatus->gps_ahrs_status()->longitude()->topic_name(),0);
    m_client->subscribe(m_SwampStatus->ngc_status()->psi()->topic_name(),0);

    // todo create the right classes for them
    m_timestamp = "CNR-INM/clock/timeStamp";
    m_client->subscribe(m_timestamp,0);


    // set connection true after all subscriptions are made
    set_is_connected(true);
}

void DataSource::handleMessage(const QByteArray &message, const QMqttTopicName &topic)
{
    // to do move the things inside here to a checkMessage method.
    double value = QString(message).split(QLatin1Char(' '))[0].toDouble();

    if(topic.name() == m_timestamp){
        qDebug() << "i am here";
        if(m_timer->isActive()) m_timer->stop();
        m_count_timer = value;
        send_timestamp(value);
    }else if(topic.name() == m_SwampStatus->gps_ahrs_status()->latitude()->topic_name()){
        m_SwampStatus->gps_ahrs_status()->latitude()->setValue(value);
    }else if(topic.name() == m_SwampStatus->gps_ahrs_status()->longitude()->topic_name()){
        m_SwampStatus->gps_ahrs_status()->longitude()->setValue(value);
    }else if(topic.name() == m_SwampStatus->ngc_status()->psi()->topic_name()){
        double r_degree = value * 180 / PI;
        m_SwampStatus->ngc_status()->psi()->setValue(r_degree);
    }
}

void DataSource::send_timestamp(double value) const{
    QMqttTopicName ground_timestamp("CNR-INM/ground/HMI/timeStamp");
    QMqttTopicName swamp_timestap("CNR-INM/swamp/HMI/timeStamp");
    QByteArray q_b;
    // TODO name should be read from the cfg?
    m_client->publish(ground_timestamp, q_b.setNum(value));
    m_client->publish(swamp_timestap, q_b.setNum(value));
}

bool DataSource::is_connected() const
{
    return m_is_connected;
}

void DataSource::set_is_connected(bool newIs_connected)
{
    if (m_is_connected == newIs_connected)
        return;
    m_is_connected = newIs_connected;
    emit is_connectedChanged();
}
