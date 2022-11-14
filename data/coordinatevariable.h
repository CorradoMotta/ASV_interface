#ifndef COORDINATEVARIABLE_H
#define COORDINATEVARIABLE_H

#include <QGeoCoordinate>

class xyVariable
{

public:
    xyVariable(double x, double y);

    double getX() const;
    void setX(double newX);
    double getY() const;
    void setY(double newY);

private:
    double x;
    double y;
};

class coordinateVariable
{

public:

    //coordinateVariable();
    coordinateVariable(const QGeoCoordinate &geoCorr, const xyVariable &xyCorr, double utmzone, char utmzone_char);

    const QGeoCoordinate &getGeoCorr() const;
    void setGeoCorr(const QGeoCoordinate &newGeoCorr);
    const xyVariable &getXyCorr() const;
    void setXyCorr(const xyVariable &newXyCorr);
    double getUtmzone() const;
    void setUtmzone(double newUtmzone);
    char getUtmzone_char() const;
    void setUtmzone_char(char newUtmzone_char);

private:
    QGeoCoordinate geoCorr;
    xyVariable xyCorr;
    double utmzone;
    char utmzone_char;
};

#endif // COORDINATEVARIABLE_H
