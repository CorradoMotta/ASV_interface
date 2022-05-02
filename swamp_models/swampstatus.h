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
#include <components/minion.h>

class SwampStatus : public QObject
{
    Q_OBJECT

    Q_PROPERTY(GPS_AHRS_status* gps_ahrs_status READ gps_ahrs_status NOTIFY gps_ahrs_statusChanged)
    Q_PROPERTY(NGC_status* ngc_status READ ngc_status NOTIFY ngc_statusChanged)
    Q_PROPERTY(Swamp_motor_status* motor_status READ motor_status NOTIFY motor_statusChanged)
    Q_PROPERTY(Time_status* time_status READ time_status NOTIFY time_statusChanged)
    Q_PROPERTY(Minion* minion_fl READ minion_fl NOTIFY minion_fl_Changed)
    Q_PROPERTY(Minion* minion_fr READ minion_fr NOTIFY minion_fr_Changed)
    Q_PROPERTY(Minion* minion_rl READ minion_rl NOTIFY minion_rl_Changed)
    Q_PROPERTY(Minion* minion_rr READ minion_rr NOTIFY minion_rr_Changed)

public:
    explicit SwampStatus(QObject *parent = nullptr);

    GPS_AHRS_status *gps_ahrs_status(); //const
    NGC_status *ngc_status();
    Swamp_motor_status *motor_status();
    Time_status *time_status();
    Minion *minion_fl();
    Minion *minion_fr();
    Minion *minion_rl();
    Minion *minion_rr();

signals:

    void gps_ahrs_statusChanged();
    void ngc_statusChanged();
    void motor_statusChanged();
    void time_statusChanged();
    void minion_fl_Changed();
    void minion_fr_Changed();
    void minion_rl_Changed();
    void minion_rr_Changed();

private:

    GPS_AHRS_status m_gps_ahrs_status;
    NGC_status m_ngc_status;
    Swamp_motor_status m_motor_status;
    Time_status m_time_status;
    Minion m_minion_fl;
    Minion m_minion_fr;
    Minion m_minion_rl;
    Minion m_minion_rr;
};

#endif // SWAMPSTATUS_H
