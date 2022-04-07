#include "doublevariable.h"

DoubleVariable::DoubleVariable(QObject *parent)
    : Variable{parent},
      m_value{0.0},
      m_std{0.0}
{
}

double DoubleVariable::value() const
{
    return m_value;
}

void DoubleVariable::setValue(double newValue)
{
    if (qFuzzyCompare(m_value, newValue))
        return;
    m_value = newValue;
    emit valueChanged();
}

double DoubleVariable::std() const
{
    return m_std;
}

void DoubleVariable::setStd(double newStd)
{
    if (qFuzzyCompare(m_std, newStd))
        return;
    m_std = newStd;
    emit stdChanged();
}

void DoubleVariable::fromString(QString s)
{
    s = s.trimmed();
    QStringList lString = s.split(QLatin1Char(' '));

    setValue(lString[0].toDouble());
    if(lString.size()>=2) setTimeStamp(lString[1].toDouble());
    if(lString.size()>=3) setValid(lString[2].toInt());
    if(lString.size()>=4) setStd(lString[3].toDouble());
    //TODO updated member might be useless for us
}
