#ifndef PUMP_JET_STATUS_H
#define PUMP_JET_STATUS_H

#include <QObject>
#include <data/intvariable.h>

class Pump_jet_status : public QObject
{
    Q_OBJECT

    Q_PROPERTY(IntVariable* fl_pj_status READ fl_pj_status NOTIFY fl_pj_statusChanged)
    Q_PROPERTY(IntVariable* fr_pj_status READ fr_pj_status NOTIFY fr_pj_statusChanged)
    Q_PROPERTY(IntVariable* rr_pj_status READ rr_pj_status NOTIFY rr_pj_statusChanged)
    Q_PROPERTY(IntVariable* rl_pj_status READ rl_pj_status NOTIFY rl_pj_statusChanged)

public:
    explicit Pump_jet_status(QObject *parent = nullptr);

    IntVariable *fl_pj_status();
    IntVariable *fr_pj_status();
    IntVariable *rr_pj_status();
    IntVariable *rl_pj_status();

signals:

    void fl_pj_statusChanged();
    void fr_pj_statusChanged();
    void rr_pj_statusChanged();
    void rl_pj_statusChanged();

private:

    IntVariable m_fl_pj_status;
    IntVariable m_fr_pj_status;
    IntVariable m_rr_pj_status;
    IntVariable m_rl_pj_status;
};

#endif // PUMP_JET_STATUS_H
