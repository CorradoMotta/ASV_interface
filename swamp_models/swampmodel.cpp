#include "swampmodel.h"

SwampModel::SwampModel(QObject *parent)
    : QObject{parent}
{

}

DataSource *SwampModel::data_source() const
{
    return m_data_source;
}

void SwampModel::set_data_source(DataSource *newData_source)
{
    m_data_source = newData_source;
}
