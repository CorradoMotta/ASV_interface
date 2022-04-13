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
    Q_PROPERTY(Minion* minion_1 READ minion_1 NOTIFY minion_1_Changed)
    Q_PROPERTY(Minion* minion_2 READ minion_2 NOTIFY minion_2_Changed)
    Q_PROPERTY(Minion* minion_3 READ minion_3 NOTIFY minion_3_Changed)
    Q_PROPERTY(Minion* minion_4 READ minion_4 NOTIFY minion_4_Changed)

public:
    explicit SwampStatus(QObject *parent = nullptr);

    GPS_AHRS_status *gps_ahrs_status(); //const
    NGC_status *ngc_status();
    Swamp_motor_status *motor_status();
    Time_status *time_status();
    Minion *minion_1();
    Minion *minion_2();
    Minion *minion_3();
    Minion *minion_4();

signals:

    void gps_ahrs_statusChanged();
    void ngc_statusChanged();
    void motor_statusChanged();
    void time_statusChanged();
    void minion_1_Changed();
    void minion_2_Changed();
    void minion_3_Changed();
    void minion_4_Changed();

private:

    GPS_AHRS_status m_gps_ahrs_status;
    NGC_status m_ngc_status;
    Swamp_motor_status m_motor_status;
    Time_status m_time_status;
    Minion m_minion_1;
    Minion m_minion_2;
    Minion m_minion_3;
    Minion m_minion_4;
};

#endif // SWAMPSTATUS_H
