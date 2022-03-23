#include "geometry.h"

Geometry::Geometry(QObject *parent)
    : QObject{parent}
{

}

const QString &Geometry::type() const
{
    return m_type;
}

void Geometry::setType(const QString &newType)
{
    if (m_type == newType)
        return;
    m_type = newType;
    emit typeChanged();
}

const QVector<QGeoCoordinate> &Geometry::coords() const
{
    return m_coords;
}

void Geometry::setCoords(const QVector<QGeoCoordinate> &newCoords)
{
    if (m_coords == newCoords)
        return;
    m_coords = newCoords;
    emit coordsChanged();
}

bool Geometry::isActive() const
{
    return m_isActive;
}

void Geometry::setIsActive(bool newIsActive)
{
    if (m_isActive == newIsActive)
        return;
    m_isActive = newIsActive;
    emit isActiveChanged();
}
