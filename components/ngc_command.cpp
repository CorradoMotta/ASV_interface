#include "NGC_command.h"

NGC_command::NGC_command(QObject *parent)
    : QObject{parent}
{

}

TopicVariable *NGC_command::gcWorkingMode()
{
    return &m_gcWorkingMode;
}

TopicVariable *NGC_command::thrustMappingManualMode()
{
    return &m_thrustMappingManualMode;
}

TopicVariable *NGC_command::thrustMappingAutoMode()
{
    return &m_thrustMappingAutoMode;
}

TopicVariable *NGC_command::rpmAlpha()
{
    return &m_rpmAlpha;
}

TopicVariable *NGC_command::forceTorque()
{
    return &m_forceTorque;
}

NGC_variable *NGC_command::ngcEnable()
{
    return &m_ngcEnable;
}

TopicVariable *NGC_command::setLog()
{
return &m_setLog;
}

TopicVariable *NGC_command::setRobotHome()
{
    return &m_setRobotHome;
}

TopicVariable *NGC_command::setLatLon()
{
    return &m_setLatLon;
}

TopicVariable *NGC_command::setXY()
{
    return &m_setXY;
}

TopicVariable *NGC_command::setLineLatLon()
{
    return &m_setLineLatLon;
}

TopicVariable *NGC_command::setXYLine()
{
    return &m_setXYLine;
}

TopicVariable *NGC_command::setYawGSPar()
{
    return &m_setYawGSPar;
}

TopicVariable *NGC_command::setHeadingPiPar()
{
    return &m_setHeadingPiPar;
}

TopicVariable *NGC_command::setSegment()
{
    return &m_setSegment;
}

TopicVariable *NGC_command::setSegmentToggle()
{
    return &m_setSegmentToggle;
}

TopicVariable *NGC_command::setLFPar()
{
    return &m_setLFPar;
}

TopicVariable *NGC_command::setPFLatLon()
{
    return &m_setPFLatLon;
}

TopicVariable *NGC_command::setPFPar()
{
    return &m_setPFPar;
}

TopicVariable *NGC_command::stopFileCmd()
{
    return &m_stopFileCmd;
}

TopicVariable *NGC_command::startFileCmd()
{
    return &m_startFileCmd;
}

TopicVariable *NGC_command::resumeFileCmd()
{
    return &m_resumeFileCmd;
}
NGC_variable *NGC_command::surge()
{
    return &m_surge;
}

NGC_variable *NGC_command::sway()
{
    return &m_sway;
}

NGC_variable *NGC_command::yaw()
{
    return &m_yaw;
}

NGC_variable *NGC_command::heading()
{
    return &m_heading;
}
