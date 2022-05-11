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
      m_udpSocket{new QUdpSocket(this)}
{ 
    //m_timer->start(100);
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
    //m_client->publish(m_swamp_status.time_status()->hmi_timestamp()->topic_name(), str_value.toUtf8());
}

void DataSourceUdp::setConnection()
{
    if(!m_is_connected){
        bool isUdpConnected = m_udpSocket->bind(QHostAddress("192.168.29.244"), 4969);
        if (isUdpConnected){
            connect(m_udpSocket, &QUdpSocket::readyRead, this, &DataSourceUdp::handleMessage);
            //connect(m_timer, &QTimer::timeout, this, &DataSourceUdp::update_ts_from_local); //start sending heartbeat
            set_is_connected(true);
        }
    }else{
        qDebug() << "Cannot disconnect a UDP connection!";
    }
}

void DataSourceUdp::publishMessage(const QString &identifier, const QString &message)
{
    QString value = identifier + " " + message;
    qDebug() << "sending : " << value;
    m_udpSocket->writeDatagram(value.toUtf8(), QHostAddress("192.168.29.99"), 4968);
}

void DataSourceUdp::handleNgcPacket(QTextStream &in)
{
    //TODO
    //    int secondNumber;
    //    int thirdNumber;
    //    //in >> firstNumber;             // firstNumber == 80
    //    in >> secondNumber;
    //    in >> thirdNumber;
    //qDebug() << qSetRealNumberPrecision( 10 ) << secondNumber << " - " << thirdNumber;
}

void DataSourceUdp::handleMinionPacket(int MinionId, QTextStream &in)
{

    Minion* singleMinion;
    switch(MinionId){
    case NgcTelemetryPacket::MINION_FL_TLM:
        //qDebug() << "Receiving a Minion FL packet";
        singleMinion = m_swamp_status.minion_fl();
        //qDebug() << in;
        break;
    case NgcTelemetryPacket::MINION_FR_TLM:
        //qDebug() << "Receiving a Minion FR packet";
        singleMinion = m_swamp_status.minion_fr();
        //qDebug() << in;
        break;
    case NgcTelemetryPacket::MINION_RL_TLM:
        //qDebug() << "Receiving a Minion RL packet";
        singleMinion = m_swamp_status.minion_rl();
        //qDebug() << in;
        break;
    case NgcTelemetryPacket::MINION_RR_TLM:
        //qDebug() << "Receiving a Minion RR packet";
        singleMinion = m_swamp_status.minion_rr();
        //qDebug() << in;
        break;
    default:
        qDebug() << "Following packet identifier not recognised: " << MinionId;
        break;
    }

    double doubleContainer;
    int intContainer;

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
    in >> intContainer; singleMinion->minionState()->azimuthMotorTemperature()->setValue(intContainer); //
    in >> intContainer; singleMinion->minionState()->azimuthMotorCurrent()->setValue(intContainer);
    in >> doubleContainer; singleMinion->minionState()->imuYaw()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuPitch()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuRoll()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuXGyro()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuYGyro()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuZGyro()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuTemperature()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->imuCalibrationStatus()->setValue(doubleContainer); //unsigned8
    in >> intContainer; singleMinion->minionState()->gpsDate()->setValue(intContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsTime()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsLatitude()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsLongitude()->setValue(doubleContainer);
    in >> intContainer; singleMinion->minionState()->gpsFixQuality()->setValue(intContainer);
    in >> intContainer; singleMinion->minionState()->gpsNSatellite()->setValue(intContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsHDOP()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsAltitude()->setValue(doubleContainer);
    in >> doubleContainer; singleMinion->minionState()->gpsHeightGeoid()->setValue(doubleContainer);

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
            //qDebug() << "\n\n new Packet  "<< datagram.data();
            // Check which packet it is
            int packetIndex;
            in >> packetIndex;
            // call appropriate function
            if(packetIndex == NgcTelemetryPacket::NGC_TLM) handleNgcPacket(in); //qDebug() << //"Receive NGC packet" << datagram.data(); handleNgcPacket(in);
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
        minionId = QString::number(var);
        if(minionId == "0") singleMinion = m_swamp_status.minion_fl();
        else if(minionId == "1") singleMinion = m_swamp_status.minion_fr();
        else if(minionId == "2") singleMinion = m_swamp_status.minion_rl();
        else if(minionId == "3") singleMinion = m_swamp_status.minion_rr();

        singleMinion->minionCmd()->log()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_LOG));
        singleMinion->minionCmd()->changeTlmAddr()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_SET_TLM_IPADDRESS_PORT));
        singleMinion->minionCmd()->shutdown()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_SHUTDOWN));
        singleMinion->minionCmd()->reboot()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_REBOOT));
        singleMinion->minionCmd()->thrustMotorPower()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_THRUST_POWER));
        singleMinion->minionCmd()->thrustMotorEnable()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_THRUST_ENABLE));
        singleMinion->minionCmd()->thrustMotorSetReference()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_THRUST_REFERENCE));
        singleMinion->minionCmd()->azimuthMotorPower()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_POWER));
        singleMinion->minionCmd()->azimuthMotorEnable()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_ENABLE));
        singleMinion->minionCmd()->azimuthSetHome()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_SET_HOME));
        singleMinion->minionCmd()->azimuthGoHome()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_GO_HOME));
        singleMinion->minionCmd()->azimuthMotorSetReference()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_SET_ANGLE));
        singleMinion->minionCmd()->azimuthSetMaxSpeed()->setTopic_name(minionCmd + " " + minionId + " " +QString::number(MinionNgcCmd::MINION_AZIMUTH_MAX_SPEED));
    }
    return true;
}
