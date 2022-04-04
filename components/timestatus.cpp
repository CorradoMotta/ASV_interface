#include "timestatus.h"

TimeStatus::TimeStatus()
{
    m_timestamp.setSubscribe(true);
}

IntVariable *TimeStatus::timestamp()
{
    return &m_timestamp;
}
