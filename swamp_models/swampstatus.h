/*************************************************************************
 *
 * This class contains all Swamp modules.
 *
 * Author: Corrado Motta
 * Date: 05/2022
 * Mail: corradomotta92@gmail.com
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
#include <components/conf.h>
#include <components/ngc.h>

class SwampStatus : public QObject
{
    Q_OBJECT

    Q_PROPERTY(GPS_AHRS_status* gps_ahrs_status READ gps_ahrs_status NOTIFY gps_ahrs_statusChanged)
    Q_PROPERTY(NGC* ngc READ ngc NOTIFY ngcChanged)
    Q_PROPERTY(Swamp_motor_status* motor_status READ motor_status NOTIFY motor_statusChanged)
    Q_PROPERTY(Time_status* time_status READ time_status NOTIFY time_statusChanged)
    Q_PROPERTY(Conf* conf READ conf NOTIFY confChanged)
    Q_PROPERTY(Minion* minion_fl READ minion_fl NOTIFY minion_fl_Changed)
    Q_PROPERTY(Minion* minion_fr READ minion_fr NOTIFY minion_fr_Changed)
    Q_PROPERTY(Minion* minion_rl READ minion_rl NOTIFY minion_rl_Changed)
    Q_PROPERTY(Minion* minion_rr READ minion_rr NOTIFY minion_rr_Changed)

public:
    explicit SwampStatus(QObject *parent = nullptr);

    GPS_AHRS_status *gps_ahrs_status(); //const
    Swamp_motor_status *motor_status();
    Time_status *time_status();
    Minion *minion_fl();
    Minion *minion_fr();
    Minion *minion_rl();
    Minion *minion_rr();
    Conf *conf();
    NGC *ngc();

signals:

    void gps_ahrs_statusChanged();
    void motor_statusChanged();
    void time_statusChanged();
    void minion_fl_Changed();
    void minion_fr_Changed();
    void minion_rl_Changed();
    void minion_rr_Changed();
    void confChanged();
    void ngcChanged();

private:

    GPS_AHRS_status m_gps_ahrs_status;
    Swamp_motor_status m_motor_status;
    Time_status m_time_status;
    Minion m_minion_fl;
    Minion m_minion_fr;
    Minion m_minion_rl;
    Minion m_minion_rr;
    Conf m_conf;
    NGC m_ngc;
};

#endif // SWAMPSTATUS_H
