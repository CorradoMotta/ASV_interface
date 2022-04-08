#ifndef TIME_STATUS_H
#define TIME_STATUS_H

#include <QObject>
#include <data/doublevariable.h>

class Time_status : public QObject
{
    Q_OBJECT

    Q_PROPERTY(DoubleVariable* timestamp READ timestamp NOTIFY timestampChanged)
    Q_PROPERTY(DoubleVariable* hmi_timestamp READ hmi_timestamp NOTIFY hmi_timestampChanged)

public:
    explicit Time_status(QObject *parent = nullptr);

    DoubleVariable *timestamp();
    DoubleVariable *hmi_timestamp();

signals:
    void timestampChanged();
    void hmi_timestampChanged();

private:
    DoubleVariable m_timestamp;
    DoubleVariable m_hmi_timestamp;
};

#endif // TIME_STATUS_H
