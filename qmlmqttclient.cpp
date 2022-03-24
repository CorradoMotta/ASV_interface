#include "qmlmqttclient.h"
#include <QMqttTopicFilter>
#include <QDebug>

QmlMqttClient::QmlMqttClient(QObject *parent)
    : QMqttClient(parent)
{
    qDebug() << "Creating new client..";
    //m_swamp_status.gps_ahrs_status()->longitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/longitude");
    //m_swamp_status.gps_ahrs_status()->latitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/latitude");
    setPort(1883);
    setHostname("10.17.9.20");
    //setHostname("test.mosquitto.org");
    connect(this, &QMqttClient::connected, this, &QmlMqttClient::connectionEstablished);
    connect(this, &QMqttClient::messageReceived, this, &QmlMqttClient::handleMessage);
    //connect(this, &QMqttClient::messageReceived, this, &QmlMqttClient::HandleMessage);

    timer = new QTimer(this);
    count_timer = 0;
    timer->start(10);
    connect(timer, &QTimer::timeout, this, &QmlMqttClient::update);
}

void QmlMqttClient::connectionEstablished(){
    qDebug() << "Connected!..";

    // after is connected i do the subscriptions..
    lat_topic = "CNR-INM/swamp/sensors/GPS_AHRS/latitude";
    lon_topic = "CNR-INM/swamp/sensors/GPS_AHRS/longitude";
    psy_topic = "CNR-INM/swamp/NGC/pose/psi/actual";
    timestamp = "CNR-INM/clock/timeStamp";
    QMqttClient::subscribe(m_data_source->swampData()->gps_ahrs_status()->latitude()->topic_name(),0);
    QMqttClient::subscribe(m_data_source->swampData()->gps_ahrs_status()->longitude()->topic_name(),0);
    QMqttClient::subscribe(timestamp,0);
    QMqttClient::subscribe(psy_topic,0);
}

void QmlMqttClient::update(){
    ++ count_timer;
    QByteArray q_b;
    QMqttClient::publish(QMqttTopicName("CNR-INM/ground/HMI/timeStamp"), q_b.setNum(count_timer));
    QMqttClient::publish(QMqttTopicName("CNR-INM/swamp/HMI/timeStamp"), q_b.setNum(count_timer));
}

void QmlMqttClient::publishMessage(const QString &topic, const QByteArray &message){
    QMqttClient::publish(QMqttTopicName(topic), message);
}

void QmlMqttClient::handleMessage(const QByteArray &message, const QMqttTopicName &topic){
    QStringList list1 = QString(message).split(QLatin1Char(' '));
    double value = list1[0].toDouble();
    QStringList topicName = topic.name().split(QLatin1Char('/'));
    auto top = topicName[topicName.size()-1];
    //qDebug() << "coor " << coor << "Topic " << top ;
    if(QString::compare(top, "timeStamp")==0){
        if(timer->isActive()) timer->stop();
        emit newTimeStamp(value);
        QByteArray q_b;
        QMqttClient::publish(QMqttTopicName("CNR-INM/ground/HMI/timeStamp"), q_b.setNum(value));
        QMqttClient::publish(QMqttTopicName("CNR-INM/swamp/HMI/timeStamp"), q_b.setNum(value));
    }
    else if(QString::compare(topic.name(), m_data_source->swampData()->gps_ahrs_status()->latitude()->topic_name())==0){
    m_data_source->swampData()->gps_ahrs_status()->latitude()->setValue(value);
    }else if (QString::compare(topic.name(), m_data_source->swampData()->gps_ahrs_status()->longitude()->topic_name())==0){
        m_data_source->swampData()->gps_ahrs_status()->longitude()->setValue(value);
        //emit newCoordinate(top, value);
    }else if(QString::compare(topic.name(), psy_topic)==0){
        //convert to degrees
        double PI = 3.1415926535;
        double r_degree = value * 180 / PI;
        emit newRotation(top, r_degree);
    }
}

QmlMqttClient::~QmlMqttClient(){
    delete timer;
}

SwampStatus *QmlMqttClient::swamp_status()
{
    return &m_swamp_status;
}

DataSource *QmlMqttClient::data_source() const
{
    return m_data_source;
}

void QmlMqttClient::setData_source(DataSource *newData_source)
{
    // TODO this need to be fixed Reading the configuration file should be done by the dataSource itself.
    m_data_source = newData_source;
    m_data_source->swampData()->gps_ahrs_status()->latitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/latitude");
    m_data_source->swampData()->gps_ahrs_status()->longitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/longitude");
    m_data_source->swampData()->ngc_status()->psi()->setTopic_name("CNR-INM/swamp/NGC/pose/psi/actual");
}
