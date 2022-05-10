/*************************************************************************
 *
 * This class is used to separate the underlying data from the cpp model
 * that will be exposed to QML. In this way, we can create multiple
 * DataSource classes that are fetching our data from different sources
 * (which can be a mqtt connection, a UDP or TCP socket, a file etc.
 *
 *************************************************************************/

#ifndef DataSource_UDP_H
#define DataSource_UDP_H

#include <QObject>
#include <swamp_models/swampstatus.h>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttSubscription>
#include <QTimer>
#include "data/stringvariable.h"
#include <swamp_models/datasource.h>
#include <QUdpSocket>
#include <data/HciNgiInterface.h>

//const double PI = 3.1415926535;
typedef QMap<QString, StringVariable*> StringMap;
typedef QMap<QString, DoubleVariable*> DoubleMap;
typedef QMap<QString, IntVariable*> IntMap;

class DataSourceUdp : public DataSource
{

    Q_OBJECT
    Q_PROPERTY(bool is_connected READ is_connected WRITE set_is_connected NOTIFY is_connectedChanged)
    Q_PROPERTY(SwampStatus* swamp_status READ swamp_status NOTIFY swamp_statusChanged)

public:

    explicit DataSourceUdp(QObject *parent = nullptr);

    // TODO doing a base class for all DataSource with the method there available for all?
    // in that case also swampstatus would need a base class or a different name.
    Q_INVOKABLE void setConnection();
    Q_INVOKABLE virtual void publishMessage(const QString &topic, const QString &message);

    bool is_connected() const;
    void set_is_connected(bool newIs_connected);
    void publish_topic();
    SwampStatus *swamp_status();

    virtual bool set_cfg(QString filename = "");

    /**
     * Set the topic name to a double variable.
     *
     * @param tn QString for the topic name.
     * @param dv Pointer to the double variable.
     * @param topic_map Reference to the QMap that stores all variables.
     * @param prefix Prefix to attach to the topic name (e.g. "CNR-INM/swamp/").
     * @return true if the topic name is set properly, false otherwise.
     */
    bool set_topic_name(QString tn, DoubleVariable *dv, QMap<QString, QString> &topic_map, QString prefix);
    bool set_topic_name(QString tn, IntVariable *iv, QMap<QString, QString> &topic_map, QString prefix);
    bool set_topic_name(QString tn, StringVariable *sv, QMap<QString, QString> &topic_map, QString prefix);
    void send_new_timestamp(double value);
    void new_set_topic_name(QString tn, IntVariable *iv);
    void new_set_topic_name(QString tn, DoubleVariable *dv);
    void new_set_topic_name(QString tn, StringVariable *sv);

    void handleNgcPacket(QTextStream& in);
    void handleMinionPacket(int MinionId, QTextStream &in);
signals:

    void is_connectedChanged();
    void swamp_statusChanged();

private slots:

    void connectionEstablished();
    void handleDisconnected();
    void handleMessage();
    void update_ts_from_local();
    void update_ts_from_vehicle();

private:

    Q_DISABLE_COPY(DataSourceUdp)
    StringMap m_string_map;
    DoubleMap m_double_map;
    IntMap m_int_map;
    QTimer *m_timer;
    double m_count_timer;
    QMqttClient *m_client;
    QUdpSocket *m_udpSocket;
    bool m_is_connected;
    SwampStatus m_swamp_status;
};

#endif // DataSource_UDP_H
