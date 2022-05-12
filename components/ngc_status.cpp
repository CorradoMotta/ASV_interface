#include "ngc_status.h"

NGC_status::NGC_status(QObject *parent)
    : QObject{parent}
{
    // do subscribes
    m_psi.setSubscribe(true);
    m_altitude.setSubscribe(true);
}

DoubleVariable *NGC_status::psi()
{
    return &m_psi;
}

NGC_variable *NGC_status::fu()
{
    return &m_fu;
}

NGC_variable *NGC_status::fv()
{
    return &m_fv;
}

NGC_variable *NGC_status::fw()
{
    return &m_fw;
}

NGC_variable *NGC_status::tr()
{
    return &m_tr;
}

DoubleVariable *NGC_status::altitude()
{
    return &m_altitude;
}

IntVariable *NGC_status::gcWorkingMode()
{
    return &m_gcWorkingMode;
}

IntVariable *NGC_status::thrustMappingManualMode()
{
    return &m_thrustMappingManualMode;
}

IntVariable *NGC_status::thrustMappingAutoMode()
{
    return &m_thrustMappingAutoMode;
}
