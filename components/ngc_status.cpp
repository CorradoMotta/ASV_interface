#include "ngc_status.h"

NGC_status::NGC_status(QObject *parent)
    : QObject{parent}
{
    // do subscribes
    m_psi.setSubscribe(true);
    m_altitude.setSubscribe(true);
    m_asvHatX.setSubscribe(true);
    m_asvHatY.setSubscribe(true);
    m_asvHatlat.setSubscribe(true);
    m_asvHatlon.setSubscribe(true);
    m_asvHatpsi.setSubscribe(true);
    m_asvHatr.setSubscribe(true);
    m_asvHatu.setSubscribe(true);
    m_asvHatv.setSubscribe(true);
    m_asvHatxDot.setSubscribe(true);
    m_asvHatyDot.setSubscribe(true);
    m_asvRefNref.setSubscribe(true);
    m_asvRefxRef.setSubscribe(true);
    m_asvRefXref.setSubscribe(true);
    m_asvRefyRef.setSubscribe(true);
    m_asvRefYref.setSubscribe(true);
    m_asvRefalphaRef.setSubscribe(true);
    m_asvRefazimuthFL.setSubscribe(true);
    m_asvRefazimuthFR.setSubscribe(true);
    m_asvRefazimuthRL.setSubscribe(true);
    m_asvRefazimuthRR.setSubscribe(true);
    m_asvRefdnRef.setSubscribe(true);
    m_asvRefgammaLref.setSubscribe(true);
    m_asvReflatLref.setSubscribe(true);
    m_asvReflatRef.setSubscribe(true);
    m_asvReflonLref.setSubscribe(true);
    m_asvReflonRef.setSubscribe(true);
    m_asvRefnFL.setSubscribe(true);
    m_asvRefnFR.setSubscribe(true);
    m_asvRefnRL.setSubscribe(true);
    m_asvRefnRR.setSubscribe(true);
    m_asvRefnRef.setSubscribe(true);
    m_asvRefxLref.setSubscribe(true);
    m_asvRefyDot.setSubscribe(true);
    m_asvRefyLref.setSubscribe(true);
    m_pIMU.setSubscribe(true);
    m_phiIMU.setSubscribe(true);
    m_qIMU.setSubscribe(true);
    m_rIMU.setSubscribe(true);
    m_refAutoMode.setSubscribe(true);
    m_refExecutionWorking_mode.setSubscribe(true);
    m_refManual_mode.setSubscribe(true);
    m_refWorking_mode.setSubscribe(true);
    m_thetaIMU.setSubscribe(true);
    m_asvRefXhat.setSubscribe(true);
    m_asvRefYhat.setSubscribe(true);
    m_asvRefNhat.setSubscribe(true);
    m_latHomeRef.setSubscribe(true);
    m_lonHomeRef.setSubscribe(true);
    m_asvReflatL2ref.setSubscribe(true);
    m_asvReflonL2ref.setSubscribe(true);

}

DoubleVariable *NGC_status::psi()
{
    return &m_psi;
}

NGC_variable *NGC_status::fu()
{
    return &m_fu;
}

NGC_variable *NGC_status::fv()
{
    return &m_fv;
}

NGC_variable *NGC_status::fw()
{
    return &m_fw;
}

NGC_variable *NGC_status::tr()
{
    return &m_tr;
}

DoubleVariable *NGC_status::altitude()
{
    return &m_altitude;
}

IntVariable *NGC_status::gcWorkingMode()
{
    return &m_gcWorkingMode;
}

IntVariable *NGC_status::thrustMappingManualMode()
{
    return &m_thrustMappingManualMode;
}

IntVariable *NGC_status::thrustMappingAutoMode()
{
    return &m_thrustMappingAutoMode;
}

IntVariable *NGC_status::rpmAlpha()
{
    return &m_rpmAlpha;
}

IntVariable *NGC_status::forceTorque()
{
    return &m_forceTorque;
}

NGC_variable *NGC_status::ngcEnable()
{
    return &m_ngcEnable;
}

NGC_variable *NGC_status::surge()
{
    return &m_surge;
}

NGC_variable *NGC_status::sway()
{
    return &m_sway;
}

NGC_variable *NGC_status::yaw()
{
    return &m_yaw;
}

NGC_variable *NGC_status::heading()
{
    return &m_heading;
}

DoubleVariable *NGC_status::asvHatX()
{
return &m_asvHatX;
}

DoubleVariable *NGC_status::asvHatY()
{
return &m_asvHatY;
}

DoubleVariable *NGC_status::asvHatlat()
{
return &m_asvHatlat;
}

DoubleVariable *NGC_status::asvHatlon()
{
return &m_asvHatlon;
}

DoubleVariable *NGC_status::asvHatpsi()
{
return &m_asvHatpsi;
}

DoubleVariable *NGC_status::asvHatr()
{
return &m_asvHatr;
}

DoubleVariable *NGC_status::asvHatu()
{
return &m_asvHatu;
}

DoubleVariable *NGC_status::asvHatv()
{
return &m_asvHatv;
}

DoubleVariable *NGC_status::asvHatxDot()
{
return &m_asvHatxDot;
}

DoubleVariable *NGC_status::asvHatyDot()
{
return &m_asvHatyDot;
}

DoubleVariable *NGC_status::asvRefNref()
{
return &m_asvRefNref;
}

