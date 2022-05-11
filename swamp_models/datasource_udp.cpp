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
        bool isUdpConnected = m_udpSocket->bind(QHostAddress::LocalHost, 7750);
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
    m_udpSocket->writeDatagram(value.toUtf8(), QHostAddress::LocalHost, 50367);
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
