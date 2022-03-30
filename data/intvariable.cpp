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
