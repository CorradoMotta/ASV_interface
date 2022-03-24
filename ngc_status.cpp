#include "ngc_status.h"

NGC_status::NGC_status(QObject *parent)
    : QObject{parent}
{

}

DoubleVariable *NGC_status::psi()
{
    return &m_psi;
}
