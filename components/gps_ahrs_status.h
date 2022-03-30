/*************************************************************************
 *
 * GPS AHRS STATUS module class.
 *
 *************************************************************************/

#ifndef GPS_AHRS_STATUS_H
#define GPS_AHRS_STATUS_H

#include <QObject>
#include <math.h>
#include "data/custom_types.h"
#include <vector>
#include <string>
#include <data/doublevariable.h>

class GPS_AHRS_status : public QObject
{
    Q_OBJECT

    Q_PROPERTY(DoubleVariable* longitude READ longitude NOTIFY longitudeChanged)
    Q_PROPERTY(DoubleVariable* latitude READ latitude NOTIFY latitudeChanged)

public:

    explicit GPS_AHRS_status(QObject *parent = nullptr);
    // todo check if const can be added at the end (it is added automatically)
    DoubleVariable *longitude();
    DoubleVariable *latitude();

signals:

    void longitudeChanged();
    void latitudeChanged();

private:

    DoubleVariable m_longitude;
    DoubleVariable m_latitude;
};

#endif // GPS_AHRS_STATUS_H
