/*************************************************************************
 *
 * Class that contains all minion commands.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

#ifndef MINION_COMMAND_H
#define MINION_COMMAND_H

#include <QObject>
#include <data/doublevariable.h>
#include <data/ngc_variable.h>
#include <data/TopicVariable.h>

class MinionCommand : public QObject
{
    Q_OBJECT

    Q_PROPERTY(TopicVariable* nop READ nop NOTIFY nopChanged)
    Q_PROPERTY(TopicVariable* shutdown READ shutdown NOTIFY shutdownChanged)
    Q_PROPERTY(TopicVariable* reboot READ reboot NOTIFY rebootChanged)
    Q_PROPERTY(TopicVariable* changeTlmAddr READ changeTlmAddr NOTIFY changeTlmAddrChanged)
    Q_PROPERTY(TopicVariable* ipAddr READ ipAddr NOTIFY ipAddrChanged)
    Q_PROPERTY(TopicVariable* udpPort READ udpPort NOTIFY udpPortChanged)
    Q_PROPERTY(TopicVariable* enableDebugLog READ enableDebugLog NOTIFY enableDebugLogChanged)
    Q_PROPERTY(TopicVariable* setDigital READ setDigital NOTIFY setDigitalChanged)
    Q_PROPERTY(TopicVariable* setAnalog READ setAnalog NOTIFY setAnalogChanged)
    Q_PROPERTY(TopicVariable* thrustMotorPower READ thrustMotorPower NOTIFY thrustMotorPowerChanged)
    Q_PROPERTY(TopicVariable* thrustMotorEnable READ thrustMotorEnable NOTIFY thrustMotorEnableChanged)
    Q_PROPERTY(NGC_variable* thrustMotorSetReference READ thrustMotorSetReference NOTIFY thrustMotorSetReferenceChanged)
    Q_PROPERTY(TopicVariable* azimuthMotorPower READ azimuthMotorPower NOTIFY azimuthMotorPowerChanged)
    Q_PROPERTY(TopicVariable* azimuthMotorEnable READ azimuthMotorEnable NOTIFY azimuthMotorEnableChanged)
    Q_PROPERTY(TopicVariable* azimuthSetMaxSpeed READ azimuthSetMaxSpeed NOTIFY azimuthSetMaxSpeedChanged)
    Q_PROPERTY(TopicVariable* azimuthSetHome READ azimuthSetHome NOTIFY azimuthSetHomeChanged)
    Q_PROPERTY(TopicVariable* azimuthGoHome READ azimuthGoHome NOTIFY azimuthGoHomeChanged)
    Q_PROPERTY(NGC_variable* azimuthMotorSetReference READ azimuthMotorSetReference NOTIFY azimuthMotorSetReferenceChanged)
    Q_PROPERTY(TopicVariable* azimuthMotorSetRefTick READ azimuthMotorSetRefTick NOTIFY azimuthMotorSetRefTickChanged)
    Q_PROPERTY(TopicVariable* log READ log NOTIFY logChanged)


public:
    explicit MinionCommand(QObject *parent = nullptr);

    TopicVariable *nop();
    TopicVariable *shutdown();
    TopicVariable *reboot();
    TopicVariable *changeTlmAddr();
    TopicVariable *ipAddr();
    TopicVariable *udpPort();
    TopicVariable *enableDebugLog();
    TopicVariable *setDigital();
    TopicVariable *setAnalog();
    TopicVariable *thrustMotorPower();
    TopicVariable *thrustMotorEnable();
    NGC_variable *thrustMotorSetReference();
    TopicVariable *azimuthMotorPower();
    TopicVariable *azimuthMotorEnable();
    TopicVariable *azimuthSetMaxSpeed();
    TopicVariable *azimuthSetHome();
    TopicVariable *azimuthGoHome();
    NGC_variable *azimuthMotorSetReference();
    TopicVariable *azimuthMotorSetRefTick();
    TopicVariable *log();

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

    TopicVariable m_nop;
    TopicVariable m_shutdown;
    TopicVariable m_reboot;
    TopicVariable m_changeTlmAddr;
    TopicVariable m_ipAddr;
    TopicVariable m_udpPort;
    TopicVariable m_enableDebugLog;
    TopicVariable m_setDigital;
    TopicVariable m_setAnalog;
    TopicVariable m_thrustMotorPower;
    TopicVariable m_thrustMotorEnable;
    NGC_variable m_thrustMotorSetReference;
    TopicVariable m_azimuthMotorPower;
    TopicVariable m_azimuthMotorEnable;
    TopicVariable m_azimuthSetMaxSpeed;
    TopicVariable m_azimuthSetHome;
    TopicVariable m_azimuthGoHome;
    NGC_variable m_azimuthMotorSetReference;
    TopicVariable m_azimuthMotorSetRefTick;
    TopicVariable m_log;
};

#endif // MINION_COMMAND_H
