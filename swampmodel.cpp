#include "swampmodel.h"

SwampModel::SwampModel(QObject *parent)
    : QObject{parent}
{

}

DataSource *SwampModel::data_source() const
{
    return m_data_source;
}

void SwampModel::set_data_source(DataSource *newData_source)
{
//    if (m_data_source == newData_source)
//        return;
    m_data_source = newData_source;
    // TODO this will be done when reading the cfg file
    m_data_source->swamp_status()->gps_ahrs_status()->latitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/latitude");
    m_data_source->swamp_status()->gps_ahrs_status()->longitude()->setTopic_name("CNR-INM/swamp/sensors/GPS_AHRS/longitude");
    m_data_source->swamp_status()->ngc_status()->psi()->setTopic_name("CNR-INM/swamp/NGC/pose/psi/actual");

    // TODO WHY IN REF IF IT IS MANUAL? Force panel
    m_data_source->swamp_status()->ngc_status()->fu()->ref()->setTopic_name("CNR-INM/swamp/NGC/force/fu/manual");
    m_data_source->swamp_status()->ngc_status()->fv()->ref()->setTopic_name("CNR-INM/swamp/NGC/force/fv/manual");
    m_data_source->swamp_status()->ngc_status()->tr()->ref()->setTopic_name("CNR-INM/swamp/NGC/force/tr/manual");

    // engine panel
    m_data_source->swamp_status()->motor_status()->f1()->thr_enable()->setTopic_name("CNR-INM/swamp/motor/digital/FL-THR-enable");
    m_data_source->swamp_status()->motor_status()->f1()->azm_enable()->setTopic_name("CNR-INM/swamp/motor/digital/FL-AZM-enable");
    m_data_source->swamp_status()->motor_status()->f1()->thr_power()->setTopic_name("CNR-INM/swamp/motor/digital/FL-THR-power");
    m_data_source->swamp_status()->motor_status()->f1()->azm_power()->setTopic_name("CNR-INM/swamp/motor/digital/FL-AZM-power");

    m_data_source->swamp_status()->motor_status()->f2()->thr_enable()->setTopic_name("CNR-INM/swamp/motor/digital/FR-THR-enable");
    m_data_source->swamp_status()->motor_status()->f2()->azm_enable()->setTopic_name("CNR-INM/swamp/motor/digital/FR-AZM-enable");
    m_data_source->swamp_status()->motor_status()->f2()->thr_power()->setTopic_name("CNR-INM/swamp/motor/digital/FR-THR-power");
    m_data_source->swamp_status()->motor_status()->f2()->azm_power()->setTopic_name("CNR-INM/swamp/motor/digital/FR-AZM-power");

    m_data_source->swamp_status()->motor_status()->f3()->thr_enable()->setTopic_name("CNR-INM/swamp/motor/digital/RL-THR-enable");
    m_data_source->swamp_status()->motor_status()->f3()->azm_enable()->setTopic_name("CNR-INM/swamp/motor/digital/RL-AZM-enable");
    m_data_source->swamp_status()->motor_status()->f3()->thr_power()->setTopic_name("CNR-INM/swamp/motor/digital/RL-THR-power");
    m_data_source->swamp_status()->motor_status()->f3()->azm_power()->setTopic_name("CNR-INM/swamp/motor/digital/RL-AZM-power");

    m_data_source->swamp_status()->motor_status()->f4()->thr_enable()->setTopic_name("CNR-INM/swamp/motor/digital/RR-THR-enable");
    m_data_source->swamp_status()->motor_status()->f4()->azm_enable()->setTopic_name("CNR-INM/swamp/motor/digital/RR-AZM-enable");
    m_data_source->swamp_status()->motor_status()->f4()->thr_power()->setTopic_name("CNR-INM/swamp/motor/digital/RR-THR-power");
    m_data_source->swamp_status()->motor_status()->f4()->azm_power()->setTopic_name("CNR-INM/swamp/motor/digital/RR-AZM-power");
//    emit data_sourceChanged();
}
