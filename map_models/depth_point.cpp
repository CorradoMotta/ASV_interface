#include "depth_point.h"

Depth_point::Depth_point(QObject *parent)
    : QObject{parent}
{

}

Depth_point::Depth_point(const QGeoCoordinate &coor, const double &colorHue, const double &depth, QObject *parent):
    QObject{parent},
    m_coordinate(coor),
    m_colorHue(colorHue),
    m_depth(depth)
{

}

const QGeoCoordinate &Depth_point::coordinate() const
{
    return m_coordinate;
}

void Depth_point::setCoordinate(const QGeoCoordinate &newCoordinate)
{
    if ((m_coordinate.latitude() == newCoordinate.latitude()) | (m_coordinate.longitude() == newCoordinate.longitude()))
        return;
    m_coordinate = newCoordinate;
    emit coordinateChanged();
}

double Depth_point::colorHue() const
{
    return m_colorHue;
}

void Depth_point::setColorHue(double newColorHue)
{
    if (qFuzzyCompare(m_colorHue, newColorHue))
        return;
    m_colorHue = newColorHue;
    emit colorHueChanged();
}

double Depth_point::depth() const
{
    return m_depth;
}

void Depth_point::setDepth(double newDepth)
{
    if (qFuzzyCompare(m_depth, newDepth))
        return;
    m_depth = newDepth;
    emit depthChanged();
}
