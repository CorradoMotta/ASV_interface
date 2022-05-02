#include "datasource.h"
#include <qlocale.h>
#include <qfile.h>

DataSource::DataSource(QObject *parent)
    : QObject{parent},
      m_timer{new QTimer(this)},
      m_count_timer{0},
      m_client{new QMqttClient(this)},
      m_is_connected{false}
{
    connect(m_client, &QMqttClient::connected, this, &DataSource::connectionEstablished);
    connect(m_client, &QMqttClient::messageReceived, this, &DataSource::handleMessage);
    m_timer->start(100);
}

void DataSource::update_ts_from_local(){
    m_count_timer += 100;  // TODO CHANGE THIS?
    send_new_timestamp(m_count_timer);
}

void DataSource::update_ts_from_vehicle(){
    send_new_timestamp(m_swamp_status.time_status()->timestamp()->value());
}

void DataSource::send_new_timestamp(double value){
    QString str_value = QString::number(value);
    m_client->publish(m_swamp_status.time_status()->hmi_timestamp()->topic_name(), str_value.toUtf8());
}

void DataSource::setConnection()
{
    if(!m_is_connected){
        m_client->connectToHost();
        connect(m_timer, &QTimer::timeout, this, &DataSource::update_ts_from_local); //start sending heartbeat
    }else{
        qDebug() << "Disconnecting..";
        m_client->disconnectFromHost();
        set_is_connected(false);
    }
}

void DataSource::publishMessage(const QString &topic, const QString &message)
{
    int current_timestamp = m_swamp_status.time_status()->timestamp()->value();
    QString value = message + " " +  QString::number(current_timestamp) + " " + "1";
    m_client->publish(topic, value.toUtf8());
}

void DataSource::connectionEstablished()
{
    qDebug() << "Connected!..";

    // do all the subscribes
    DoubleMap::iterator dm;
    for (dm = m_double_map.begin(); dm != m_double_map.end(); ++dm){
        if(dm.value()->subscribe() == true){
            qDebug() << "subscribing to:" << dm.key();
            m_client->subscribe(dm.key(), 0);
        }
    }

    IntMap::iterator im;
    for (im = m_int_map.begin(); im != m_int_map.end(); ++im){
        if(im.value()->subscribe() == true){
            qDebug() << "subscribing to:" << im.key();
            m_client->subscribe(im.key(), 0);
        }
    }

    StringMap::iterator sm;
    for (sm = m_string_map.begin(); sm != m_string_map.end(); ++sm){
        if(sm.value()->subscribe() == true){
            qDebug() << "subscribing to:" << sm.key();
            m_client->subscribe(sm.key(), 0);
        }
    }

    // connect timestamps
    connect(m_swamp_status.time_status()->timestamp(), &DoubleVariable::valueChanged,
            this, &DataSource::update_ts_from_vehicle);
    set_is_connected(true);
}

void DataSource::handleMessage(const QByteArray &message, const QMqttTopicName &topic)
{
    if(m_timer->isActive()) m_timer->stop();

    if(m_double_map.contains(topic.name())){
        m_double_map[topic.name()]->fromString(QString(message));
    }else if(m_int_map.contains(topic.name())){
        m_int_map[topic.name()]->fromString(QString(message));
    }else if(m_string_map.contains(topic.name())) {        // TODO not tested
        m_string_map[topic.name()]->fromString(QString(message));
    }
}

