#ifndef GEOMETRY_H
#define GEOMETRY_H

#include <QObject>
#include <QGeoCoordinate>

class Geometry : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString type READ type WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(QVector<QGeoCoordinate> coords READ coords WRITE setCoords NOTIFY coordsChanged)
    Q_PROPERTY(bool isActive READ isActive WRITE setIsActive NOTIFY isActiveChanged)

    QString m_type;

    QVector<QGeoCoordinate> m_coords;

    bool m_isActive;

public:
    explicit Geometry(QObject *parent = nullptr);

    const QString &type() const;
    void setType(const QString &newType);
    const QVector<QGeoCoordinate> &coords() const;
    void setCoords(const QVector<QGeoCoordinate> &newCoords);
    bool isActive() const;
    void setIsActive(bool newIsActive);

signals:
    void typeChanged();
    void coordsChanged();
    void isActiveChanged();
};

#endif // GEOMETRY_H
