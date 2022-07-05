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
      isBound{false},
      m_udpSocket{new QUdpSocket(this)},
      m_lastTime{0,0,0,0},
      m_oldTimeMs{0,0,0,0}
{ 
    m_timer->start(500);
}

void DataSourceUdp::update_ts_from_local(){
    m_count_timer += 1;
    for (int var = 0; var < 4; ++var) {
        if(m_lastTime[var] > 16)
        {
            switch(var){
            case HciNgiInterface::NgcTelemetryPacket::MINION_FL_TLM:
                m_swamp_status.minion_fl()->minionState()->is_alive()->setValue(1);
                break;
            case HciNgiInterface::NgcTelemetryPacket::MINION_FR_TLM:
                m_swamp_status.minion_fr()->minionState()->is_alive()->setValue(1);
                break;
            case HciNgiInterface::NgcTelemetryPacket::MINION_RL_TLM:
                m_swamp_status.minion_rl()->minionState()->is_alive()->setValue(1);
                break;
            case HciNgiInterface::NgcTelemetryPacket::MINION_RR_TLM:
                m_swamp_status.minion_rr()->minionState()->is_alive()->setValue(1);
                break;
            }
        }
        m_lastTime[var] ++;
        publishMessage(m_swamp_status.time_status()->hmi_timestamp()->topic_name(), QString::number(m_count_timer));
    }
}

void DataSourceUdp::setConnection()
{
    if(!m_is_connected &&!isBound){
        bool isUdpConnected = m_udpSocket->bind(m_HCIAddr.ip_addr, m_HCIAddr.port_addr);
        if (isUdpConnected){
            connect(m_udpSocket, &QUdpSocket::readyRead, this, &DataSourceUdp::handleMessage);
            connect(m_timer, &QTimer::timeout, this, &DataSourceUdp::update_ts_from_local); //start sending heartbeat
            isBound = true;
            set_is_connected(true);
        }
    }else if(!m_is_connected && isBound){
        if(!m_timer->isActive()) m_timer->start();
        set_is_connected(true);

    }
    else{
        if(m_timer->isActive()) m_timer->stop();
        set_is_connected(false);
        //qDebug() << "Cannot disconnect a UDP connection!";
    }
}

void DataSourceUdp::publishMessage(const QString &identifier, const QString &message)
{
    QString value = identifier + " " + message + "\r\n";
    if(identifier != m_swamp_status.time_status()->hmi_timestamp()->topic_name()) qDebug() << "sending : " << value;
    //qDebug() << m_NGCAddr.ip_addr << m_NGCAddr.port_addr;
    m_udpSocket->writeDatagram(value.toUtf8(), m_NGCAddr.ip_addr, m_NGCAddr.port_addr);
}

