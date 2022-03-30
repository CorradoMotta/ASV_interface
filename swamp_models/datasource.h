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
#include <swamp_models/swampstatus.h>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttSubscription>
#include <QTimer>

const double PI = 3.1415926535;

class DataSource : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool is_connected READ is_connected WRITE set_is_connected NOTIFY is_connectedChanged)
    Q_PROPERTY(SwampStatus* swamp_status READ swamp_status NOTIFY swamp_statusChanged)

public:
    explicit DataSource(QObject *parent = nullptr);

    // TODO doing a base class for all Datasource with the method there available for all?
    // in that case also swampstatus would need a base class or a different name.
    Q_INVOKABLE void setConnection();
    Q_INVOKABLE void publishMessage(const QString &topic, const QString &message);

    bool is_connected() const;
    void set_is_connected(bool newIs_connected);
    void publish_topic();
    void send_timestamp(double value) const;
    SwampStatus *swamp_status();

signals:

    void is_connectedChanged();
    void swamp_statusChanged();

private slots:

    void connectionEstablished();
    void handleMessage(const QByteArray &message, const QMqttTopicName &topic = QMqttTopicName());
    void update();

private:
    Q_DISABLE_COPY(DataSource)
    QTimer *m_timer;
    double m_count_timer;
    QMqttClient *m_client;
    bool m_is_connected;
    QString m_timestamp;
    double m_timestamp_value;
    QMqttTopicName m_ground_timestamp;
    QMqttTopicName m_swamp_timestap;
    SwampStatus m_swamp_status;
};

#endif // DATASOURCE_H
