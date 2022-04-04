#ifndef TIMESTATUS_H
#define TIMESTATUS_H
#include <data/intvariable.h>

class TimeStatus
{
public:
    TimeStatus();

    IntVariable *timestamp();

private:
    IntVariable m_timestamp;
};

#endif // TIMESTATUS_H
