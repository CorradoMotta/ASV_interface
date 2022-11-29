#include "coordinatevariable.h"

//coordinateVariable::coordinateVariable()
//{

//}

coordinateVariable::coordinateVariable(const QGeoCoordinate &geoCorr, const xyVariable &xyCorr, double utmzone, char utmzone_char) :
    geoCorr(geoCorr),
    xyCorr(xyCorr),
    utmzone(utmzone),
    utmzone_char(utmzone_char)
{}

const QGeoCoordinate &coordinateVariable::getGeoCorr() const
{
    return geoCorr;
}

void coordinateVariable::setGeoCorr(const QGeoCoordinate &newGeoCorr)
{
    geoCorr = newGeoCorr;
}

const xyVariable &coordinateVariable::getXyCorr() const
{
    return xyCorr;
}

void coordinateVariable::setXyCorr(const xyVariable &newXyCorr)
{
    xyCorr = newXyCorr;
}

double coordinateVariable::getUtmzone() const
{
    return utmzone;
}

void coordinateVariable::setUtmzone(double newUtmzone)
{
    utmzone = newUtmzone;
}

char coordinateVariable::getUtmzone_char() const
{
    return utmzone_char;
}

void coordinateVariable::setUtmzone_char(char newUtmzone_char)
{
    utmzone_char = newUtmzone_char;
}

xyVariable::xyVariable(double x, double y) : x(x),
    y(y)
{}

double xyVariable::getX() const
{
    return x;
}

void xyVariable::setX(double newX)
{
    x = newX;
}

double xyVariable::getY() const
{
    return y;
}

void xyVariable::setY(double newY)
{
    y = newY;
}