DoubleVariable *NGC_status::asvRefxRef()
{
return &m_asvRefxRef;
}

DoubleVariable *NGC_status::asvRefXref()
{
return &m_asvRefXref;
}

DoubleVariable *NGC_status::asvRefyRef()
{
return &m_asvRefyRef;
}

DoubleVariable *NGC_status::asvRefYref()
{
return &m_asvRefYref;
}

DoubleVariable *NGC_status::asvRefalphaRef()
{
return &m_asvRefalphaRef;
}

DoubleVariable *NGC_status::asvRefazimuthFL()
{
return &m_asvRefazimuthFL;
}

DoubleVariable *NGC_status::asvRefazimuthFR()
{
return &m_asvRefazimuthFR;
}

DoubleVariable *NGC_status::asvRefazimuthRL()
{
return &m_asvRefazimuthRL;
}

DoubleVariable *NGC_status::asvRefazimuthRR()
{
return &m_asvRefazimuthRR;
}

DoubleVariable *NGC_status::asvRefdnRef()
{
return &m_asvRefdnRef;
}

DoubleVariable *NGC_status::asvRefgammaLref()
{
return &m_asvRefgammaLref;
}

DoubleVariable *NGC_status::asvReflatLref()
{
return &m_asvReflatLref;
}

DoubleVariable *NGC_status::asvReflatRef()
{
return &m_asvReflatRef;
}

DoubleVariable *NGC_status::asvReflonLref()
{
return &m_asvReflonLref;
}

DoubleVariable *NGC_status::asvReflonRef()
{
return &m_asvReflonRef;
}

DoubleVariable *NGC_status::asvRefnFL()
{
return &m_asvRefnFL;
}

DoubleVariable *NGC_status::asvRefnFR()
{
return &m_asvRefnFR;
}

DoubleVariable *NGC_status::asvRefnRL()
{
return &m_asvRefnRL;
}

DoubleVariable *NGC_status::asvRefnRR()
{
return &m_asvRefnRR;
}

DoubleVariable *NGC_status::asvRefnRef()
{
return &m_asvRefnRef;
}

DoubleVariable *NGC_status::asvRefxLref()
{
return &m_asvRefxLref;
}

DoubleVariable *NGC_status::asvRefyDot()
{
return &m_asvRefyDot;
}

DoubleVariable *NGC_status::asvRefyLref()
{
return &m_asvRefyLref;
}

DoubleVariable *NGC_status::pIMU()
{
return &m_pIMU;
}

DoubleVariable *NGC_status::phiIMU()
{
return &m_phiIMU;
}

DoubleVariable *NGC_status::qIMU()
{
return &m_qIMU;
}

DoubleVariable *NGC_status::rIMU()
{
return &m_rIMU;
}

IntVariable *NGC_status::refAutoMode()
{
return &m_refAutoMode;
}

IntVariable *NGC_status::refExecutionWorking_mode()
{
return &m_refExecutionWorking_mode;
}

IntVariable *NGC_status::refManual_mode()
{
return &m_refManual_mode;
}

IntVariable *NGC_status::refWorking_mode()
{
return &m_refWorking_mode;
}

DoubleVariable *NGC_status::thetaIMU()
{
return &m_thetaIMU;
}

IntVariable *NGC_status::setLog()
{
return &m_setLog;
}

IntVariable *NGC_status::setRobotHome()
{
    return &m_setRobotHome;
}

DoubleVariable *NGC_status::setLatLon()
{
    return &m_setLatLon;
}

DoubleVariable *NGC_status::setXY()
{
    return &m_setXY;
}

DoubleVariable *NGC_status::setLineLatLon()
{
    return &m_setLineLatLon;
}

DoubleVariable *NGC_status::setXYLine()
{
    return &m_setXYLine;
}

DoubleVariable *NGC_status::setYawGSPar()
{
    return &m_setYawGSPar;
}

DoubleVariable *NGC_status::setHeadingPiPar()
{
    return &m_setHeadingPiPar;
}

DoubleVariable *NGC_status::asvRefXhat()
{
    return &m_asvRefXhat;
}

DoubleVariable *NGC_status::asvRefYhat()
{
    return &m_asvRefYhat;
}

DoubleVariable *NGC_status::asvRefNhat()
{
    return &m_asvRefNhat;
}

DoubleVariable *NGC_status::latHomeRef()
{
    return &m_latHomeRef;
}

DoubleVariable *NGC_status::lonHomeRef()
{
    return &m_lonHomeRef;
}

IntVariable *NGC_status::stopFileCmd()
{
    return &m_stopFileCmd;
}

IntVariable *NGC_status::startFileCmd()
{
    return &m_startFileCmd;
}

IntVariable *NGC_status::resumeFileCmd()
{
    return &m_resumeFileCmd;
}

DoubleVariable *NGC_status::asvReflatL2ref()
{
    return &m_asvReflatL2ref;
}

DoubleVariable *NGC_status::asvReflonL2ref()
{
    return &m_asvReflonL2ref;
}

IntVariable *NGC_status::setLFPar()
{
    return &m_setLFPar;
}

DoubleVariable *NGC_status::setPFLatLon()
{
    return &m_setPFLatLon;
}

DoubleVariable *NGC_status::setPFLatLonPar()
{
    return &m_setPFLatLonPar;
}
