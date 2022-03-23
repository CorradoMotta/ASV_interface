#include "datasource.h"

DataSource::DataSource(QObject *parent)
    : QObject{parent},
      m_SwampStatus{new SwampStatus()}
{

}

SwampStatus *DataSource::SwampData()
{
    return m_SwampStatus;
}
