#include "datasource.h"
#include <qlocale.h>
#include <qfile.h>

DataSource::DataSource(QObject *parent)
    : QObject{parent},
      m_timer{new QTimer(this)},
      m_count_timer{0},
      m_client{new QMqttClient(this)},
      m_is_connected{false},
      m_timestamp{""}
{
    m_ground_timestamp.setName("CNR-INM/ground/HMI/timeStamp");
    m_swamp_timestap.setName("CNR-INM/swamp/HMI/timeStamp");
    connect(m_client, &QMqttClient::connected, this, &DataSource::connectionEstablished);
    connect(m_client, &QMqttClient::messageReceived, this, &DataSource::handleMessage);
    m_timer->start(100);
}

void DataSource::update(){
    //qDebug() << m_count_timer;
    m_count_timer += 10;
    send_timestamp(m_count_timer);
}

void DataSource::setConnection()
{
    if(!m_is_connected){
        m_client->connectToHost();
        connect(m_timer, &QTimer::timeout, this, &DataSource::update);
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
    m_client->subscribe(m_swamp_status.gps_ahrs_status()->latitude()->topic_name(),0);
    m_client->subscribe(m_swamp_status.gps_ahrs_status()->longitude()->topic_name(),0);
    m_client->subscribe(m_swamp_status.ngc_status()->psi()->topic_name(),0);

    // todo create the right classes for them
    m_timestamp = "CNR-INM/clock/timeStamp";
    m_client->subscribe(m_timestamp,0);

    // set connection true after all subscriptions are made
    set_is_connected(true);
    if(m_timer->isActive()) m_timer->stop();
}

void DataSource::handleMessage(const QByteArray &message, const QMqttTopicName &topic)
{
    // to do move the things inside here to a checkMessage method.
    double value = QString(message).split(QLatin1Char(' '))[0].toDouble();

    if(topic.name() == m_timestamp){
        m_count_timer = value;
        send_timestamp(value);
    }else if(topic.name() == m_swamp_status.gps_ahrs_status()->latitude()->topic_name()){
        m_swamp_status.gps_ahrs_status()->latitude()->setValue(value);
    }else if(topic.name() == m_swamp_status.gps_ahrs_status()->longitude()->topic_name()){
        m_swamp_status.gps_ahrs_status()->longitude()->setValue(value);
    }else if(topic.name() == m_swamp_status.ngc_status()->psi()->topic_name()){
        double r_degree = value * 180 / PI;
        m_swamp_status.ngc_status()->psi()->setValue(r_degree);
    }
}

void DataSource::send_timestamp(double value) const{

    QByteArray q_b;
    // TODO name should be read from the cfg?
    m_client->publish(m_ground_timestamp, q_b.setNum(value));
    m_client->publish(m_swamp_timestap, q_b.setNum(value));
}

// this method read the configuration file and populate all data with their topic names. It also sets
// port and hostname for the mqtt client
// return true or false depending on success
bool DataSource::read_cfg(QString filename)
{
    // TODO add a property that only when this is finished i can set up connection.
    QFile file(filename);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "Failed to open file:" << file.fileName() << "Error:" << file.errorString();
        return false;
    }

    QString wrongTopicName = "";
    QString tn;
    QMap<QString, QString> topic_map;
    QTextStream in(&file);

    while (!in.atEnd()) {
        QStringList line = in.readLine().split(QRegExp("\\s+"));
        if(line.size() == 2){
            topic_map[line[0].trimmed()] = line[1].trimmed();
        }
    }

    // ready to populate my data structs
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // MQTT
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    tn = "Broker-port:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn ; m_client->setPort(topic_map[tn].toUInt());
    tn = "Broker-address:";  if(topic_map[tn].isEmpty()) wrongTopicName = tn ;m_client->setHostname(topic_map[tn]);
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // NGC and GPS
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    tn = "ngc-pose-psi-act:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn ; else m_swamp_status.ngc_status()->psi()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "GPS-AHRS-latitude:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.gps_ahrs_status()->latitude()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "GPS-AHRS-longitude:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.gps_ahrs_status()->longitude()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "ngc-force-fu-man:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.ngc_status()->fu()->ref()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "ngc-force-fv-man:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.ngc_status()->fv()->ref()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "ngc-force-tr-man:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.ngc_status()->tr()->ref()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // motors
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    tn = "FL-THR-enable-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f1()->thr_enable()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "FL-AZM-enable-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f1()->azm_enable()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "FL-THR-power-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f1()->thr_power()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "FL-AZM-power-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f1()->azm_power()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "FR-THR-enable-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f2()->thr_enable()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "FR-AZM-enable-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f2()->azm_enable()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "FR-THR-power-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f2()->thr_power()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "FR-AZM-power-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f2()->azm_power()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "RL-THR-enable-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f3()->thr_enable()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "RL-AZM-enable-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f3()->azm_enable()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "RL-THR-power-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f3()->thr_power()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "RL-AZM-power-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f3()->azm_power()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "RR-THR-enable-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f4()->thr_enable()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "RR-AZM-enable-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f4()->azm_enable()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "RR-THR-power-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f4()->thr_power()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);
    tn = "RR-AZM-power-command:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn; else m_swamp_status.motor_status()->f4()->azm_power()->setTopic_name("CNR-INM/swamp/" + topic_map[tn]);

    if(!wrongTopicName.isEmpty()){
        qDebug() << "Topic named " << wrongTopicName << " is not present in the configuration file or is not spelled properly.";
        return false;
    }
    return true;
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

SwampStatus *DataSource::swamp_status()
{
    return &m_swamp_status;
}
