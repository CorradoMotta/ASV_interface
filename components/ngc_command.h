#ifndef NGC_COMMAND_H
#define NGC_COMMAND_H

#include <QObject>
#include <data/ngc_variable.h>
#include <data/TopicVariable.h>

class NGC_command : public QObject
{
    Q_OBJECT

    Q_PROPERTY(TopicVariable* rpmAlpha READ rpmAlpha NOTIFY rpmAlphaChanged)
    Q_PROPERTY(TopicVariable* forceTorque READ forceTorque NOTIFY forceTorqueChanged)
    Q_PROPERTY(NGC_variable* ngcEnable READ ngcEnable NOTIFY ngcEnableChanged)
    Q_PROPERTY(TopicVariable* gcWorkingMode READ gcWorkingMode NOTIFY gcWorkingModeChanged) // topic
    Q_PROPERTY(TopicVariable* thrustMappingManualMode READ thrustMappingManualMode NOTIFY thrustMappingManualModeChanged) // topic
    Q_PROPERTY(TopicVariable* thrustMappingAutoMode READ thrustMappingAutoMode NOTIFY thrustMappingAutoModeChanged) //topic
    Q_PROPERTY(TopicVariable* setRobotHome READ setRobotHome NOTIFY setRobotHomeChanged)
    Q_PROPERTY(TopicVariable* setLog READ setLog NOTIFY setLogChanged)
    Q_PROPERTY(TopicVariable* stopFileCmd READ stopFileCmd NOTIFY stopFileCmdChanged)
    Q_PROPERTY(TopicVariable* startFileCmd READ startFileCmd NOTIFY startFileCmdChanged)
    Q_PROPERTY(TopicVariable* resumeFileCmd READ resumeFileCmd NOTIFY resumeFileCmdChanged)
    Q_PROPERTY(TopicVariable* setLFPar READ setLFPar NOTIFY setLFParChanged)
    Q_PROPERTY(TopicVariable* setLatLon READ setLatLon NOTIFY setLatLonChanged)
    Q_PROPERTY(TopicVariable* setXY READ setXY NOTIFY setXYChanged)
    Q_PROPERTY(TopicVariable* setLineLatLon READ setLineLatLon NOTIFY setLineLatLonChanged)
    Q_PROPERTY(TopicVariable* setPFLatLon READ setPFLatLon NOTIFY setPFLatLonChanged)
    Q_PROPERTY(TopicVariable* setXYLine READ setXYLine NOTIFY setXYLineChanged)
    Q_PROPERTY(TopicVariable* setYawGSPar READ setYawGSPar NOTIFY setYawGSParChanged)
    Q_PROPERTY(TopicVariable* setHeadingPiPar READ setHeadingPiPar NOTIFY setHeadingPiParChanged)
    Q_PROPERTY(TopicVariable* setPFPar READ setPFPar NOTIFY setPFParChanged)
    Q_PROPERTY(TopicVariable* setSegment READ setSegment NOTIFY setSegmentChanged)
    Q_PROPERTY(TopicVariable* setSegmentToggle READ setSegmentToggle NOTIFY setSegmentToggleChanged)
    Q_PROPERTY(NGC_variable* surge READ surge NOTIFY surgeChanged)
    Q_PROPERTY(NGC_variable* sway READ sway NOTIFY swayChanged)
    Q_PROPERTY(NGC_variable* yaw READ yaw NOTIFY yawChanged)
    Q_PROPERTY(NGC_variable* heading READ heading NOTIFY headingChanged)

public:
    explicit NGC_command(QObject *parent = nullptr);
    TopicVariable *setLog();
    TopicVariable* setRobotHome();
    TopicVariable* setLatLon();
    TopicVariable* setXY();
    TopicVariable* setLineLatLon();
    TopicVariable* setXYLine();
    TopicVariable* setYawGSPar();
    TopicVariable* setHeadingPiPar();
    TopicVariable *setLFPar();
    TopicVariable* setPFLatLon();
    TopicVariable *setPFPar();
    TopicVariable *setSegment();
    TopicVariable *setSegmentToggle();
    TopicVariable* stopFileCmd();
    TopicVariable* startFileCmd();
    TopicVariable* resumeFileCmd();
    TopicVariable *gcWorkingMode();
    TopicVariable *thrustMappingManualMode();
    TopicVariable *thrustMappingAutoMode();
    TopicVariable *rpmAlpha();
    TopicVariable *forceTorque();
    NGC_variable *ngcEnable();
    NGC_variable *surge();
    NGC_variable *sway();
    NGC_variable *yaw();
    NGC_variable *heading();

signals:

    void gcWorkingModeChanged();
    void thrustMappingManualModeChanged();
    void thrustMappingAutoModeChanged();
    void rpmAlphaChanged();
    void forceTorqueChanged();
    void ngcEnableChanged();
    void stopFileCmdChanged();
    void startFileCmdChanged();
    void resumeFileCmdChanged();
    void setSegmentChanged();
    void setSegmentToggleChanged();
    void setLFParChanged();
    void setPFLatLonChanged();
    void setPFParChanged();
    void setLogChanged();
    void setRobotHomeChanged();
    void setLatLonChanged();
    void setXYChanged();
    void setLineLatLonChanged();
    void setXYLineChanged();
    void setYawGSParChanged();
    void setHeadingPiParChanged();
    void surgeChanged();
    void swayChanged();
    void yawChanged();
    void headingChanged();

private:
    TopicVariable m_rpmAlpha;
    TopicVariable m_forceTorque;
    NGC_variable m_ngcEnable;
    TopicVariable m_gcWorkingMode;
    TopicVariable m_thrustMappingManualMode;
    TopicVariable m_thrustMappingAutoMode;
    TopicVariable m_setLog;
    TopicVariable m_setRobotHome;
    TopicVariable m_stopFileCmd;
    TopicVariable m_startFileCmd;
    TopicVariable m_resumeFileCmd;
    TopicVariable m_setLatLon;
    TopicVariable m_setXY;
    TopicVariable m_setLineLatLon;
    TopicVariable m_setXYLine;
    TopicVariable m_setYawGSPar;
    TopicVariable m_setHeadingPiPar;
    TopicVariable m_setLFPar;
    TopicVariable m_setPFLatLon;
    TopicVariable m_setPFPar;
    TopicVariable m_setSegment;
    TopicVariable m_setSegmentToggle;
    NGC_variable m_surge;
    NGC_variable m_sway;
    NGC_variable m_yaw;
    NGC_variable m_heading;

};

#endif // NGC_COMMAND_H
