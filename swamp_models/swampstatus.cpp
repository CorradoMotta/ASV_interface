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

Minion *SwampStatus::minion_1()
{
    return &m_minion_1;
}

Minion *SwampStatus::minion_2()
{
    return &m_minion_2;
}

Minion *SwampStatus::minion_3()
{
    return &m_minion_3;
}

Minion *SwampStatus::minion_4()
{
    return &m_minion_4;
}
