#include "gps_ahrs_status.h"
#include <QDebug>

GPS_AHRS_status::GPS_AHRS_status(QObject *parent)
    : QObject{parent}
{
    // do subscribes
    m_longitude.setSubscribe(true);
    m_latitude.setSubscribe(true);
}

DoubleVariable *GPS_AHRS_status::longitude()
{
    return &m_longitude;
}

DoubleVariable *GPS_AHRS_status::latitude()
{
    return &m_latitude;
}