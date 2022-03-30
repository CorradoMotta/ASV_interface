#include "swamp_motor_status.h"

Swamp_motor_status::Swamp_motor_status(QObject *parent)
    : QObject{parent}
{

}

Motor_status *Swamp_motor_status::f1()
{
    return &m_f1;
}

Motor_status *Swamp_motor_status::f2()
{
    return &m_f2;
}

Motor_status *Swamp_motor_status::f3()
{
    return &m_f3;
}

Motor_status *Swamp_motor_status::f4()
{
    return &m_f4;
}
