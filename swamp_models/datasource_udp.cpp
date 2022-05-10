#include "datasource_udp.h"
#include <qlocale.h>
#include <qfile.h>
#include <data/variable.h>
#include <QNetworkDatagram>
#include <QTextStream>

DataSourceUdp::DataSourceUdp(QObject *parent)
    : DataSource{parent},
      m_timer{new QTimer(this)},
      m_count_timer{0},
      m_client{new QMqttClient(this)},
      m_is_connected{false},
      m_udpSocket{new QUdpSocket(this)}
{
    m_udpSocket->bind(QHostAddress::LocalHost, 7750);
    connect(m_udpSocket, &QUdpSocket::readyRead, this, &DataSourceUdp::handleMessage);
    connect(m_client, &QMqttClient::connected, this, &DataSourceUdp::connectionEstablished);
    //connect(m_client, &QMqttClient::messageReceived, this, &DataSourceUdp::handleMessage);
    connect(m_client, &QMqttClient::disconnected, this, &DataSourceUdp::handleDisconnected);
    m_timer->start(100);
}

void DataSourceUdp::update_ts_from_local(){
    m_count_timer += 100;  // TODO CHANGE THIS?
    send_new_timestamp(m_count_timer);
}

void DataSourceUdp::update_ts_from_vehicle(){
    send_new_timestamp(m_swamp_status.time_status()->timestamp()->value());
}

void DataSourceUdp::send_new_timestamp(double value){
    QString str_value = QString::number(value);
    m_client->publish(m_swamp_status.time_status()->hmi_timestamp()->topic_name(), str_value.toUtf8());
}

void DataSourceUdp::setConnection()
{
    if(!m_is_connected){
        m_client->connectToHost();
        connect(m_timer, &QTimer::timeout, this, &DataSourceUdp::update_ts_from_local); //start sending heartbeat
    }else{
        qDebug() << "Disconnecting..";
        m_client->disconnectFromHost();
        set_is_connected(false);
    }
}

void DataSourceUdp::publishMessage(const QString &topic, const QString &message)
{
    //qDebug() <<topic << " : " << message;
    //int current_timestamp = m_swamp_status.time_status()->timestamp()->value();
    QString value = topic + " " + message;
    qDebug() << "sending : " << value;
    m_udpSocket->writeDatagram(value.toUtf8(), QHostAddress::LocalHost, 50367);
}

void DataSourceUdp::connectionEstablished()
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
            this, &DataSourceUdp::update_ts_from_vehicle);
    set_is_connected(true);
}

void DataSourceUdp::handleDisconnected()
{
    //TODO implement automatic reconnection
    set_is_connected(false);
    qDebug() << "disconnected";
}

void DataSourceUdp::handleNgcPacket(QTextStream &in)
{
    int secondNumber;
    int thirdNumber;
    //in >> firstNumber;             // firstNumber == 80
    in >> secondNumber;
    in >> thirdNumber;
    qDebug() << qSetRealNumberPrecision( 10 ) << secondNumber << " - " << thirdNumber;
}

void DataSourceUdp::handleMinionPacket(int MinionId, QTextStream &in)
{
    switch(MinionId){
    case NgcTelemetryPacket::MINION_FL_TLM:
        qDebug() << "Receiving a Minion FL packet";
        break;
    case NgcTelemetryPacket::MINION_FR_TLM:
        qDebug() << "Receiving a Minion FR packet";
        break;
    case NgcTelemetryPacket::MINION_RL_TLM:
        qDebug() << "Receiving a Minion RL packet";
        break;
    case NgcTelemetryPacket::MINION_RR_TLM:
        qDebug() << "Receiving a Minion RR packet";
        break;
    default:
        qDebug() << "Following packet identifier not recognised: " << MinionId;
        break;
    }
}

void DataSourceUdp::handleMessage()
{
    if(m_timer->isActive()) m_timer->stop();

    while(m_udpSocket->hasPendingDatagrams()) {
        // receive datagram
        QNetworkDatagram datagram = m_udpSocket->receiveDatagram();
        if(!datagram.isNull()){
            // get data into a QTextStream
            QTextStream in(datagram.data());
            // Check which packet it is
            int packetIndex;
            in >> packetIndex;
            // call appropriate function
            if(packetIndex == NgcTelemetryPacket::NGC_TLM) handleNgcPacket(in);
            else handleMinionPacket(packetIndex, in);
        }
    }
}



