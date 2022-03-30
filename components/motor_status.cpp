#include "motor_status.h"

Motor_status::Motor_status(QObject *parent)
    : QObject{parent}
{

}

IntVariable *Motor_status::thr_power()
{
    return &m_thr_power;
}

IntVariable *Motor_status::thr_enable()
{
    return &m_thr_enable;
}

IntVariable *Motor_status::azm_power()
{
    return &m_azm_power;
}

IntVariable *Motor_status::azm_enable()
{
    return &m_azm_enable;
}
