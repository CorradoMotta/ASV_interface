#include "swampstatus.h"

SwampStatus::SwampStatus(QObject *parent)
    : QObject{parent}
{
}

GPS_AHRS_status *SwampStatus::gps_ahrs_status()
{
    return &m_gps_ahrs_status;
}

NGC_status *SwampStatus::ngc_status()
{
    return &m_ngc_status;
}

Swamp_motor_status *SwampStatus::motor_status()
{
    return &m_motor_status;
}

Time_status *SwampStatus::time_status()
{
    return &m_time_status;
}

Minion *SwampStatus::minion_fl()
{
    return &m_minion_fl;
}

Minion *SwampStatus::minion_fr()
{
    return &m_minion_fr;
}

Minion *SwampStatus::minion_rl()
{
    return &m_minion_rl;
}

Minion *SwampStatus::minion_rr()
{
    return &m_minion_rr;
}

Conf *SwampStatus::conf()
{
    return &m_conf;
}
