#include "conf.h"

Conf::Conf(QObject *parent)
    : QObject{parent}
{

}


int Conf::maxRPMSpeed() const
{
    return m_maxRPMSpeed;
}

int Conf::maxControllerSpeed() const
{
    return m_maxControllerSpeed;
}

const QString &Conf::mb_offline_db() const
{
    return m_mb_offline_db;
}

void Conf::setMaxRPMSpeed(int newMaxRPMSpeed)
{
    if (m_maxRPMSpeed == newMaxRPMSpeed)
        return;
    m_maxRPMSpeed = newMaxRPMSpeed;
    emit maxRPMSpeedChanged();
}

void Conf::setMaxControllerSpeed(int newMaxControllerSpeed)
{
    if (m_maxControllerSpeed == newMaxControllerSpeed)
        return;
    m_maxControllerSpeed = newMaxControllerSpeed;
    emit maxControllerSpeedChanged();
}

void Conf::setMb_offline(const QString &newMb_offline_db)
{
    if (m_mb_offline_db == newMb_offline_db)
        return;
    m_mb_offline_db = newMb_offline_db;
    emit mb_offline_dbChanged();
}

HciNgiInterface::MapboxStyle Conf::mb_style() const
{
    return m_mb_style;
}

void Conf::setMb_style(HciNgiInterface::MapboxStyle newMb_style)
{
    if (m_mb_style == newMb_style)
        return;
    m_mb_style = newMb_style;
    emit mb_styleChanged();
}
