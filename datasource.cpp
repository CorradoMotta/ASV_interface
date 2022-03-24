#include "datasource.h"

DataSource::DataSource(QObject *parent)
    : QObject{parent},
      m_timer{new QTimer(this)},
      m_count_timer{0},
      m_SwampStatus{new SwampStatus()},
      m_client{new QMqttClient(this)},
      m_is_connected{false}
{
    // set socket info and connections
    m_client->setPort(1883);
    m_client->setHostname("10.17.9.20");
    connect(m_client, &QMqttClient::connected, this, &DataSource::connectionEstablished);
    connect(m_client, &QMqttClient::messageReceived, this, &DataSource::handleMessage);

    //-----------------------------------------------------------------------------------
    // trigger timer for HMI timestamps
    //-----------------------------------------------------------------------------------
    QMqttTopicName ground_timestamp("CNR-INM/ground/HMI/timeStamp");
    QMqttTopicName swamp_timestap("CNR-INM/swamp/HMI/timeStamp");
    m_timer->start(10);
    connect(m_timer, &QTimer::timeout, this,[=](){
        ++ m_count_timer;
        QByteArray q_b;
        // TODO name should be read from the cfg?
        m_client->publish(ground_timestamp, q_b.setNum(m_count_timer));
        m_client->publish(swamp_timestap, q_b.setNum(m_count_timer));

    });
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

void DataSource::connectionEstablished()
{
    qDebug() << "Connected!..";

    // do all the subscribes!
    QMqttClient::subscribe(m_data_source->swampData()->gps_ahrs_status()->latitude()->topic_name(),0);
    QMqttClient::subscribe(m_data_source->swampData()->gps_ahrs_status()->longitude()->topic_name(),0);

    set_is_connected(true);
}

void DataSource::handleMessage(const QByteArray &message, const QMqttTopicName &topic)
{

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
