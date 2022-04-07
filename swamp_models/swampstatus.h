/*************************************************************************
 *
 * This class contains all different Swamp modules.
 *
 *************************************************************************/

#ifndef SWAMPSTATUS_H
#define SWAMPSTATUS_H

#include <QObject>
#include <components/gps_ahrs_status.h>
#include <components/ngc_status.h>
#include <components/swamp_motor_status.h>
#include <components/time_status.h>

class SwampStatus : public QObject
{
    Q_OBJECT

    Q_PROPERTY(GPS_AHRS_status* gps_ahrs_status READ gps_ahrs_status NOTIFY gps_ahrs_statusChanged)
    Q_PROPERTY(NGC_status* ngc_status READ ngc_status NOTIFY ngc_statusChanged)
    Q_PROPERTY(Swamp_motor_status* motor_status READ motor_status NOTIFY motor_statusChanged)
    Q_PROPERTY(Time_status* time_status READ time_status NOTIFY time_statusChanged)

public:
    explicit SwampStatus(QObject *parent = nullptr);

    GPS_AHRS_status *gps_ahrs_status(); //const
    NGC_status *ngc_status();
    Swamp_motor_status *motor_status();
    Time_status *time_status();

signals:

    void gps_ahrs_statusChanged();
    void ngc_statusChanged();
    void motor_statusChanged();
    void time_statusChanged();

private:

    GPS_AHRS_status m_gps_ahrs_status;
    NGC_status m_ngc_status;
    Swamp_motor_status m_motor_status;
    Time_status m_time_status;
};

#endif // SWAMPSTATUS_H
