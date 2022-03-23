#include "stringvariable.h"
#include <variable.h>

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
