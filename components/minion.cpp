#include "minion.h"

Minion::Minion(QObject *parent)
    : QObject{parent}
{

}

MinionCommand *Minion::minionCmd()
{
    return &m_minionCmd;
}

MinionStatus *Minion::minionState()
{
    return &m_minionState;
}
