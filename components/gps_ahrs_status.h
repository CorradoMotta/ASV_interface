/*************************************************************************
 *
 * Class that contains all GPS variables.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
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

    Q_PROPERTY(DoubleVariable* timestamp READ timestamp NOTIFY timestampChanged)
    Q_PROPERTY(DoubleVariable* longitude READ longitude NOTIFY longitudeChanged)
    Q_PROPERTY(DoubleVariable* latitude READ latitude NOTIFY latitudeChanged)
    Q_PROPERTY(DoubleVariable* date READ date NOTIFY dateChanged)
    Q_PROPERTY(DoubleVariable* time READ time NOTIFY timeChanged)
    Q_PROPERTY(DoubleVariable* xGps READ xGps NOTIFY xGpsChanged)
    Q_PROPERTY(DoubleVariable* yGps READ yGps NOTIFY yGpsChanged)
    Q_PROPERTY(DoubleVariable* speed READ speed NOTIFY speedChanged)
    Q_PROPERTY(DoubleVariable* track READ track NOTIFY trackChanged)

public:

    explicit GPS_AHRS_status(QObject *parent = nullptr);

    DoubleVariable *longitude();
    DoubleVariable *latitude();
    DoubleVariable *xGps();
    DoubleVariable *yGps();
    DoubleVariable *timestamp();
    DoubleVariable *date();
    DoubleVariable *time();
    DoubleVariable *speed();
    DoubleVariable *track();

signals:

    void longitudeChanged();
    void latitudeChanged();
    void xGpsChanged();
    void yGpsChanged();
    void timestampChanged();
    void dateChanged();
    void timeChanged();
    void speedChanged();
    void trackChanged();

private:

    DoubleVariable m_longitude;
    DoubleVariable m_latitude;
    DoubleVariable m_xGps;
    DoubleVariable m_yGps;
    DoubleVariable m_timestamp;
    DoubleVariable m_date;
    DoubleVariable m_time;
    DoubleVariable m_speed;
    DoubleVariable m_track;
};

#endif // GPS_AHRS_STATUS_H
