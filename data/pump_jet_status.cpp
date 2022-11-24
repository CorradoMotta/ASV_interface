#include "pump_jet_status.h"

Pump_jet_status::Pump_jet_status(QObject *parent)
    : QObject{parent}
{
    m_fl_pj_status.subscribe();
    m_fr_pj_status.subscribe();
    m_rr_pj_status.subscribe();
    m_rl_pj_status.subscribe();
}

IntVariable *Pump_jet_status::fl_pj_status()
{
    return &m_fl_pj_status;
}

IntVariable *Pump_jet_status::fr_pj_status()
{
    return &m_fr_pj_status;
}

IntVariable *Pump_jet_status::rr_pj_status()
{
    return &m_rr_pj_status;
}

IntVariable *Pump_jet_status::rl_pj_status()
{
    return &m_rl_pj_status;
}
