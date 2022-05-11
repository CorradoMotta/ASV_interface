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

#include <QUdpSocket>
#include <data/HciNgiInterface.h>
#include <swamp_models/datasource.h>

class DataSourceUdp : public DataSource
{

public:

    explicit DataSourceUdp(QObject *parent = nullptr);

    // virtual methods
    Q_INVOKABLE virtual void setConnection();
    Q_INVOKABLE virtual void publishMessage(const QString &identifier, const QString &message);
    virtual bool set_cfg(QString filename = "");

    // class methods
    void send_new_timestamp(double value);
    void handleNgcPacket(QTextStream& in);
    void handleMinionPacket(int MinionId, QTextStream &in);

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
};

#endif // DataSource_UDP_H