bool DataSourceUdp::set_cfg(QString filename)
{
    if(!filename.trimmed().isEmpty()) qDebug() << "Filename " << filename << "is never used";

    Minion* singleMinion;
    QString minionId;
    QString minionCmd = QString::number(NgcCommand::MINION_CMD);

    for (int var = 0; var < 4; ++var) {
        minionId = QString::number(201 + var);
        if(minionId == "201") singleMinion = m_swamp_status.minion_fl();
        else if(minionId == "202") singleMinion = m_swamp_status.minion_fr();
        else if(minionId == "203") singleMinion = m_swamp_status.minion_rl();
        else if(minionId == "204") singleMinion = m_swamp_status.minion_rr();


        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // Timestamp
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // TODO add timestamp from here??
        //if(!set_topic_name("system-time-stamp:", m_swamp_status.time_status()->timestamp(), topic_map, "CNR-INM/")) return false;
        //if(!set_topic_name("HMI-Robot-timeStamp:", m_swamp_status.time_status()->hmi_timestamp(), topic_map, prefix)) return false;
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // Generic
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


        //    if(!set_topic_name("state-node-id:", singleMinion->minionState()->nodeId(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-date-time:", singleMinion->minionState()->dateAndTime(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-battery-voltage:", singleMinion->minionState()->batteryVoltage(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-nop-counter:", singleMinion->minionState()->nopCounter(), topic_map, prefix)) return false;

        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_LOG), singleMinion->minionCmd()->log());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_SET_TLM_IPADDRESS_PORT), singleMinion->minionCmd()->changeTlmAddr());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_SHUTDOWN), singleMinion->minionCmd()->shutdown());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_REBOOT), singleMinion->minionCmd()->reboot());
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // Pump
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        //    if(!set_topic_name("state-thrust-fault:", singleMinion->minionState()->thrustMotorFault(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-thrust-power:", singleMinion->minionState()->thrustMotorPower(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-thrust-enable:", singleMinion->minionState()->thrustMotorEnable(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-thrust-temperature:", singleMinion->minionState()->thrustMotorTemperature(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-thrust-speed:", singleMinion->minionState()->thrustMotorSpeed(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-thrust-current:", singleMinion->minionState()->thrustMotorCurrent(), topic_map, prefix)) return false;

        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_THRUST_POWER), singleMinion->minionCmd()->thrustMotorPower());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_THRUST_ENABLE), singleMinion->minionCmd()->thrustMotorEnable());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_THRUST_REFERENCE), singleMinion->minionCmd()->thrustMotorSetReference());
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // Azimuth
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        //    if(!set_topic_name("state-azimuth-fault:", singleMinion->minionState()->azimuthMotorFault(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-azimuth-power:", singleMinion->minionState()->azimuthMotorPower(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-azimuth-enable:", singleMinion->minionState()->azimuthMotorEnable(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-azimuth-position:", singleMinion->minionState()->azimuthMotorPosition(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-azimuth-angle:", singleMinion->minionState()->azimuthMotorAngle(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-azimuth-temperature:", singleMinion->minionState()->azimuthMotorTemperature(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-azimuth-current:", singleMinion->minionState()->azimuthMotorCurrent(), topic_map, prefix)) return false;

        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_POWER), singleMinion->minionCmd()->azimuthMotorPower());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_ENABLE), singleMinion->minionCmd()->azimuthMotorEnable());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_SET_HOME), singleMinion->minionCmd()->azimuthSetHome());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_GO_HOME), singleMinion->minionCmd()->azimuthGoHome());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_SET_ANGLE), singleMinion->minionCmd()->azimuthMotorSetReference());
        new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_MAX_SPEED), singleMinion->minionCmd()->azimuthSetMaxSpeed());
        //new_set_topic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::), singleMinion->minionCmd()->);
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // IMU
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        //    if(!set_topic_name("state-imu-yaw:", singleMinion->minionState()->imuYaw(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-imu-pitch:", singleMinion->minionState()->imuPitch(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-imu-roll:", singleMinion->minionState()->imuRoll(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-imu-xGyro:", singleMinion->minionState()->imuXGyro(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-imu-yGyro:", singleMinion->minionState()->imuYGyro(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-imu-zGyro:", singleMinion->minionState()->imuZGyro(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-imu-temperature:", singleMinion->minionState()->imuTemperature(), topic_map, prefix)) return false;
        // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        // GPS
        //    // ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        //    if(!set_topic_name("state-gps-latitude:", singleMinion->minionState()->gpsLatitude(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-gps-longitude:", singleMinion->minionState()->gpsLongitude(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-gps-fix:", singleMinion->minionState()->gpsFixQuality(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-gps-nSatellites:", singleMinion->minionState()->gpsNSatellite(), topic_map, prefix)) return false;
        //    if(!set_topic_name("state-gps-altitude:", singleMinion->minionState()->gpsAltitude(), topic_map, prefix)) return false;

        //    if(!wrongTopicName.isEmpty()){
        //        qDebug() << "Topic named " << wrongTopicName << " is not present in the configuration file or is not spelled properly.";
        //        return false;
        //    }
    }
    return true;
}

bool DataSourceUdp::is_connected() const
{
    return m_is_connected;
}

void DataSourceUdp::set_is_connected(bool newIs_connected)
{
    if (m_is_connected == newIs_connected)
        return;
    m_is_connected = newIs_connected;
    emit is_connectedChanged();
}

SwampStatus *DataSourceUdp::swamp_status()
{
    return &m_swamp_status;
}

bool DataSourceUdp::set_topic_name(QString tn, DoubleVariable *dv, QMap<QString, QString> &topic_map, QString prefix)
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

bool DataSourceUdp::set_topic_name(QString tn, IntVariable *iv, QMap<QString, QString> &topic_map, QString prefix)
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

void DataSourceUdp::new_set_topic_name(QString tn, IntVariable *iv)
{
    iv->setTopic_name(tn);
}

void DataSourceUdp::new_set_topic_name(QString tn, DoubleVariable *dv)
{
    dv->setTopic_name(tn);
}

void DataSourceUdp::new_set_topic_name(QString tn, StringVariable *sv)
{
    sv->setTopic_name(tn);
}

bool DataSourceUdp::set_topic_name(QString tn, StringVariable *sv, QMap<QString, QString> &topic_map, QString prefix)
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
