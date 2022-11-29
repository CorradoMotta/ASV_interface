#include "ngc.h"

NGC::NGC(QObject *parent)
    : QObject{parent}
{

}

NGC_command *NGC::ngcCmd()
{
    return &m_ngcCmd;
}

NGC_status *NGC::ngc_status()
{
    return &m_ngc_status;
}
