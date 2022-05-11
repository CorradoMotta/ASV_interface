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
#include <QTimer>
#include <QUdpSocket>

#include <swamp_models/swampstatus.h>
#include <swamp_models/datasource.h>
#include <data/HciNgiInterface.h>

class DataSourceUdp : public DataSource
{

    Q_OBJECT
    Q_PROPERTY(bool is_connected READ is_connected WRITE set_is_connected NOTIFY is_connectedChanged)
    Q_PROPERTY(SwampStatus* swamp_status READ swamp_status NOTIFY swamp_statusChanged)

public:

    explicit DataSourceUdp(QObject *parent = nullptr);

    Q_INVOKABLE virtual void setConnection();
    Q_INVOKABLE virtual void publishMessage(const QString &topic, const QString &message);
    virtual bool set_cfg(QString filename = "");

    bool is_connected() const;
    void set_is_connected(bool newIs_connected);
    SwampStatus *swamp_status();

    void send_new_timestamp(double value);
    void handleNgcPacket(QTextStream& in);
    void handleMinionPacket(int MinionId, QTextStream &in);
signals:

    void is_connectedChanged();
    void swamp_statusChanged();

private slots:

    void handleDisconnected();
    void handleMessage();
    void update_ts_from_local();
    void update_ts_from_vehicle();

private:

    Q_DISABLE_COPY(DataSourceUdp)
    QTimer *m_timer;
    double m_count_timer;
    QUdpSocket *m_udpSocket;
    bool m_is_connected;
    SwampStatus m_swamp_status;
};

#endif // DataSource_UDP_H
