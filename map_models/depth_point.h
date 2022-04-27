#ifndef DEPTH_POINT_H
#define DEPTH_POINT_H

#include <QObject>
#include <QGeoCoordinate>

class Depth_point : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QGeoCoordinate coordinate READ coordinate WRITE setCoordinate NOTIFY coordinateChanged)
    Q_PROPERTY(double colorHue READ colorHue WRITE setColorHue NOTIFY colorHueChanged)
    Q_PROPERTY(double depth READ depth WRITE setDepth NOTIFY depthChanged)

public:
    explicit Depth_point(QObject *parent = nullptr);
    Depth_point(const QGeoCoordinate &coor, const double &colorHue, const double &depth,  QObject *parent = nullptr);

    const QGeoCoordinate &coordinate() const;
    void setCoordinate(const QGeoCoordinate &newCoordinate);
    double colorHue() const;
    void setColorHue(double newColorHue);
    double depth() const;
    void setDepth(double newDepth);

signals:

    void coordinateChanged();
    void colorHueChanged();
    void depthChanged();

private:

    QGeoCoordinate m_coordinate;
    double m_colorHue;
    double m_depth;
};

#endif // DEPTH_POINT_H