bool DataSource::read_cfg(QString filename)
{
    QFile file(filename);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "Failed to open file:" << file.fileName() << "Error:" << file.errorString();
        return false;
    }

    QString wrongTopicName = "";
    QString prefix = "CNR-INM/swamp/";
    QString tn;
    QMap<QString, QString> topic_map;
    QTextStream in(&file);

    while (!in.atEnd()) {
        QStringList line = in.readLine().split(QRegExp("\\s+"));
        if(line.size() == 2){
            topic_map[line[0].trimmed()] = line[1].trimmed();
        }
    }

    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // MQTT
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    tn = "Broker-port:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn ; m_client->setPort(topic_map[tn].toUInt());
    tn = "Broker-address:";  if(topic_map[tn].isEmpty()) wrongTopicName = tn ; m_client->setHostname(topic_map[tn]);
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Timestamp
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("timeStamp:", m_swamp_status.time_status()->timestamp(), topic_map, "CNR-INM/")) return false;
    if(!set_topic_name("HMI-Robot-timeStamp:", m_swamp_status.time_status()->hmi_timestamp(), topic_map, prefix)) return false;
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // NGC and GPS
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("ngc-pose-psi-act:", m_swamp_status.ngc_status()->psi(), topic_map, prefix)) return false;
    if(!set_topic_name("GPS-AHRS-latitude:", m_swamp_status.gps_ahrs_status()->latitude() , topic_map, prefix)) return false;
    if(!set_topic_name("GPS-AHRS-longitude:", m_swamp_status.gps_ahrs_status()->longitude(), topic_map, prefix)) return false;
    if(!set_topic_name("ngc-force-fu-man:", m_swamp_status.ngc_status()->fu()->ref() , topic_map, prefix)) return false;
    if(!set_topic_name("ngc-force-fv-man:", m_swamp_status.ngc_status()->fv()->ref() , topic_map, prefix)) return false;
    if(!set_topic_name("ngc-force-tr-man:", m_swamp_status.ngc_status()->tr()->ref(), topic_map, prefix)) return false;
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Motors
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("FL-THR-enable-command:", m_swamp_status.motor_status()->f1()->thr_enable(), topic_map, prefix)) return false;
    if(!set_topic_name("FL-AZM-enable-command:", m_swamp_status.motor_status()->f1()->azm_enable(), topic_map, prefix)) return false;
    if(!set_topic_name("FL-THR-power-command:", m_swamp_status.motor_status()->f1()->thr_power(), topic_map, prefix)) return false;
    if(!set_topic_name("FL-AZM-power-command:", m_swamp_status.motor_status()->f1()->azm_power(), topic_map, prefix)) return false;
    if(!set_topic_name("FR-THR-enable-command:", m_swamp_status.motor_status()->f2()->thr_enable(), topic_map, prefix)) return false;
    if(!set_topic_name("FR-AZM-enable-command:", m_swamp_status.motor_status()->f2()->azm_enable(), topic_map, prefix)) return false;
    if(!set_topic_name("FR-THR-power-command:", m_swamp_status.motor_status()->f2()->thr_power(), topic_map, prefix)) return false;
    if(!set_topic_name("FR-AZM-power-command:", m_swamp_status.motor_status()->f2()->azm_power(), topic_map, prefix)) return false;
    if(!set_topic_name("RL-THR-enable-command:", m_swamp_status.motor_status()->f3()->thr_enable(), topic_map, prefix)) return false;
    if(!set_topic_name("RL-AZM-enable-command:", m_swamp_status.motor_status()->f3()->azm_enable(), topic_map, prefix)) return false;
    if(!set_topic_name("RL-THR-power-command:", m_swamp_status.motor_status()->f3()->thr_power(), topic_map, prefix)) return false;
    if(!set_topic_name("RL-AZM-power-command:", m_swamp_status.motor_status()->f3()->azm_power(), topic_map, prefix)) return false;
    if(!set_topic_name("RR-THR-enable-command:", m_swamp_status.motor_status()->f4()->azm_enable(), topic_map, prefix)) return false;
    if(!set_topic_name("RR-AZM-enable-command:", m_swamp_status.motor_status()->f4()->thr_enable(), topic_map, prefix)) return false;
    if(!set_topic_name("RR-AZM-power-command:", m_swamp_status.motor_status()->f4()->azm_power(), topic_map, prefix)) return false;
    if(!set_topic_name("RR-THR-power-command:", m_swamp_status.motor_status()->f4()->thr_power(), topic_map, prefix)) return false;
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Minions
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



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

bool DataSource::set_topic_name(QString tn, DoubleVariable *dv, QMap<QString, QString> &topic_map, QString prefix)
{
    if(topic_map[tn].isEmpty()){
        qDebug() << "Topic named " << tn << " is not present in the configuration file or is not spelled properly.";
        return false;
    }
    else{
        dv->setTopic_name(prefix + topic_map[tn]);
        m_double_map[prefix + topic_map[tn]] = dv;
        return true;
    }
}

bool DataSource::set_topic_name(QString tn, IntVariable *iv, QMap<QString, QString> &topic_map, QString prefix)
{
    if(topic_map[tn].isEmpty()){
        qDebug() << "Topic named " << tn << " is not present in the configuration file or is not spelled properly.";
        return false;
    }
    else{
        iv->setTopic_name(prefix + topic_map[tn]);
        m_int_map[prefix + topic_map[tn]] = iv;
        return true;
    }
}

bool DataSource::set_topic_name(QString tn, StringVariable *sv, QMap<QString, QString> &topic_map, QString prefix)
{
    if(topic_map[tn].isEmpty()){
        qDebug() << "Topic named " << tn << " is not present in the configuration file or is not spelled properly.";
        return false;
    }
    else{
        sv->setTopic_name(prefix + topic_map[tn]);
        m_string_map[prefix+ topic_map[tn]] = sv;
        return true;
    }
}
