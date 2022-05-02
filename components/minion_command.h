#ifndef MINION_COMMAND_H
#define MINION_COMMAND_H

#include <QObject>
#include <data/doublevariable.h>
#include <data/intvariable.h>

class MinionCommand : public QObject
{
    Q_OBJECT

    Q_PROPERTY(IntVariable* nop READ nop NOTIFY nopChanged)
    Q_PROPERTY(IntVariable* shutdown READ shutdown NOTIFY shutdownChanged)
    Q_PROPERTY(IntVariable* reboot READ reboot NOTIFY rebootChanged)
    Q_PROPERTY(IntVariable* changeTlmAddr READ changeTlmAddr NOTIFY changeTlmAddrChanged)
    Q_PROPERTY(IntVariable* ipAddr READ ipAddr NOTIFY ipAddrChanged)
    Q_PROPERTY(IntVariable* udpPort READ udpPort NOTIFY udpPortChanged)
    Q_PROPERTY(IntVariable* enableDebugLog READ enableDebugLog NOTIFY enableDebugLogChanged)
    Q_PROPERTY(IntVariable* setDigital READ setDigital NOTIFY setDigitalChanged)
    Q_PROPERTY(IntVariable* setAnalog READ setAnalog NOTIFY setAnalogChanged)
    Q_PROPERTY(IntVariable* thrustMotorPower READ thrustMotorPower NOTIFY thrustMotorPowerChanged)
    Q_PROPERTY(IntVariable* thrustMotorEnable READ thrustMotorEnable NOTIFY thrustMotorEnableChanged)
    Q_PROPERTY(DoubleVariable* thrustMotorSetReference READ thrustMotorSetReference NOTIFY thrustMotorSetReferenceChanged)
    Q_PROPERTY(IntVariable* azimuthMotorPower READ azimuthMotorPower NOTIFY azimuthMotorPowerChanged)
    Q_PROPERTY(IntVariable* azimuthMotorEnable READ azimuthMotorEnable NOTIFY azimuthMotorEnableChanged)
    Q_PROPERTY(IntVariable* azimuthSetMaxSpeed READ azimuthSetMaxSpeed NOTIFY azimuthSetMaxSpeedChanged)
    Q_PROPERTY(IntVariable* azimuthSetHome READ azimuthSetHome NOTIFY azimuthSetHomeChanged)
    Q_PROPERTY(IntVariable* azimuthGoHome READ azimuthGoHome NOTIFY azimuthGoHomeChanged)
    Q_PROPERTY(DoubleVariable* azimuthMotorSetReference READ azimuthMotorSetReference NOTIFY azimuthMotorSetReferenceChanged)
    Q_PROPERTY(IntVariable* azimuthMotorSetRefTick READ azimuthMotorSetRefTick NOTIFY azimuthMotorSetRefTickChanged)
    Q_PROPERTY(IntVariable* log READ log NOTIFY logChanged)


public:
    explicit MinionCommand(QObject *parent = nullptr);

    IntVariable *nop();
    IntVariable *shutdown();
    IntVariable *reboot();
    IntVariable *changeTlmAddr();
    IntVariable *ipAddr();
    IntVariable *udpPort();
    IntVariable *enableDebugLog();
    IntVariable *setDigital();
    IntVariable *setAnalog();
    IntVariable *thrustMotorPower();
    IntVariable *thrustMotorEnable();
    DoubleVariable *thrustMotorSetReference();
    IntVariable *azimuthMotorPower();
    IntVariable *azimuthMotorEnable();
    IntVariable *azimuthSetMaxSpeed();
    IntVariable *azimuthSetHome();
    IntVariable *azimuthGoHome();
    DoubleVariable *azimuthMotorSetReference();
    IntVariable *azimuthMotorSetRefTick();
    IntVariable *log();

signals:

    void nopChanged();
    void shutdownChanged();
    void rebootChanged();
    void changeTlmAddrChanged();
    void ipAddrChanged();
    void udpPortChanged();
    void enableDebugLogChanged();
    void setDigitalChanged();
    void setAnalogChanged();
    void thrustMotorPowerChanged();
    void thrustMotorEnableChanged();
    void thrustMotorSetReferenceChanged();
    void azimuthMotorPowerChanged();
    void azimuthSetMaxSpeedChanged();
    void azimuthSetHomeChanged();
    void azimuthGoHomeChanged();
    void azimuthMotorSetReferenceChanged();
    void azimuthMotorSetRefTickChanged();
    void azimuthMotorEnableChanged();
    void logChanged();

private:

    IntVariable m_nop;
    IntVariable m_shutdown;
    IntVariable m_reboot;
    IntVariable m_changeTlmAddr;
    IntVariable m_ipAddr;
    IntVariable m_udpPort;
    IntVariable m_enableDebugLog;
    IntVariable m_setDigital;
    IntVariable m_setAnalog;
    IntVariable m_thrustMotorPower;
    IntVariable m_thrustMotorEnable;
    DoubleVariable m_thrustMotorSetReference;
    IntVariable m_azimuthMotorPower;
    IntVariable m_azimuthMotorEnable;
    IntVariable m_azimuthSetMaxSpeed;
    IntVariable m_azimuthSetHome;
    IntVariable m_azimuthGoHome;
    DoubleVariable m_azimuthMotorSetReference;
    IntVariable m_azimuthMotorSetRefTick;
    IntVariable m_log;
};

#endif // MINION_COMMAND_H
