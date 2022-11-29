#include "minion_command.h"

MinionCommand::MinionCommand(QObject *parent)
    : QObject{parent}
{

}

TopicVariable *MinionCommand::nop()
{
    return &m_nop;
}

TopicVariable *MinionCommand::shutdown()
{
    return &m_shutdown;
}

TopicVariable *MinionCommand::reboot()
{
    return &m_reboot;
}

TopicVariable *MinionCommand::changeTlmAddr()
{
    return &m_changeTlmAddr;
}

TopicVariable *MinionCommand::ipAddr()
{
    return &m_ipAddr;
}

TopicVariable *MinionCommand::udpPort()
{
    return &m_udpPort;
}

TopicVariable *MinionCommand::enableDebugLog()
{
    return &m_enableDebugLog;
}

TopicVariable *MinionCommand::setDigital()
{
    return &m_setDigital;
}

TopicVariable *MinionCommand::setAnalog()
{
    return &m_setAnalog;
}

TopicVariable *MinionCommand::thrustMotorPower()
{
    return &m_thrustMotorPower;
}

TopicVariable *MinionCommand::thrustMotorEnable()
{
    return &m_thrustMotorEnable;
}

NGC_variable *MinionCommand::thrustMotorSetReference()
{
    return &m_thrustMotorSetReference;
}

TopicVariable *MinionCommand::azimuthMotorPower()
{
    return &m_azimuthMotorPower;
}

TopicVariable *MinionCommand::azimuthSetMaxSpeed()
{
    return &m_azimuthSetMaxSpeed;
}

TopicVariable *MinionCommand::azimuthSetHome()
{
    return &m_azimuthSetHome;
}

TopicVariable *MinionCommand::azimuthGoHome()
{
    return &m_azimuthGoHome;
}

NGC_variable *MinionCommand::azimuthMotorSetReference()
{
    return &m_azimuthMotorSetReference;
}

TopicVariable *MinionCommand::azimuthMotorSetRefTick()
{
    return &m_azimuthMotorSetRefTick;
}

TopicVariable *MinionCommand::azimuthMotorEnable()
{
    return &m_azimuthMotorEnable;
}

TopicVariable *MinionCommand::log()
{
    return &m_log;
}
