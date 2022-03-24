/*************************************************************************
 *
 * This class contains all different Swamp modules.
 *
 *************************************************************************/

#ifndef SWAMPSTATUS_H
#define SWAMPSTATUS_H

#include <QObject>
#include <gps_ahrs_status.h>
#include <ngc_status.h>

class SwampStatus : public QObject
{
    Q_OBJECT

    Q_PROPERTY(GPS_AHRS_status* gps_ahrs_status READ gps_ahrs_status NOTIFY gps_ahrs_statusChanged)
    Q_PROPERTY(NGC_status* ngc_status READ ngc_status NOTIFY ngc_statusChanged)

public:
    explicit SwampStatus(QObject *parent = nullptr);

    GPS_AHRS_status *gps_ahrs_status() ; //const


    NGC_status *ngc_status();

signals:

    void gps_ahrs_statusChanged();

    void ngc_statusChanged();

private:
    GPS_AHRS_status m_gps_ahrs_status;
    NGC_status m_ngc_status;
};

#endif // SWAMPSTATUS_H