void DataSourceUdp::handleNgcPacket(QTextStream &in)
{
    double doubleContainer;
    int intContainer;

    //GPS ASV
    in >> doubleContainer;// qDebug() << "Timestamp" << doubleContainer;//timestamp singleMinion->minionState()->nopCounter()->setValue(doubleContainer); // should be U64
    in >> intContainer; //qDebug() << "GPS date" << intContainer;//gpsdate   singleMinion->minionState()->thrustMotorFault()->setValue(intContainer);
    in >> intContainer; //qDebug() << "GPS time" << doubleContainer; //gpstime   singleMinion->minionState()->thrustMotorPower()->setValue(intContainer);
    in >> doubleContainer; m_swamp_status.gps_ahrs_status()->latitude()->setValue(doubleContainer);  //lat
    in >> doubleContainer; m_swamp_status.gps_ahrs_status()->longitude()->setValue(doubleContainer); //lon
    in >> doubleContainer; m_swamp_status.gps_ahrs_status()->xGps()->setValue(doubleContainer); // xgps TODO NOT SHOWN
    in >> doubleContainer; m_swamp_status.gps_ahrs_status()->yGps()->setValue(doubleContainer); // ygps TODO NOT SHOWN
    in >> doubleContainer; m_swamp_status.ngc_status()->psi()->setValue(doubleContainer); // psiIMU
    in >> doubleContainer; m_swamp_status.ngc_status()->phiIMU()->setValue(doubleContainer);// phiIMU
    in >> doubleContainer; m_swamp_status.ngc_status()->thetaIMU()->setValue(doubleContainer);// thetaIMU
    in >> doubleContainer; m_swamp_status.ngc_status()->rIMU()->setValue(doubleContainer);// rIMU
    in >> doubleContainer; m_swamp_status.ngc_status()->pIMU()->setValue(doubleContainer);// pIMU
    in >> doubleContainer; m_swamp_status.ngc_status()->qIMU()->setValue(doubleContainer);// qIMU

    // ASVHAT
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatX()->setValue(doubleContainer); // X position [m]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatY()->setValue(doubleContainer); // Y position [m]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatpsi()->setValue(doubleContainer); // psi orientation [rad] (HEADING)
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatu()->setValue(doubleContainer); // surge [m/s]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatv()->setValue(doubleContainer); // sway [m/s]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatr()->setValue(doubleContainer); // angular speed [rad/s]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatxDot()->setValue(doubleContainer);// xDot
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatyDot()->setValue(doubleContainer);// yDot absolute speed [m/s]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatlat()->setValue(doubleContainer);// lat
    in >> doubleContainer; m_swamp_status.ngc_status()->asvHatlon()->setValue(doubleContainer);// lon // [deg]

    // ASVREF POSITION TODO NOT SHOWN NOW
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefxRef()->setValue(doubleContainer); // xRef Set position
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefyRef()->setValue(doubleContainer); // yRef Set position
    in >> doubleContainer; m_swamp_status.ngc_status()->asvReflatRef()->setValue(doubleContainer); // latRef Set position in coordinates
    in >> doubleContainer; m_swamp_status.ngc_status()->asvReflonRef()->setValue(doubleContainer); // lonRef Set position in coordinates
    in >> doubleContainer; m_swamp_status.ngc_status()->heading()->ref()->setValue(doubleContainer); // psiRef CONTROL
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefxLref()->setValue(doubleContainer); // xLref Set line
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefyLref()->setValue(doubleContainer); // yLref Set line
    in >> doubleContainer; m_swamp_status.ngc_status()->asvReflatLref()->setValue(doubleContainer); // latLref Set line in coordinates
    in >> doubleContainer; m_swamp_status.ngc_status()->asvReflonLref()->setValue(doubleContainer); // lonLref Set line in coordinates TODO make them act and ref
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefgammaLref()->setValue(doubleContainer); // gammaLref Set gamma for line

    // ASVREF CONTROL
    in >> doubleContainer; m_swamp_status.ngc_status()->surge()->ref()->setValue(doubleContainer); // uRef CONTROL
    in >> doubleContainer; m_swamp_status.ngc_status()->sway()->ref()->setValue(doubleContainer); // vRef CONTROL
    in >> doubleContainer; m_swamp_status.ngc_status()->yaw()->ref()->setValue(doubleContainer); // rRef CONTROL


    // ASVREF FORCE SURGE

    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefXref()->setValue(doubleContainer); // XRef
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefYref()->setValue(doubleContainer); // YRef
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefNref()->setValue(doubleContainer); // Nref
    in >> doubleContainer; m_swamp_status.ngc_status()->latHomeRef()->setValue(doubleContainer); // latRef
    in >> doubleContainer; m_swamp_status.ngc_status()->lonHomeRef()->setValue(doubleContainer); // lonRef

    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefXhat()->setValue(doubleContainer); //Xhat
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefYhat()->setValue(doubleContainer); //Yhat
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefNhat()->setValue(doubleContainer); //Nhat

    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefnRef()->setValue(doubleContainer); // nRef
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefdnRef()->setValue(doubleContainer); // dnRef
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefalphaRef()->setValue(doubleContainer); // alphaRef


    // ASVREF Minion N and azimuth
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefnFL()->setValue(doubleContainer); // n[FL]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefnFR()->setValue(doubleContainer); // n[FR]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefnRR()->setValue(doubleContainer); // n[RR]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefnRL()->setValue(doubleContainer); // n[RL]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefazimuthFL()->setValue(doubleContainer); // azimuth[FL]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefazimuthFR()->setValue(doubleContainer); // azimuth[FR]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefazimuthRR()->setValue(doubleContainer); // azimuth[RR]
    in >> doubleContainer; m_swamp_status.ngc_status()->asvRefazimuthRL()->setValue(doubleContainer); // azimuth[RL]

    // MODES
    in >> intContainer; m_swamp_status.ngc_status()->ngcEnable()->ref()->setValue(intContainer); // ngcEnable TODO SHOULD BE INT?
    in >> intContainer; m_swamp_status.ngc_status()->refExecutionWorking_mode()->setValue(intContainer); // asvExecutionControl->get_working_mode()
    in >> intContainer; m_swamp_status.ngc_status()->refWorking_mode()->setValue(intContainer); // asvThrustMapping->get_working_mode(),
    in >> intContainer; m_swamp_status.ngc_status()->refManual_mode()->setValue(intContainer); // asvThrustMapping->get_manual_mode()
    in >> intContainer; m_swamp_status.ngc_status()->refAutoMode()->setValue(intContainer); // asvThrustMapping->get_autoMode()
}

