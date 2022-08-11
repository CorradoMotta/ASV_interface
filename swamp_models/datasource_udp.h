/*************************************************************************
 *
 * This class is used to separate the underlying data from the cpp model
 * that will be exposed to QML. In this way, we can create multiple
 * DataSource classes that are fetching our data from different sources
 * (which can be a mqtt connection, a UDP or TCP socket, a file etc.
 *
 * Author: Corrado Motta
 * Date: 05/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

#ifndef DataSource_UDP_H
#define DataSource_UDP_H

#include <QUdpSocket>
#include <data/HciNgiInterface.h>
#include <swamp_models/datasource.h>
#include <QSettings>

typedef HciNgiInterface::NgcTelemetryPacket hciEnum;

struct Address{
    QHostAddress ip_addr;
    int port_addr;
};

class DataSourceUdp : public DataSource
{

public:

    explicit DataSourceUdp(QObject *parent = nullptr);

    // virtual methods
    Q_INVOKABLE virtual void setConnection();
    Q_INVOKABLE virtual void publishMessage(const QString &identifier, const QString &message);
    virtual bool set_cfg(QString filename = "");

    // class methods
    void handleNgcPacket(QTextStream& in);
    void handleMinionPacket(int MinionId, QTextStream &in);
    bool checkConfKey(QString key, QSettings &settings);

private slots:

    void handleMessage();
    void update_ts_from_local();

private:

    Q_DISABLE_COPY(DataSourceUdp)
    QTimer *m_timer;
    double m_count_timer;
    bool isBound;
    QUdpSocket *m_udpSocket;
    Address m_HCIAddr;
    Address m_NGCAddr;
    QList<int> m_lastTime;
    QList<int> m_oldTimeMs;

};

#endif // DataSource_UDP_H
