/*************************************************************************
 *
 * This class is used to separate the underlying data from the cpp model
 * that will be exposed to QML. In this way, we can create multiple
 * DataSource classes that are fetching our data from different sources
 * (which can be a mqtt connection, a UDP or TCP socket, a file etc.
 *
 *************************************************************************/

#ifndef DATASOURCE_H
#define DATASOURCE_H

#include <QObject>
#include <swampstatus.h>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttSubscription>
#include <QTimer>

const double PI = 3.1415926535;

class DataSource : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool is_connected READ is_connected WRITE set_is_connected NOTIFY is_connectedChanged)

public:
    explicit DataSource(QObject *parent = nullptr);

    // TODO doing a base class for all Datasource with the method there available for all?
    // in that case also swampstatus would need a base class or a different name.

    Q_INVOKABLE SwampStatus* swampData();
    Q_INVOKABLE void setConnection();
    Q_INVOKABLE void publishMessage(const QString &topic, const QString &message);

    bool is_connected() const;
    void set_is_connected(bool newIs_connected);
    void publish_topic();
    void send_timestamp(double value) const;

signals:

    void is_connectedChanged();

private slots:

    void connectionEstablished();
    void handleMessage(const QByteArray &message, const QMqttTopicName &topic = QMqttTopicName());
    void update();

private:

    QTimer *m_timer;
    double m_count_timer;
    SwampStatus* m_SwampStatus;
    QMqttClient *m_client;
    bool m_is_connected;
    QString m_timestamp;
    double m_timestamp_value;

};

#endif // DATASOURCE_H
