#ifndef TIME_STATUS_H
#define TIME_STATUS_H

#include <QObject>
#include <data/doublevariable.h>
#include <data/stringvariable.h>

class Time_status : public QObject
{
    Q_OBJECT

    Q_PROPERTY(DoubleVariable* timestamp READ timestamp NOTIFY timestampChanged)
    Q_PROPERTY(DoubleVariable* hmi_timestamp READ hmi_timestamp NOTIFY hmi_timestampChanged)
    Q_PROPERTY(StringVariable* dateTime READ dateTime NOTIFY dateTimeChanged)

public:
    explicit Time_status(QObject *parent = nullptr);

    DoubleVariable *timestamp();
    DoubleVariable *hmi_timestamp();
    StringVariable *dateTime();

signals:
    void timestampChanged();
    void hmi_timestampChanged();
    void dateTimeChanged();

private:
    DoubleVariable m_timestamp;
    DoubleVariable m_hmi_timestamp;
    StringVariable m_dateTime;
};

#endif // TIME_STATUS_H
