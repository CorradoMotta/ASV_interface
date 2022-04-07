#include "stringvariable.h"
#include <data/variable.h>

StringVariable::StringVariable(QObject *parent)
    : Variable{parent},
      m_value{""}
{

}

const QString &StringVariable::value() const
{
    return m_value;
}

void StringVariable::setValue(const QString &newValue)
{
    if (m_value == newValue)
        return;
    m_value = newValue;
    emit valueChanged();
}

void StringVariable::fromString(QString s)
{
    s = s.trimmed();
    QStringList lString = s.split(QLatin1Char(' '));

    if(lString.size()>=1) setValue(lString[0]);
    if(lString.size()>=2) setTimeStamp(lString[1].toDouble());
    if(lString.size()>=3) setValid(lString[2].toInt());
}
