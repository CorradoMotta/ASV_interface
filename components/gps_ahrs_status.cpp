#include "gps_ahrs_status.h"
#include <QDebug>

GPS_AHRS_status::GPS_AHRS_status(QObject *parent)
    : QObject{parent}
{
    // do subscribes
    m_timestamp.setSubscribe(true);
    m_longitude.setSubscribe(true);
    m_latitude.setSubscribe(true);
    m_date.setSubscribe(true);
    m_time.setSubscribe(true);
    m_xGps.setSubscribe(true);
    m_yGps.setSubscribe(true);
    m_speed.setSubscribe(true);
    m_track.setSubscribe(true);
}

DoubleVariable *GPS_AHRS_status::longitude()
{
    return &m_longitude;
}

DoubleVariable *GPS_AHRS_status::latitude()
{
    return &m_latitude;
}

DoubleVariable *GPS_AHRS_status::xGps()
{
    return &m_xGps;
}

DoubleVariable *GPS_AHRS_status::yGps()
{
    return &m_yGps;
}

DoubleVariable *GPS_AHRS_status::timestamp()
{
    return &m_timestamp;
}

DoubleVariable *GPS_AHRS_status::date()
{
    return &m_date;
}

DoubleVariable *GPS_AHRS_status::time()
{
    return &m_time;
}

DoubleVariable *GPS_AHRS_status::speed()
{
    return &m_speed;
}

DoubleVariable *GPS_AHRS_status::track()
{
    return &m_track;
}
