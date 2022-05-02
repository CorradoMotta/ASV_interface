#include "minion_command.h"

MinionCommand::MinionCommand(QObject *parent)
    : QObject{parent}
{

}

IntVariable *MinionCommand::nop()
{
    return &m_nop;
}

IntVariable *MinionCommand::shutdown()
{
    return &m_shutdown;
}

IntVariable *MinionCommand::reboot()
{
    return &m_reboot;
}

IntVariable *MinionCommand::changeTlmAddr()
{
    return &m_changeTlmAddr;
}

IntVariable *MinionCommand::ipAddr()
{
    return &m_ipAddr;
}

IntVariable *MinionCommand::udpPort()
{
    return &m_udpPort;
}

IntVariable *MinionCommand::enableDebugLog()
{
    return &m_enableDebugLog;
}

IntVariable *MinionCommand::setDigital()
{
    return &m_setDigital;
}

IntVariable *MinionCommand::setAnalog()
{
    return &m_setAnalog;
}

IntVariable *MinionCommand::thrustMotorPower()
{
    return &m_thrustMotorPower;
}

IntVariable *MinionCommand::thrustMotorEnable()
{
    return &m_thrustMotorEnable;
}

DoubleVariable *MinionCommand::thrustMotorSetReference()
{
    return &m_thrustMotorSetReference;
}

IntVariable *MinionCommand::azimuthMotorPower()
{
    return &m_azimuthMotorPower;
}

IntVariable *MinionCommand::azimuthSetMaxSpeed()
{
    return &m_azimuthSetMaxSpeed;
}

IntVariable *MinionCommand::azimuthSetHome()
{
    return &m_azimuthSetHome;
}

IntVariable *MinionCommand::azimuthGoHome()
{
    return &m_azimuthGoHome;
}

DoubleVariable *MinionCommand::azimuthMotorSetReference()
{
    return &m_azimuthMotorSetReference;
}

IntVariable *MinionCommand::azimuthMotorSetRefTick()
{
    return &m_azimuthMotorSetRefTick;
}

IntVariable *MinionCommand::azimuthMotorEnable()
{
    return &m_azimuthMotorEnable;
}

IntVariable *MinionCommand::log()
{
    return &m_log;
}
