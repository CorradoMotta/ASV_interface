#include "qmlmqttclient.h"
#include <QMqttTopicFilter>
#include <QDebug>

QmlMqttClient::QmlMqttClient(QObject *parent)
    : QMqttClient(parent)
{
    qDebug() << "Creating new client..";
//    //m_swamp_status.gps_ahrs_status()->longitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/longitude");
//    //m_swamp_status.gps_ahrs_status()->latitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/latitude");
//    setPort(1883);
//    setHostname("10.17.9.20");
//    //setHostname("test.mosquitto.org");
//    connect(this, &QMqttClient::connected, this, &QmlMqttClient::connectionEstablished);
//    connect(this, &QMqttClient::messageReceived, this, &QmlMqttClient::handleMessage);
//    //connect(this, &QMqttClient::messageReceived, this, &QmlMqttClient::HandleMessage);

//    timer = new QTimer(this);
//    count_timer = 0;
//    timer->start(10);
//    connect(timer, &QTimer::timeout, this, &QmlMqttClient::update);
}

void QmlMqttClient::connectionEstablished(){
//    qDebug() << "Connected!..";

//    // after is connected i do the subscriptions..
//    lat_topic = "CNR-INM/swamp/sensors/GPS_AHRS/latitude";
//    lon_topic = "CNR-INM/swamp/sensors/GPS_AHRS/longitude";
//    psy_topic = "CNR-INM/swamp/NGC/pose/psi/actual";
//    timestamp = "CNR-INM/clock/timeStamp";
//    QMqttClient::subscribe(m_data_source->swampData()->gps_ahrs_status()->latitude()->topic_name(),0);
//    QMqttClient::subscribe(m_data_source->swampData()->gps_ahrs_status()->longitude()->topic_name(),0);
//    QMqttClient::subscribe(timestamp,0);
//    QMqttClient::subscribe(psy_topic,0);
}

void QmlMqttClient::update(){
//    ++ count_timer;
//    QByteArray q_b;
//    QMqttClient::publish(QMqttTopicName("CNR-INM/ground/HMI/timeStamp"), q_b.setNum(count_timer));
//    QMqttClient::publish(QMqttTopicName("CNR-INM/swamp/HMI/timeStamp"), q_b.setNum(count_timer));
}

void QmlMqttClient::publishMessage(const QString &topic, const QByteArray &message){
    //QMqttClient::publish(QMqttTopicName(topic), message);
}

void QmlMqttClient::handleMessage(const QByteArray &message, const QMqttTopicName &topic){
//    QStringList list1 = QString(message).split(QLatin1Char(' '));
//    double value = list1[0].toDouble();
//    QStringList topicName = topic.name().split(QLatin1Char('/'));
//    auto top = topicName[topicName.size()-1];
//    //qDebug() << "coor " << coor << "Topic " << top ;
//    if(QString::compare(top, "timeStamp")==0){
//        if(timer->isActive()) timer->stop();
//        emit newTimeStamp(value);
//        QByteArray q_b;
//        QMqttClient::publish(QMqttTopicName("CNR-INM/ground/HMI/timeStamp"), q_b.setNum(value));
//        QMqttClient::publish(QMqttTopicName("CNR-INM/swamp/HMI/timeStamp"), q_b.setNum(value));
//    }
//    else if(QString::compare(topic.name(), m_data_source->swampData()->gps_ahrs_status()->latitude()->topic_name())==0){
//        m_data_source->swampData()->gps_ahrs_status()->latitude()->setValue(value);
//    }else if (QString::compare(topic.name(), m_data_source->swampData()->gps_ahrs_status()->longitude()->topic_name())==0){
//        m_data_source->swampData()->gps_ahrs_status()->longitude()->setValue(value);
//        //emit newCoordinate(top, value);
//    }else if(QString::compare(topic.name(), psy_topic)==0){
//        //convert to degrees
//        double PI = 3.1415926535;
//        double r_degree = value * 180 / PI;
//        emit newRotation(top, r_degree);
//    }
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
    // TODO METHOD TO GET DATA m_data_source.getData(<pathToConfFile>);
    m_data_source->swampData()->gps_ahrs_status()->latitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/latitude");
    m_data_source->swampData()->gps_ahrs_status()->longitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/longitude");
    m_data_source->swampData()->ngc_status()->psi()->setTopic_name("CNR-INM/swamp/NGC/pose/psi/actual");

    // TODO WHY IN REF IF IT IS MANUAL? Force panel
    m_data_source->swampData()->ngc_status()->fu()->ref()->setTopic_name("CNR-INM/swamp/NGC/force/fu/manual");
    m_data_source->swampData()->ngc_status()->fv()->ref()->setTopic_name("CNR-INM/swamp/NGC/force/fv/manual");
    m_data_source->swampData()->ngc_status()->tr()->ref()->setTopic_name("CNR-INM/swamp/NGC/force/tr/manual");

    // engine panel
    m_data_source->swampData()->motor_status()->f1()->thr_enable()->setTopic_name("CNR-INM/swamp/motor/digital/FL-THR-enable");
    m_data_source->swampData()->motor_status()->f1()->azm_enable()->setTopic_name("CNR-INM/swamp/motor/digital/FL-AZM-enable");
    m_data_source->swampData()->motor_status()->f1()->thr_power()->setTopic_name("CNR-INM/swamp/motor/digital/FL-THR-power");
    m_data_source->swampData()->motor_status()->f1()->azm_power()->setTopic_name("CNR-INM/swamp/motor/digital/FL-AZM-power");

    m_data_source->swampData()->motor_status()->f2()->thr_enable()->setTopic_name("CNR-INM/swamp/motor/digital/FR-THR-enable");
    m_data_source->swampData()->motor_status()->f2()->azm_enable()->setTopic_name("CNR-INM/swamp/motor/digital/FR-AZM-enable");
    m_data_source->swampData()->motor_status()->f2()->thr_power()->setTopic_name("CNR-INM/swamp/motor/digital/FR-THR-power");
    m_data_source->swampData()->motor_status()->f2()->azm_power()->setTopic_name("CNR-INM/swamp/motor/digital/FR-AZM-power");

    m_data_source->swampData()->motor_status()->f3()->thr_enable()->setTopic_name("CNR-INM/swamp/motor/digital/RL-THR-enable");
    m_data_source->swampData()->motor_status()->f3()->azm_enable()->setTopic_name("CNR-INM/swamp/motor/digital/RL-AZM-enable");
    m_data_source->swampData()->motor_status()->f3()->thr_power()->setTopic_name("CNR-INM/swamp/motor/digital/RL-THR-power");
    m_data_source->swampData()->motor_status()->f3()->azm_power()->setTopic_name("CNR-INM/swamp/motor/digital/RL-AZM-power");

    m_data_source->swampData()->motor_status()->f4()->thr_enable()->setTopic_name("CNR-INM/swamp/motor/digital/RR-THR-enable");
    m_data_source->swampData()->motor_status()->f4()->azm_enable()->setTopic_name("CNR-INM/swamp/motor/digital/RR-AZM-enable");
    m_data_source->swampData()->motor_status()->f4()->thr_power()->setTopic_name("CNR-INM/swamp/motor/digital/RR-THR-power");
    m_data_source->swampData()->motor_status()->f4()->azm_power()->setTopic_name("CNR-INM/swamp/motor/digital/RR-AZM-power");

}
