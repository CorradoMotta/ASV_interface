#ifndef QMLMQTTCLIENT_H
#define QMLMQTTCLIENT_H

#include <QtCore/QMap>
#include <QtMqtt/QMqttClient>
#include <QtMqtt/QMqttSubscription>
#include <QTimer>
#include <GPS_AHRS_status.h>
#include <swampstatus.h>

class QmlMqttClient : public QMqttClient
{
    Q_OBJECT

    Q_PROPERTY(SwampStatus* swamp_status READ swamp_status NOTIFY swamp_statusChanged)

public:
    QmlMqttClient(QObject *parent = nullptr);
    ~QmlMqttClient();
    Q_INVOKABLE void publishMessage(const QString &topic, const QByteArray &message);
    SwampStatus *swamp_status(); // const

Q_SIGNALS:
    void newCoordinate(const QString &topic, const double &value);
    void newTimeStamp(const double &value);
    void newRotation(const QString &topic, const double &value);

    void swamp_statusChanged();

public slots:
    void connectionEstablished();
    void handleMessage(const QByteArray &message, const QMqttTopicName &topic = QMqttTopicName());
    void update();

private:
    Q_DISABLE_COPY(QmlMqttClient)
    QTimer *timer;
    double count_timer;
    QString lat_topic;
    QString lon_topic;
    QString psy_topic;
    QString timestamp;
    SwampStatus m_swamp_status;
};

#endif // QMLMQTTCLIENT_H
