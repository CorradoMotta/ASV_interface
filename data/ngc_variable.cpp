#include "ngc_variable.h"

NGC_variable::NGC_variable(QObject *parent)
    : QObject{parent}
{
    m_ref.subscribe();
}

DoubleVariable *NGC_variable::act()
{
    return &m_act;
}

DoubleVariable *NGC_variable::ref()
{
    return &m_ref;
}
