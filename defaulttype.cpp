#include "defaulttype.h"

DefaultType::DefaultType()
{
    m_value = 5;
}

//double DefaultType::value() const
//{
//    return m_value;
//}

//double DefaultType::std() const
//{
//    return m_std;
//}

double DefaultType::value() const
{
    return m_value;
}

void DefaultType::setValue(double newValue)
{
    if (qFuzzyCompare(m_value, newValue))
        return;
    m_value = newValue;
    //emit valueChanged();
}
