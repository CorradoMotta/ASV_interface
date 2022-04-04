#include "ngc_status.h"

NGC_status::NGC_status(QObject *parent)
    : QObject{parent}
{
    // do subscribes
    m_psi.setSubscribe(true);
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
