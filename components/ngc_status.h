/*************************************************************************
 *
 * Class that contains all NGC commands and status variables.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

#ifndef NGC_STATUS_H
#define NGC_STATUS_H

#include <QObject>
#include <data/doublevariable.h>
#include <data/ngc_variable.h>
#include <data/intvariable.h>

class NGC_status : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DoubleVariable* psi READ psi NOTIFY psiChanged)
    Q_PROPERTY(NGC_variable* fu READ fu NOTIFY fuChanged)
    Q_PROPERTY(NGC_variable* fv READ fv NOTIFY fvChanged)
    Q_PROPERTY(NGC_variable* fw READ fw NOTIFY fwChanged)
    Q_PROPERTY(NGC_variable* tr READ tr NOTIFY trChanged)
    Q_PROPERTY(DoubleVariable* altitude READ altitude NOTIFY altitudeChanged)
    Q_PROPERTY(IntVariable* gcWorkingMode READ gcWorkingMode NOTIFY gcWorkingModeChanged)
    Q_PROPERTY(IntVariable* thrustMappingManualMode READ thrustMappingManualMode NOTIFY thrustMappingManualModeChanged)
    Q_PROPERTY(IntVariable* thrustMappingAutoMode READ thrustMappingAutoMode NOTIFY thrustMappingAutoModeChanged)

    Q_PROPERTY(NGC_variable* surge READ surge NOTIFY surgeChanged)
    Q_PROPERTY(NGC_variable* sway READ sway NOTIFY swayChanged)
    Q_PROPERTY(NGC_variable* yaw READ yaw NOTIFY yawChanged)
    Q_PROPERTY(NGC_variable* heading READ heading NOTIFY headingChanged)
    Q_PROPERTY(IntVariable* setLog READ setLog NOTIFY setLogChanged)

    // TODO remake them in an appropriate way!
    Q_PROPERTY(IntVariable* rpmAlpha READ rpmAlpha NOTIFY rpmAlphaChanged)
    Q_PROPERTY(IntVariable* forceTorque READ forceTorque NOTIFY forceTorqueChanged)
    Q_PROPERTY(NGC_variable* ngcEnable READ ngcEnable NOTIFY ngcEnableChanged)
    Q_PROPERTY(DoubleVariable* asvHatX READ asvHatX NOTIFY asvHatXChanged)
    Q_PROPERTY(DoubleVariable* asvHatY READ asvHatY NOTIFY asvHatYChanged)
    Q_PROPERTY(DoubleVariable* asvHatlat READ asvHatlat NOTIFY asvHatlatChanged)
    Q_PROPERTY(DoubleVariable* asvHatlon READ asvHatlon NOTIFY asvHatlonChanged)
    Q_PROPERTY(DoubleVariable* asvHatpsi READ asvHatpsi NOTIFY asvHatpsiChanged)
    Q_PROPERTY(DoubleVariable* asvHatr READ asvHatr NOTIFY asvHatrChanged)
    Q_PROPERTY(DoubleVariable* asvHatu READ asvHatu NOTIFY asvHatuChanged)
    Q_PROPERTY(DoubleVariable* asvHatv READ asvHatv NOTIFY asvHatvChanged)
    Q_PROPERTY(DoubleVariable* asvHatxDot READ asvHatxDot NOTIFY asvHatxDotChanged)
    Q_PROPERTY(DoubleVariable* asvHatyDot READ asvHatyDot NOTIFY asvHatyDotChanged)
    Q_PROPERTY(DoubleVariable* asvRefNref READ asvRefNref NOTIFY asvRefNrefChanged)
    Q_PROPERTY(DoubleVariable* asvRefxRef READ asvRefxRef NOTIFY asvRefxRefChanged)
    Q_PROPERTY(DoubleVariable* asvRefXref READ asvRefXref NOTIFY asvRefXrefChanged)
    Q_PROPERTY(DoubleVariable* asvRefyRef READ asvRefyRef NOTIFY asvRefyRefChanged)
    Q_PROPERTY(DoubleVariable* asvRefYref READ asvRefYref NOTIFY asvRefYrefChanged)
    //    Xhat
    //    Yhat
    //    Nhat TODO make it ngc variable
    Q_PROPERTY(DoubleVariable* asvRefXhat READ asvRefXhat NOTIFY asvRefXhatChanged)
    Q_PROPERTY(DoubleVariable* asvRefYhat READ asvRefYhat NOTIFY asvRefYhatChanged)
    Q_PROPERTY(DoubleVariable* asvRefNhat READ asvRefNhat NOTIFY asvRefNhatChanged)

    Q_PROPERTY(DoubleVariable* asvRefalphaRef READ asvRefalphaRef NOTIFY asvRefalphaRefChanged)
    Q_PROPERTY(DoubleVariable* asvRefazimuthFL READ asvRefazimuthFL NOTIFY asvRefazimuthFLChanged)
    Q_PROPERTY(DoubleVariable* asvRefazimuthFR READ asvRefazimuthFR NOTIFY asvRefazimuthFRChanged)
    Q_PROPERTY(DoubleVariable* asvRefazimuthRL READ asvRefazimuthRL NOTIFY asvRefazimuthRLChanged)
    Q_PROPERTY(DoubleVariable* asvRefazimuthRR READ asvRefazimuthRR NOTIFY asvRefazimuthRRChanged)
    Q_PROPERTY(DoubleVariable* asvRefdnRef READ asvRefdnRef NOTIFY asvRefdnRefChanged)
    Q_PROPERTY(DoubleVariable* asvRefgammaLref READ asvRefgammaLref NOTIFY asvRefgammaLrefChanged)
    Q_PROPERTY(DoubleVariable* asvReflatLref READ asvReflatLref NOTIFY asvReflatLrefChanged)
    Q_PROPERTY(DoubleVariable* asvReflatL2ref READ asvReflatL2ref NOTIFY asvReflatL2refChanged)
    Q_PROPERTY(DoubleVariable* asvReflatRef READ asvReflatRef NOTIFY asvReflatRefChanged)
    Q_PROPERTY(DoubleVariable* asvReflonLref READ asvReflonLref NOTIFY asvReflonLrefChanged)
    Q_PROPERTY(DoubleVariable* asvReflonL2ref READ asvReflonL2ref NOTIFY asvReflonL2refChanged)
    Q_PROPERTY(DoubleVariable* asvReflonRef READ asvReflonRef NOTIFY asvReflonRefChanged)
    Q_PROPERTY(DoubleVariable* asvRefnFL READ asvRefnFL NOTIFY asvRefnFLChanged)
    Q_PROPERTY(DoubleVariable* asvRefnFR READ asvRefnFR NOTIFY asvRefnFRChanged)
    Q_PROPERTY(DoubleVariable* asvRefnRL READ asvRefnRL NOTIFY asvRefnRLChanged)
    Q_PROPERTY(DoubleVariable* asvRefnRR READ asvRefnRR NOTIFY asvRefnRRChanged)
    Q_PROPERTY(DoubleVariable* asvRefnRef READ asvRefnRef NOTIFY asvRefnRefChanged)
    Q_PROPERTY(DoubleVariable* asvRefxLref READ asvRefxLref NOTIFY asvRefxLrefChanged)
    Q_PROPERTY(DoubleVariable* asvRefyDot READ asvRefyDot NOTIFY asvRefyDotChanged)
    Q_PROPERTY(DoubleVariable* asvRefyLref READ asvRefyLref NOTIFY asvRefyLrefChanged)
    Q_PROPERTY(DoubleVariable* pIMU READ pIMU NOTIFY pIMUChanged)
    Q_PROPERTY(DoubleVariable* phiIMU READ phiIMU NOTIFY phiIMUChanged)
    Q_PROPERTY(DoubleVariable* qIMU READ qIMU NOTIFY qIMUChanged)
    Q_PROPERTY(DoubleVariable* rIMU READ rIMU NOTIFY rIMUChanged)
    Q_PROPERTY(IntVariable* refAutoMode READ refAutoMode NOTIFY refAutoModeChanged)
    Q_PROPERTY(IntVariable* refExecutionWorking_mode READ refExecutionWorking_mode NOTIFY refExecutionWorking_modeChanged)
    Q_PROPERTY(IntVariable* refManual_mode READ refManual_mode NOTIFY refManual_modeChanged)
    Q_PROPERTY(IntVariable* refWorking_mode READ refWorking_mode NOTIFY refWorking_modeChanged)
    Q_PROPERTY(DoubleVariable* thetaIMU READ thetaIMU NOTIFY thetaIMUChanged)

    // TODO MOVE INTO APPROPRIATE CLASS
    Q_PROPERTY(IntVariable* setRobotHome READ setRobotHome NOTIFY setRobotHomeChanged)
    Q_PROPERTY(IntVariable* stopFileCmd READ stopFileCmd NOTIFY stopFileCmdChanged)
    Q_PROPERTY(IntVariable* startFileCmd READ startFileCmd NOTIFY startFileCmdChanged)
    Q_PROPERTY(IntVariable* resumeFileCmd READ resumeFileCmd NOTIFY resumeFileCmdChanged)
    Q_PROPERTY(IntVariable* setLFPar READ setLFPar NOTIFY setLFParChanged)
    Q_PROPERTY(DoubleVariable* setLatLon READ setLatLon NOTIFY setLatLonChanged)
    Q_PROPERTY(DoubleVariable* setXY READ setXY NOTIFY setXYChanged)
    Q_PROPERTY(DoubleVariable* setLineLatLon READ setLineLatLon NOTIFY setLineLatLonChanged)
    Q_PROPERTY(DoubleVariable* setPFLatLon READ setPFLatLon NOTIFY setPFLatLonChanged)
    Q_PROPERTY(DoubleVariable* setPFLatLonPar READ setPFLatLonPar NOTIFY setPFLatLonParChanged)
    Q_PROPERTY(DoubleVariable* setXYLine READ setXYLine NOTIFY setXYLineChanged)
    Q_PROPERTY(DoubleVariable* setYawGSPar READ setYawGSPar NOTIFY setYawGSParChanged)
    Q_PROPERTY(DoubleVariable* setHeadingPiPar READ setHeadingPiPar NOTIFY setHeadingPiParChanged)
    Q_PROPERTY(DoubleVariable* latHomeRef READ latHomeRef NOTIFY latHomeRefChanged)
    Q_PROPERTY(DoubleVariable* lonHomeRef READ lonHomeRef NOTIFY lonHomeRefChanged)


public:
    explicit NGC_status(QObject *parent = nullptr);

    DoubleVariable *psi();
    NGC_variable *fu();
    NGC_variable *fv();
    NGC_variable *fw();
    NGC_variable *tr();
    DoubleVariable *altitude();
    IntVariable *gcWorkingMode();
    IntVariable *thrustMappingManualMode();
    IntVariable *thrustMappingAutoMode();
    IntVariable *rpmAlpha();
    IntVariable *forceTorque();
    NGC_variable *ngcEnable();
    NGC_variable *surge();
    NGC_variable *sway();
    NGC_variable *yaw();
    NGC_variable *heading();

    DoubleVariable* asvHatX();
    DoubleVariable* asvHatY();
    DoubleVariable* asvHatlat();
    DoubleVariable* asvHatlon();
    DoubleVariable* asvHatpsi();
    DoubleVariable* asvHatr();
    DoubleVariable* asvHatu();
    DoubleVariable* asvHatv();
    DoubleVariable* asvHatxDot();
    DoubleVariable* asvHatyDot();
    DoubleVariable* asvRefNref();
    DoubleVariable* asvRefxRef();
    DoubleVariable* asvRefXref();
    DoubleVariable* asvRefyRef();
    DoubleVariable* asvRefYref();
    DoubleVariable* asvRefalphaRef();
    DoubleVariable* asvRefazimuthFL();
    DoubleVariable* asvRefazimuthFR();
    DoubleVariable* asvRefazimuthRL();
    DoubleVariable* asvRefazimuthRR();
    DoubleVariable* asvRefdnRef();
    DoubleVariable* asvRefgammaLref();
    DoubleVariable* asvReflatLref();
    DoubleVariable* asvReflatRef();
    DoubleVariable* asvReflonLref();
    DoubleVariable* asvReflonRef();
    DoubleVariable* asvRefnFL();
    DoubleVariable* asvRefnFR();
    DoubleVariable* asvRefnRL();
    DoubleVariable* asvRefnRR();
    DoubleVariable* asvRefnRef();
    DoubleVariable* asvRefxLref();
    DoubleVariable* asvRefyDot();
    DoubleVariable* asvRefyLref();
    DoubleVariable* pIMU();
    DoubleVariable* phiIMU();
    DoubleVariable* qIMU();
    DoubleVariable* rIMU();
    IntVariable* refAutoMode();
    IntVariable* refExecutionWorking_mode();
    IntVariable* refManual_mode();
    IntVariable* refWorking_mode();
    DoubleVariable* thetaIMU();
    IntVariable *setLog();

    IntVariable* setRobotHome();
    DoubleVariable* setLatLon();
    DoubleVariable* setXY();
    DoubleVariable* setLineLatLon();
    DoubleVariable* setXYLine();
    DoubleVariable* setYawGSPar();
    DoubleVariable* setHeadingPiPar();
    IntVariable *setLFPar();

    DoubleVariable* asvRefXhat();
    DoubleVariable* asvRefYhat();
    DoubleVariable* asvRefNhat();


    DoubleVariable* latHomeRef();
    DoubleVariable* lonHomeRef();

    IntVariable* stopFileCmd();
    IntVariable* startFileCmd();
    IntVariable* resumeFileCmd();

    DoubleVariable* asvReflatL2ref();
    DoubleVariable* asvReflonL2ref();


    DoubleVariable* setPFLatLon();
    DoubleVariable *setPFLatLonPar();

signals:

    void psiChanged();
    void fuChanged();
    void fvChanged();
    void fwChanged();
    void trChanged();
    void altitudeChanged();
    void gcWorkingModeChanged();
    void thrustMappingManualModeChanged();
    void thrustMappingAutoModeChanged();
    void rpmAlphaChanged();
    void forceTorqueChanged();
    void ngcEnableChanged();
    void surgeChanged();
    void swayChanged();
    void yawChanged();
    void headingChanged();

    void asvHatXChanged();
    void asvHatYChanged();
    void asvHatlatChanged();
    void asvHatlonChanged();
    void asvHatpsiChanged();
    void asvHatrChanged();
    void asvHatuChanged();
    void asvHatvChanged();
    void asvHatxDotChanged();
    void asvHatyDotChanged();
    void asvRefNrefChanged();
    void asvRefxRefChanged();
    void asvRefXrefChanged();
    void asvRefyRefChanged();
    void asvRefYrefChanged();
    void asvRefalphaRefChanged();
    void asvRefazimuthFLChanged();
    void asvRefazimuthFRChanged();
    void asvRefazimuthRLChanged();
    void asvRefazimuthRRChanged();
    void asvRefdnRefChanged();
    void asvRefgammaLrefChanged();
    void asvReflatLrefChanged();
    void asvReflatRefChanged();
    void asvReflonLrefChanged();
    void asvReflonRefChanged();
    void asvRefnFLChanged();
    void asvRefnFRChanged();
    void asvRefnRLChanged();
    void asvRefnRRChanged();
    void asvRefnRefChanged();
    void asvRefxLrefChanged();
    void asvRefyDotChanged();
    void asvRefyLrefChanged();
    void pIMUChanged();
    void phiIMUChanged();
    void qIMUChanged();
    void rIMUChanged();
    void refAutoModeChanged();
    void refExecutionWorking_modeChanged();
    void refManual_modeChanged();
    void refWorking_modeChanged();
    void thetaIMUChanged();
    void setLogChanged();
    void setRobotHomeChanged();
    void setLatLonChanged();

    void setXYChanged();
    void setLineLatLonChanged();
    void setXYLineChanged();
    void setYawGSParChanged();
    void setHeadingPiParChanged();

    void asvRefXhatChanged();
    void asvRefYhatChanged();
    void asvRefNhatChanged();

    void latHomeRefChanged();
    void lonHomeRefChanged();

    void stopFileCmdChanged();
    void startFileCmdChanged();
    void resumeFileCmdChanged();

    void asvReflatL2refChanged();
    void asvReflonL2refChanged();
    void setLFParChanged();
    void setPFLatLonChanged();

    void setPFLatLonParChanged();

private:

    DoubleVariable m_psi;
    NGC_variable m_fu;
    NGC_variable m_fv;
    NGC_variable m_fw;
    NGC_variable m_tr;
    DoubleVariable m_altitude;
    IntVariable m_gcWorkingMode;
    IntVariable m_thrustMappingManualMode;
    IntVariable m_thrustMappingAutoMode;
    IntVariable m_rpmAlpha;
    IntVariable m_forceTorque;
    NGC_variable m_ngcEnable;
    NGC_variable m_surge;
    NGC_variable m_sway;
    NGC_variable m_yaw;
    NGC_variable m_heading;

    DoubleVariable m_asvHatX;
    DoubleVariable m_asvHatY;
    DoubleVariable m_asvHatlat;
    DoubleVariable m_asvHatlon;
    DoubleVariable m_asvHatpsi;
    DoubleVariable m_asvHatr;
    DoubleVariable m_asvHatu;
    DoubleVariable m_asvHatv;
    DoubleVariable m_asvHatxDot;
    DoubleVariable m_asvHatyDot;
    DoubleVariable m_asvRefNref;
    DoubleVariable m_asvRefxRef;
    DoubleVariable m_asvRefXref;
    DoubleVariable m_asvRefyRef;
    DoubleVariable m_asvRefYref;
    DoubleVariable m_asvRefalphaRef;
    DoubleVariable m_asvRefazimuthFL;
    DoubleVariable m_asvRefazimuthFR;
    DoubleVariable m_asvRefazimuthRL;
    DoubleVariable m_asvRefazimuthRR;
    DoubleVariable m_asvRefdnRef;
    DoubleVariable m_asvRefgammaLref;
    DoubleVariable m_asvReflatLref;
    DoubleVariable m_asvReflatRef;
    DoubleVariable m_asvReflonLref;
    DoubleVariable m_asvReflonRef;
    DoubleVariable m_asvRefnFL;
    DoubleVariable m_asvRefnFR;
    DoubleVariable m_asvRefnRL;
    DoubleVariable m_asvRefnRR;
    DoubleVariable m_asvRefnRef;
    DoubleVariable m_asvRefxLref;
    DoubleVariable m_asvRefyDot;
    DoubleVariable m_asvRefyLref;
    DoubleVariable m_pIMU;
    DoubleVariable m_phiIMU;
    DoubleVariable m_qIMU;
    DoubleVariable m_rIMU;
    IntVariable m_refAutoMode;
    IntVariable m_refExecutionWorking_mode;
    IntVariable m_refManual_mode;
    IntVariable m_refWorking_mode;
    DoubleVariable m_thetaIMU;
    IntVariable m_setLog;

    IntVariable m_setRobotHome;
    DoubleVariable m_setLatLon;
    DoubleVariable m_setXY;
    DoubleVariable m_setLineLatLon;
    DoubleVariable m_setXYLine;
    DoubleVariable m_setYawGSPar;
    DoubleVariable m_setHeadingPiPar;
    DoubleVariable m_asvRefXhat;
    DoubleVariable m_asvRefYhat;
    DoubleVariable m_asvRefNhat;
    DoubleVariable m_latHomeRef;
    DoubleVariable m_lonHomeRef;
    IntVariable m_stopFileCmd;
    IntVariable m_startFileCmd;
    IntVariable m_resumeFileCmd;
    DoubleVariable m_asvReflatL2ref;
    DoubleVariable m_asvReflonL2ref;
    IntVariable m_setLFPar;
    DoubleVariable m_setPFLatLon;
    DoubleVariable m_setPFLatLonPar;
};

#endif // NGC_STATUS_H
