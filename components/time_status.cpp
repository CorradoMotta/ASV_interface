#include "time_status.h"

Time_status::Time_status(QObject *parent)
    : QObject{parent}
{
    m_timestamp.setSubscribe(true);
    m_dateTime.setSubscribe(true);
}

DoubleVariable *Time_status::timestamp()
{
    return &m_timestamp;
}

DoubleVariable *Time_status::hmi_timestamp()
{
    return &m_hmi_timestamp;
}

StringVariable *Time_status::dateTime()
{
    return &m_dateTime;
}

