#include "datasource_mqtt.h"
#include <qlocale.h>
#include <qfile.h>
#include <data/variable.h>

DataSourceMqtt::DataSourceMqtt(QObject *parent)
    : DataSource{parent},
      m_timer{new QTimer(this)},
      m_count_timer{0},
      m_client{new QMqttClient(this)}
{
    connect(m_client, &QMqttClient::connected, this, &DataSourceMqtt::connectionEstablished);
    connect(m_client, &QMqttClient::messageReceived, this, &DataSourceMqtt::handleMessage);
    connect(m_client, &QMqttClient::disconnected, this, &DataSourceMqtt::handleDisconnected);
    m_timer->start(100);
}

void DataSourceMqtt::update_ts_from_local(){
    m_count_timer += 100;  // TODO CHANGE THIS?
    send_new_timestamp(m_count_timer);
}

void DataSourceMqtt::update_ts_from_vehicle(){
    send_new_timestamp(m_swamp_status.time_status()->timestamp()->value());
}

void DataSourceMqtt::send_new_timestamp(double value){
    QString str_value = QString::number(value);
    m_client->publish(m_swamp_status.time_status()->hmi_timestamp()->topic_name(), str_value.toUtf8());
}

void DataSourceMqtt::setConnection()
{
    if(!m_is_connected){
        m_client->connectToHost();
        connect(m_timer, &QTimer::timeout, this, &DataSourceMqtt::update_ts_from_local); //start sending heartbeat
    }else{
        qDebug() << "Disconnecting..";
        m_client->disconnectFromHost();
        set_is_connected(false);
    }
}

void DataSourceMqtt::publishMessage(const QString &identifier, const QString &message)
{
    qDebug() <<identifier << " : " << message;
    int current_timestamp = m_swamp_status.time_status()->timestamp()->value();
    QString value = message + " " +  QString::number(current_timestamp) + " " + "1";
    // TODO publish ONLY if it is connected or gray minion page.
    m_client->publish(identifier, value.toUtf8());
}

void DataSourceMqtt::connectionEstablished()
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
            this, &DataSourceMqtt::update_ts_from_vehicle);
    set_is_connected(true);
}

void DataSourceMqtt::handleDisconnected()
{
    //TODO implement automatic reconnection
    set_is_connected(false);
    qDebug() << "disconnected";
}

void DataSourceMqtt::handleMessage(const QByteArray &message, const QMqttTopicName &topic)
{
    if(m_timer->isActive()) m_timer->stop();

    if(m_double_map.contains(topic.name())){
        m_double_map[topic.name()]->fromString(QString(message));
    }else if(m_int_map.contains(topic.name())){
        m_int_map[topic.name()]->fromString(QString(message));
    }else if(m_string_map.contains(topic.name())) {
        m_string_map[topic.name()]->fromString(QString(message));
    }
}

bool DataSourceMqtt::set_cfg(QString filename)
{
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
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // PREFIX
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    QString env_prefix;
    QString prefix;
    tn = "Environment:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn ; env_prefix = topic_map[tn];
    tn = "Robot:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn ; prefix = env_prefix+  topic_map[tn];
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // MQTT
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    tn = "Broker-port:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn ; m_client->setPort(topic_map[tn].toUInt());
    tn = "Broker-address:";  if(topic_map[tn].isEmpty()) wrongTopicName = tn ; m_client->setHostname(topic_map[tn]);
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Bathymetry
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("ngc-pose-a-act:", m_swamp_status.ngc_status()->altitude(), topic_map, prefix)) return false;
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Timestamp
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("timeStamp:", m_swamp_status.time_status()->timestamp(), topic_map, env_prefix)) return false;
    if(!set_topic_name("HMI-Robot-timeStamp:", m_swamp_status.time_status()->hmi_timestamp(), topic_map, prefix)) return false;
    if(!set_topic_name("date-time:", m_swamp_status.time_status()->dateTime(), topic_map, env_prefix)) return false;
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

    if(!wrongTopicName.isEmpty()){
        qDebug() << "Topic named " << wrongTopicName << " is not present in the configuration file or is not spelled properly.";
        return false;
    }
    bool minionResult = read_cfg_minion("../ASV_interface/conf/topics_minion.cfg");
    return minionResult;
}

