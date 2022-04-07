#include "intvariable.h"

IntVariable::IntVariable(QObject *parent)
    : Variable{parent},
      m_value{0}
{

}

int IntVariable::value() const
{
    return m_value;
}

void IntVariable::setValue(int newValue)
{
    if (m_value == newValue)
        return;
    m_value = newValue;
    emit valueChanged();
}

void IntVariable::fromString(QString s)
{
    s = s.trimmed();
    QStringList lString = s.split(QLatin1Char(' '));

    setValue(lString[0].toInt());
    if(lString.size()>=2) setTimeStamp(lString[1].toDouble());
    if(lString.size()>=3) setValid(lString[2].toInt());
}
