#include "variable.h"

Variable::Variable(QObject *parent)
    : QObject{parent},
      m_topic_name{""},
      m_updated{0},
      m_valid{0},
      m_timeStamp{0},
      m_subscribe{false}
{
}

Variable::~Variable()
{

}

const QString &Variable::topic_name() const
{
    return m_topic_name;
}

void Variable::setTopic_name(const QString &newTopic_name)
{
    if (m_topic_name == newTopic_name)
        return;
    m_topic_name = newTopic_name;
    emit topic_nameChanged();
}

int Variable::updated() const
{
    return m_updated;
}

void Variable::setUpdated(int newUpdated)
{
    if (m_updated == newUpdated)
        return;
    m_updated = newUpdated;
    emit updatedChanged();
}

int Variable::valid() const
{
    return m_valid;
}

void Variable::setValid(int newValid)
{
    if (m_valid == newValid)
        return;
    m_valid = newValid;
    emit validChanged();
}

void Variable::setTimeStamp(uint64 newTimeStamp)
{
    m_timeStamp = newTimeStamp;
}

uint64 Variable::timeStamp() const
{
    return m_timeStamp;
}

bool Variable::subscribe() const
{
    return m_subscribe;
}

void Variable::setSubscribe(bool newSubscribe)
{
    if (m_subscribe == newSubscribe)
        return;
    m_subscribe = newSubscribe;
    emit subscribeChanged();
}
