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
    // set socket info and connections


    m_ground_timestamp.setName("CNR-INM/ground/HMI/timeStamp");
    m_swamp_timestap.setName("CNR-INM/swamp/HMI/timeStamp");
    connect(m_client, &QMqttClient::connected, this, &DataSource::connectionEstablished);
    connect(m_client, &QMqttClient::messageReceived, this, &DataSource::handleMessage);

    //-----------------------------------------------------------------------------------
    // trigger timer for HMI timestamps
    //-----------------------------------------------------------------------------------

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

    QMap<QString, QString> topic_map;
    QTextStream in(&file);
    while (!in.atEnd()) {
        QStringList line = in.readLine().split(QRegExp("\\s+"));
        if(line.size() == 2){
            topic_map[line[0].trimmed()] = line[1].trimmed();
        }

        //RR-AZM-power-command:
    }
    // ready to populate my data structs
    m_client->setPort(topic_map["Broker-port:"].toUInt());
    m_client->setHostname(topic_map["Broker-address:"]);

    m_swamp_status.gps_ahrs_status()->latitude()->setTopic_name("CNR-INM/swamp/" + topic_map["GPS-AHRS-latitude:"]);
    m_swamp_status.gps_ahrs_status()->longitude()->setTopic_name("CNR-INM/swamp/" + topic_map["GPS-AHRS-longitude:"]);
    m_swamp_status.ngc_status()->psi()->setTopic_name("CNR-INM/swamp/" + topic_map["ngc-pose-psi-act:"]);

    // TODO WHY IN REF IF IT IS MANUAL? Force panel
    m_swamp_status.ngc_status()->fu()->ref()->setTopic_name("CNR-INM/swamp/" + topic_map["ngc-force-fu-man:"]);
    m_swamp_status.ngc_status()->fv()->ref()->setTopic_name("CNR-INM/swamp/" + topic_map["ngc-force-fv-man:"]);
    m_swamp_status.ngc_status()->tr()->ref()->setTopic_name("CNR-INM/swamp/" + topic_map["ngc-force-tr-man:"]);

    // engine panel
    m_swamp_status.motor_status()->f1()->thr_enable()->setTopic_name("CNR-INM/swamp/" + topic_map["FL-THR-enable-command:"]);
    m_swamp_status.motor_status()->f1()->azm_enable()->setTopic_name("CNR-INM/swamp/" + topic_map["FL-AZM-enable-command:"]);
    m_swamp_status.motor_status()->f1()->thr_power()->setTopic_name("CNR-INM/swamp/" + topic_map["FL-THR-power-command:"]);
    m_swamp_status.motor_status()->f1()->azm_power()->setTopic_name("CNR-INM/swamp/" + topic_map["FL-AZM-power-command:"]);

    m_swamp_status.motor_status()->f2()->thr_enable()->setTopic_name("CNR-INM/swamp/" + topic_map["FR-THR-enable-command:"]);
    m_swamp_status.motor_status()->f2()->azm_enable()->setTopic_name("CNR-INM/swamp/" + topic_map["FR-AZM-enable-command:"]);
    m_swamp_status.motor_status()->f2()->thr_power()->setTopic_name("CNR-INM/swamp/" + topic_map["FR-THR-power-command:"]);
    m_swamp_status.motor_status()->f2()->azm_power()->setTopic_name("CNR-INM/swamp/" + topic_map["FR-AZM-power-command:"]);

    m_swamp_status.motor_status()->f3()->thr_enable()->setTopic_name("CNR-INM/swamp/" + topic_map["RL-THR-enable-command:"]);
    m_swamp_status.motor_status()->f3()->azm_enable()->setTopic_name("CNR-INM/swamp/" + topic_map["RL-AZM-enable-command:"]);
    m_swamp_status.motor_status()->f3()->thr_power()->setTopic_name("CNR-INM/swamp/" + topic_map["RL-THR-power-command:"]);
    m_swamp_status.motor_status()->f3()->azm_power()->setTopic_name("CNR-INM/swamp/" + topic_map["RL-AZM-power-command:"]);

    m_swamp_status.motor_status()->f4()->thr_enable()->setTopic_name("CNR-INM/swamp/" + topic_map["RR-THR-enable-command:"]);
    m_swamp_status.motor_status()->f4()->azm_enable()->setTopic_name("CNR-INM/swamp/" + topic_map["RR-AZM-enable-command:"]);
    m_swamp_status.motor_status()->f4()->thr_power()->setTopic_name("CNR-INM/swamp/" + topic_map["RR-THR-power-command:"]);
    m_swamp_status.motor_status()->f4()->azm_power()->setTopic_name("CNR-INM/swamp/" + topic_map["RR-AZM-power-command:"]);

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
