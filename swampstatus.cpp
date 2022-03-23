#include "swampstatus.h"

SwampStatus::SwampStatus(QObject *parent)
    : QObject{parent}
{

}

GPS_AHRS_status *SwampStatus::gps_ahrs_status()
{
    return &m_gps_ahrs_status;
}
