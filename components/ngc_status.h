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
    Q_PROPERTY(DoubleVariable* surge READ surge NOTIFY surgeChanged)
    Q_PROPERTY(DoubleVariable* sway READ sway NOTIFY swayChanged)
    Q_PROPERTY(DoubleVariable* yaw READ yaw NOTIFY yawChanged)
    Q_PROPERTY(DoubleVariable* heading READ heading NOTIFY headingChanged)

    // TODO remake them in an appropriate way!
    Q_PROPERTY(IntVariable* rpmAlpha READ rpmAlpha NOTIFY rpmAlphaChanged)
    Q_PROPERTY(IntVariable* forceTorque READ forceTorque NOTIFY forceTorqueChanged)
    Q_PROPERTY(IntVariable* ngcEnable READ ngcEnable NOTIFY ngcEnableChanged)


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
    IntVariable *ngcEnable();
    DoubleVariable *surge();
    DoubleVariable *sway();
    DoubleVariable *yaw();
    DoubleVariable *heading();

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
    IntVariable m_ngcEnable;
    DoubleVariable m_surge;
    DoubleVariable m_sway;
    DoubleVariable m_yaw;
    DoubleVariable m_heading;
};

#endif // NGC_STATUS_H