void DataSourceUdp::handleMinionPacket(int MinionId, QTextStream &in)
{

    Minion* singleMinion;
    switch(MinionId){
    case HciNgiInterface::NgcTelemetryPacket::MINION_FL_TLM:
        //qDebug() << "Receiving a Minion FL packet";
        singleMinion = m_swamp_status.minion_fl();
        //singleMinion->minionState()->is_alive()->setValue(2);
        //qDebug() << in;
        break;
    case HciNgiInterface::NgcTelemetryPacket::MINION_FR_TLM:
        //qDebug() << "Receiving a Minion FR packet";
        singleMinion = m_swamp_status.minion_fr();
        //singleMinion->minionState()->is_alive()->setValue(2);
        //qDebug() << in;
        break;
    case HciNgiInterface::NgcTelemetryPacket::MINION_RL_TLM:
        //qDebug() << "Receiving a Minion RL packet";
        singleMinion = m_swamp_status.minion_rl();
        //singleMinion->minionState()->is_alive()->setValue(2);
        //qDebug() << in;
        break;
    case HciNgiInterface::NgcTelemetryPacket::MINION_RR_TLM:
        //qDebug() << "Receiving a Minion RR packet";
        singleMinion = m_swamp_status.minion_rr();
        //singleMinion->minionState()->is_alive()->setValue(2);
        //qDebug() << in;
        break;
    default:
        qDebug() << "Following packet identifier not recognised: " << MinionId;
        break;
    }

    double doubleContainer;
    int intContainer;
    QString hex;

    in >> intContainer; singleMinion->minionState()->nodeId()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->dateAndTime()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->timeMs()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->digitalInput()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->digitalOutput()->setValue(intContainer);
    in >> doubleContainer; singleMinion->minionState()->batteryVoltage()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->nopCounter()->setValue(doubleContainer); // should be U64
    in >> intContainer; singleMinion->minionState()->thrustMotorFault()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->thrustMotorPower()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->thrustMotorEnable()->setValue(intContainer);
    in >> doubleContainer; singleMinion->minionState()->thrustMotorTemperature()->setValue(doubleContainer); // should be double
    in >> doubleContainer; singleMinion->minionState()->thrustMotorSpeed()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->thrustMotorCurrent()->setValue(doubleContainer);
    in >> intContainer; singleMinion->minionState()->azimuthMotorFault()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->azimuthMotorPower()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->azimuthMotorEnable()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->azimuthMotorPosition()->setValue(intContainer);
    in >> doubleContainer; singleMinion->minionState()->azimuthMotorAngle()->setValue(doubleContainer);
    in >> intContainer; singleMinion->minionState()->azimuthMotorConfigurationStatus()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->azimuthMotorOperationStatus()->setValue(intContainer);
    in >> intContainer;    singleMinion->minionState()->azimuthMotorTemperature()->setValue(intContainer); //
    in >> intContainer;    singleMinion->minionState()->azimuthMotorCurrent()->setValue(intContainer);
    in >> doubleContainer; singleMinion->minionState()->imuYaw()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuPitch()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuRoll()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuXGyro()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuYGyro()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuZGyro()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuTemperature()->setValue(doubleContainer);
    in >> intContainer;  hex = QString("%1").arg(intContainer, 0, 16); singleMinion->minionState()->imuCalibrationStatus()->setValue(hex); //unsigned8
    in >> intContainer;    singleMinion->minionState()->gpsDate()->setValue(intContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsTime()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsLatitude()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsLongitude()->setValue(doubleContainer);
    in >> intContainer;    singleMinion->minionState()->gpsFixQuality()->setValue(intContainer);
    in >> intContainer;    singleMinion->minionState()->gpsNSatellite()->setValue(intContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsHDOP()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsAltitude()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsHeightGeoid()->setValue(doubleContainer);
    in >> intContainer; //thrustMotorPower
    in >> intContainer; // thrustmotorenable
    in >> doubleContainer; singleMinion->minionCmd()->thrustMotorSetReference()->ref()->setValue(doubleContainer);
    in >> intContainer; // azimuth power
    in >> intContainer; // azimuth enable
    in >> doubleContainer; singleMinion->minionCmd()->azimuthMotorSetReference()->ref()->setValue(doubleContainer);

    //qDebug()
    // for minion calibration

    if(singleMinion->minionState()->timeMs()->value() > m_oldTimeMs[MinionId]){
        // TODO BETTER USE SIGNALS
        m_oldTimeMs[MinionId] = singleMinion->minionState()->timeMs()->value();
        m_lastTime[MinionId] = 0;
        singleMinion->minionState()->is_alive()->setValue(2);
    }
}

void DataSourceUdp::handleMessage()
{
    //if(m_timer->isActive()) m_timer->stop();
    if (m_is_connected){
        while(m_udpSocket->hasPendingDatagrams()) {

            // receive datagram
            QNetworkDatagram datagram = m_udpSocket->receiveDatagram();
            if(!datagram.isNull()){
                // get data into a QTextStream
                QTextStream in(datagram.data());
                //qDebug() << "\n\n new Packet  "<< datagram.data();
                // Check which packet it is
                int packetIndex;
                in >> packetIndex;
                // call appropriate function
                if(packetIndex == HciNgiInterface::NgcTelemetryPacket::NGC_TLM) handleNgcPacket(in); //qDebug() << //"Received NGC packet" << datagram.data(); handleNgcPacket(in);
                else handleMinionPacket(packetIndex, in); //qDebug() << datagram.data();//handleMinionPacket(packetIndex, in);
            }
        }
    }
}

bool DataSourceUdp::set_cfg(QString filename)
{
    QFile file(filename);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        qDebug() << "Failed to open file:" << file.fileName() << "Error:" << file.errorString();
        return false;
    }

    QSettings settings("../ASV_interface/conf/conf.ini", QSettings::IniFormat);

    // UDP configuration
    settings.beginGroup("udp_addresses");
    if(checkConfKey("HCI_address", settings)) m_HCIAddr.ip_addr = QHostAddress(settings.value("HCI_address").toString()); else return false;
    if(checkConfKey("HCI_port", settings)) m_HCIAddr.port_addr = settings.value("HCI_port").toInt(); else return false;
    if(checkConfKey("NGC_address", settings)) m_NGCAddr.ip_addr = QHostAddress(settings.value("NGC_address").toString()); else return false;
    if(checkConfKey("NGC_port", settings)) m_NGCAddr.port_addr = settings.value("NGC_port").toInt(); else return false;
    settings.endGroup();

    QMap<QString, double> angleMap;
    // Minions configuration
    settings.beginGroup("minion_configuration");
    if(checkConfKey("FR_angle_offset", settings)) angleMap.insert("FR_angle_offset", settings.value("FR_angle_offset").toDouble()); else return false;
    if(checkConfKey("FL_angle_offset", settings)) angleMap.insert("FL_angle_offset", settings.value("FL_angle_offset").toDouble()); else return false;
    if(checkConfKey("RR_angle_offset", settings)) angleMap.insert("RR_angle_offset", settings.value("RR_angle_offset").toDouble()); else return false;
    if(checkConfKey("RL_angle_offset", settings)) angleMap.insert("RL_angle_offset", settings.value("RL_angle_offset").toDouble()); else return false;
    settings.endGroup();

    Minion* singleMinion;
    QString minionId;
    QString minionName;
    QString minionCmd = QString::number(HciNgiInterface::NgcCommand::MINION_CMD);

    for (int var = HciNgiInterface::NgcTelemetryPacket::MINION_FL_TLM; var < HciNgiInterface::NgcTelemetryPacket::MINION_RL_TLM+1; ++var) {
        minionId = QString::number(var);
        if(minionId == "0")      {singleMinion = m_swamp_status.minion_fl(); minionName = "FL_angle_offset"; }
        else if(minionId == "1") {singleMinion = m_swamp_status.minion_fr(); minionName = "FR_angle_offset"; }
        else if(minionId == "2") {singleMinion = m_swamp_status.minion_rr(); minionName = "RR_angle_offset"; }
        else if(minionId == "3") {singleMinion = m_swamp_status.minion_rl(); minionName = "RL_angle_offset"; }

        singleMinion->minionCmd()->log()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_LOG));
        singleMinion->minionCmd()->changeTlmAddr()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_SET_TLM_IPADDRESS_PORT));
        singleMinion->minionCmd()->shutdown()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_SHUTDOWN));
        singleMinion->minionCmd()->reboot()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_REBOOT));
        singleMinion->minionCmd()->thrustMotorPower()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_THRUST_POWER));
        singleMinion->minionCmd()->thrustMotorEnable()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_THRUST_ENABLE));
        singleMinion->minionCmd()->thrustMotorSetReference()->act()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_THRUST_REFERENCE));
        singleMinion->minionCmd()->azimuthMotorPower()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_AZIMUTH_POWER));
        singleMinion->minionCmd()->azimuthMotorEnable()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_AZIMUTH_ENABLE));
        singleMinion->minionCmd()->azimuthSetHome()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_AZIMUTH_SET_HOME));
        singleMinion->minionCmd()->azimuthGoHome()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_AZIMUTH_GO_HOME));
        singleMinion->minionCmd()->azimuthMotorSetReference()->act()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_AZIMUTH_SET_ANGLE));
        singleMinion->minionCmd()->azimuthSetMaxSpeed()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(HciNgiInterface::MinionNgcCmd::MINION_AZIMUTH_MAX_SPEED));

        // set angle value
        singleMinion->minionCmd()->azimuthMotorSetReference()->act()->setValue(angleMap.value(minionName));
    }
    //QString tlm_number = QString::number(HciNgiInterface::NgcTelemetryPacket::NGC_TLM);
    //NGC topics
    m_swamp_status.time_status()->hmi_timestamp()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::HCI_NOP));
    m_swamp_status.ngc_status()->gcWorkingMode()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_GC_WORKING_MODE));
    m_swamp_status.ngc_status()->thrustMappingManualMode()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_TM_MANUAL_MODE));
    m_swamp_status.ngc_status()->thrustMappingAutoMode()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_TM_AUTO_MODE));
    m_swamp_status.ngc_status()->rpmAlpha()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_RPM_ALPHA));
    m_swamp_status.ngc_status()->forceTorque()->setTopic_name( QString::number(HciNgiInterface::NgcCommand::SET_FORCE_TORQUE));
    m_swamp_status.ngc_status()->ngcEnable()->act()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::NGC_ENABLE));
    m_swamp_status.ngc_status()->surge()->act()->setTopic_name( QString::number(HciNgiInterface::NgcCommand::SET_SURGE));
    m_swamp_status.ngc_status()->sway()->act()->setTopic_name( QString::number(HciNgiInterface::NgcCommand::SET_SWAY));
    m_swamp_status.ngc_status()->yaw()->act()->setTopic_name( QString::number(HciNgiInterface::NgcCommand::SET_YAW));
    m_swamp_status.ngc_status()->heading()->act()->setTopic_name( QString::number(HciNgiInterface::NgcCommand::SET_HEADING));
    m_swamp_status.ngc_status()->setLog()->setTopic_name( QString::number(HciNgiInterface::NgcCommand::LOG_RESTART));

    m_swamp_status.ngc_status()->setRobotHome()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_HOME));
    m_swamp_status.ngc_status()->setLatLon()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_LAT_LON));
    m_swamp_status.ngc_status()->setXY()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_XY));
    m_swamp_status.ngc_status()->setLineLatLon()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_LINE_LAT_LON));
    m_swamp_status.ngc_status()->setXYLine()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_LINE_XY));
    m_swamp_status.ngc_status()->setYawGSPar()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_YAW_GS_PAR));
    m_swamp_status.ngc_status()->setHeadingPiPar()->setTopic_name(QString::number(HciNgiInterface::NgcCommand::SET_HEADING_PI_PAR));

    return true;
}

bool DataSourceUdp::checkConfKey(QString key, QSettings &settings)
{
    if(!settings.contains(key)){
        qDebug() << "Address key named " << key << " is not present in the configuration file or is not spelled properly.";
        return false;
    }
    return true;
}