bool DataSourceMqtt::read_cfg_minion(QString filename)
{
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

    QString env_prefix;
    QString minion_prefix;
    QString prefix;
    Minion* singleMinion;

    tn = "Environment:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn ; env_prefix = topic_map[tn];
    tn = "Minion:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn ; minion_prefix = topic_map[tn];
    tn = "Robot:"; if(topic_map[tn].isEmpty()) wrongTopicName = tn ; prefix = env_prefix +  topic_map[tn] + minion_prefix;

    if(minion_prefix.contains("FL")) singleMinion = m_swamp_status.minion_fl();
    else if(minion_prefix.contains("FR")) singleMinion = m_swamp_status.minion_fr();
    else if(minion_prefix.contains("RL")) singleMinion = m_swamp_status.minion_rl();
    else if(minion_prefix.contains("RR")) singleMinion = m_swamp_status.minion_rr();
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Timestamp
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // TODO add timestamp from here??
    //if(!set_topic_name("system-time-stamp:", m_swamp_status.time_status()->timestamp(), topic_map, "CNR-INM/")) return false;
    //if(!set_topic_name("HMI-Robot-timeStamp:", m_swamp_status.time_status()->hmi_timestamp(), topic_map, prefix)) return false;
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Generic
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("state-node-id:", singleMinion->minionState()->nodeId(), topic_map, prefix)) return false;
    if(!set_topic_name("state-date-time:", singleMinion->minionState()->dateAndTime(), topic_map, prefix)) return false;
    if(!set_topic_name("state-battery-voltage:", singleMinion->minionState()->batteryVoltage(), topic_map, prefix)) return false;
    if(!set_topic_name("state-nop-counter:", singleMinion->minionState()->nopCounter(), topic_map, prefix)) return false;

    if(!set_topic_name("cmd-log:", singleMinion->minionCmd()->log(), topic_map, prefix)) return false;
    if(!set_topic_name("cmd-change-tlm-addr:", singleMinion->minionCmd()->changeTlmAddr(), topic_map, prefix)) return false;
    if(!set_topic_name("cmd-shutdown:", singleMinion->minionCmd()->shutdown(), topic_map, prefix)) return false;
    if(!set_topic_name("cmd-reboot:", singleMinion->minionCmd()->reboot(), topic_map, prefix)) return false;
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Pump
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("state-thrust-fault:", singleMinion->minionState()->thrustMotorFault(), topic_map, prefix)) return false;
    if(!set_topic_name("state-thrust-power:", singleMinion->minionState()->thrustMotorPower(), topic_map, prefix)) return false;
    if(!set_topic_name("state-thrust-enable:", singleMinion->minionState()->thrustMotorEnable(), topic_map, prefix)) return false;
    if(!set_topic_name("state-thrust-temperature:", singleMinion->minionState()->thrustMotorTemperature(), topic_map, prefix)) return false;
    if(!set_topic_name("state-thrust-speed:", singleMinion->minionState()->thrustMotorSpeed(), topic_map, prefix)) return false;
    if(!set_topic_name("state-thrust-current:", singleMinion->minionState()->thrustMotorCurrent(), topic_map, prefix)) return false;

    if(!set_topic_name("cmd-thrust-power:", singleMinion->minionCmd()->thrustMotorPower(), topic_map, prefix)) return false;
    if(!set_topic_name("cmd-thrust-enable:", singleMinion->minionCmd()->thrustMotorEnable(), topic_map, prefix)) return false;
    if(!set_topic_name("cmd-thrust-reference:", singleMinion->minionCmd()->thrustMotorSetReference()->act(), topic_map, prefix)) return false; // TODO REF OR ACT
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Azimuth
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("state-azimuth-fault:", singleMinion->minionState()->azimuthMotorFault(), topic_map, prefix)) return false;
    if(!set_topic_name("state-azimuth-power:", singleMinion->minionState()->azimuthMotorPower(), topic_map, prefix)) return false;
    if(!set_topic_name("state-azimuth-enable:", singleMinion->minionState()->azimuthMotorEnable(), topic_map, prefix)) return false;
    if(!set_topic_name("state-azimuth-position:", singleMinion->minionState()->azimuthMotorPosition(), topic_map, prefix)) return false;
    if(!set_topic_name("state-azimuth-angle:", singleMinion->minionState()->azimuthMotorAngle(), topic_map, prefix)) return false;
    if(!set_topic_name("state-azimuth-temperature:", singleMinion->minionState()->azimuthMotorTemperature(), topic_map, prefix)) return false;
    if(!set_topic_name("state-azimuth-current:", singleMinion->minionState()->azimuthMotorCurrent(), topic_map, prefix)) return false;

    if(!set_topic_name("cmd-azimuth-power:", singleMinion->minionCmd()->azimuthMotorPower(), topic_map, prefix)) return false;
    if(!set_topic_name("cmd-azimuth-enable:", singleMinion->minionCmd()->azimuthMotorEnable(), topic_map, prefix)) return false;
    if(!set_topic_name("cmd-azimuth-set-home:", singleMinion->minionCmd()->azimuthSetHome(), topic_map, prefix)) return false;
    if(!set_topic_name("cmd-azimuth-go-home:", singleMinion->minionCmd()->azimuthGoHome(), topic_map, prefix)) return false;
    if(!set_topic_name("cmd-azimuth-angle:", singleMinion->minionCmd()->azimuthMotorSetReference()->act(), topic_map, prefix)) return false;// TODO REF OR ACT
    if(!set_topic_name("cmd-azimuth-max-speed:",singleMinion->minionCmd()->azimuthSetMaxSpeed(), topic_map, prefix)) return false;
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // IMU
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("state-imu-yaw:", singleMinion->minionState()->imuYaw(), topic_map, prefix)) return false;
    if(!set_topic_name("state-imu-pitch:", singleMinion->minionState()->imuPitch(), topic_map, prefix)) return false;
    if(!set_topic_name("state-imu-roll:", singleMinion->minionState()->imuRoll(), topic_map, prefix)) return false;
    if(!set_topic_name("state-imu-xGyro:", singleMinion->minionState()->imuXGyro(), topic_map, prefix)) return false;
    if(!set_topic_name("state-imu-yGyro:", singleMinion->minionState()->imuYGyro(), topic_map, prefix)) return false;
    if(!set_topic_name("state-imu-zGyro:", singleMinion->minionState()->imuZGyro(), topic_map, prefix)) return false;
    if(!set_topic_name("state-imu-temperature:", singleMinion->minionState()->imuTemperature(), topic_map, prefix)) return false;
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // GPS
    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    if(!set_topic_name("state-gps-latitude:", singleMinion->minionState()->gpsLatitude(), topic_map, prefix)) return false;
    if(!set_topic_name("state-gps-longitude:", singleMinion->minionState()->gpsLongitude(), topic_map, prefix)) return false;
    if(!set_topic_name("state-gps-fix:", singleMinion->minionState()->gpsFixQuality(), topic_map, prefix)) return false;
    if(!set_topic_name("state-gps-nSatellites:", singleMinion->minionState()->gpsNSatellite(), topic_map, prefix)) return false;
    if(!set_topic_name("state-gps-altitude:", singleMinion->minionState()->gpsAltitude(), topic_map, prefix)) return false;

    if(!wrongTopicName.isEmpty()){
        qDebug() << "Topic named " << wrongTopicName << " is not present in the configuration file or is not spelled properly.";
        return false;
    }

    return true;
}

bool DataSourceMqtt::set_topic_name(QString tn, DoubleVariable *dv, QMap<QString, QString> &topic_map, QString prefix)
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

bool DataSourceMqtt::set_topic_name(QString tn, IntVariable *iv, QMap<QString, QString> &topic_map, QString prefix)
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

bool DataSourceMqtt::set_topic_name(QString tn, StringVariable *sv, QMap<QString, QString> &topic_map, QString prefix)
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
