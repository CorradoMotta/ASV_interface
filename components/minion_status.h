#ifndef MINION_STATUS_H
#define MINION_STATUS_H

#include <QObject>
#include <data/doublevariable.h>
#include <data/intvariable.h>

class MinionStatus : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DoubleVariable* azimuthMotorAngle READ azimuthMotorAngle NOTIFY azimuthMotorAngleChanged)
    Q_PROPERTY(IntVariable* azimuthMotorConfigurationStatus READ azimuthMotorConfigurationStatus NOTIFY azimuthMotorConfigurationStatusChanged)
    Q_PROPERTY(IntVariable* azimuthMotorCurrent READ azimuthMotorCurrent NOTIFY azimuthMotorCurrentChanged)
    Q_PROPERTY(IntVariable* azimuthMotorEnable READ azimuthMotorEnable NOTIFY azimuthMotorEnableChanged)
    Q_PROPERTY(IntVariable* azimuthMotorFault READ azimuthMotorFault NOTIFY azimuthMotorFaultChanged)
    Q_PROPERTY(IntVariable* azimuthMotorOperationStatus READ azimuthMotorOperationStatus NOTIFY azimuthMotorOperationStatusChanged)
    Q_PROPERTY(IntVariable* azimuthMotorPosition READ azimuthMotorPosition NOTIFY azimuthMotorPositionChanged)
    Q_PROPERTY(IntVariable* azimuthMotorPower READ azimuthMotorPower NOTIFY azimuthMotorPowerChanged)
    Q_PROPERTY(IntVariable* azimuthMotorTemperature READ azimuthMotorTemperature NOTIFY azimuthMotorTemperatureChanged)
    Q_PROPERTY(DoubleVariable* batteryVoltage READ batteryVoltage NOTIFY batteryVoltageChanged)
    Q_PROPERTY(IntVariable* dateAndTime READ dateAndTime NOTIFY dateAndTimeChanged)
    Q_PROPERTY(IntVariable* digitalInput READ digitalInput NOTIFY digitalInputChanged)
    Q_PROPERTY(IntVariable* digitalOutput READ digitalOutput NOTIFY digitalOutputChanged)
    Q_PROPERTY(DoubleVariable* gpsAltitude READ gpsAltitude NOTIFY gpsAltitudeChanged)
    Q_PROPERTY(IntVariable* gpsDay READ gpsDay NOTIFY gpsDayChanged)
    Q_PROPERTY(IntVariable* gpsFixQuality READ gpsFixQuality NOTIFY gpsFixQualityChanged)
    Q_PROPERTY(DoubleVariable* gpsHDOP READ gpsHDOP NOTIFY gpsHDOPChanged)
    Q_PROPERTY(DoubleVariable* gpsLatitude READ gpsLatitude NOTIFY gpsLatitudeChanged)
    Q_PROPERTY(DoubleVariable* gpsLongitude READ gpsLongitude NOTIFY gpsLongitudeChanged)
    Q_PROPERTY(IntVariable* gpsMonth READ gpsMonth NOTIFY gpsMonthChanged)
    Q_PROPERTY(DoubleVariable* gpsTime READ gpsTime NOTIFY gpsTimeChanged)
    Q_PROPERTY(IntVariable* gpsNSatellite READ gpsNSatellite NOTIFY gpsNSatelliteChanged)
    Q_PROPERTY(IntVariable* gpsYear READ gpsYear NOTIFY gpsYearChanged)
    Q_PROPERTY(DoubleVariable* imuCalibrationStatus READ imuCalibrationStatus NOTIFY imuCalibrationStatusChanged)
    Q_PROPERTY(DoubleVariable* imuPitch READ imuPitch NOTIFY imuPitchChanged)
    Q_PROPERTY(DoubleVariable* imuRoll READ imuRoll NOTIFY imuRollChanged)
    Q_PROPERTY(IntVariable* imuTemperature READ imuTemperature NOTIFY imuTemperatureChanged)
    Q_PROPERTY(DoubleVariable* imuXGyro READ imuXGyro NOTIFY imuXGyroChanged)
    Q_PROPERTY(DoubleVariable* imuYGyro READ imuYGyro NOTIFY imuYGyroChanged)
    Q_PROPERTY(DoubleVariable* imuYaw READ imuYaw NOTIFY imuYawChanged)
    Q_PROPERTY(DoubleVariable* imuZGyro READ imuZGyro NOTIFY imuZGyroChanged)
    Q_PROPERTY(IntVariable* nodeId READ nodeId NOTIFY nodeIdChanged)
    Q_PROPERTY(DoubleVariable* temperature READ temperature NOTIFY temperatureChanged)
    Q_PROPERTY(DoubleVariable* thrustMotorCurrent READ thrustMotorCurrent NOTIFY thrustMotorCurrentChanged)
    Q_PROPERTY(IntVariable* thrustMotorEnable READ thrustMotorEnable NOTIFY thrustMotorEnableChanged)
    Q_PROPERTY(IntVariable* thrustMotorFault READ thrustMotorFault NOTIFY thrustMotorFaultChanged)
    Q_PROPERTY(IntVariable* thrustMotorPower READ thrustMotorPower NOTIFY thrustMotorPowerChanged)
    Q_PROPERTY(DoubleVariable* thrustMotorSpeed READ thrustMotorSpeed NOTIFY thrustMotorSpeedChanged)
    Q_PROPERTY(IntVariable* thrustMotorTemperature READ thrustMotorTemperature NOTIFY thrustMotorTemperatureChanged)
    Q_PROPERTY(IntVariable* timeMs READ timeMs NOTIFY timeMsChanged)

public:
    explicit MinionStatus(QObject *parent = nullptr);

    DoubleVariable* azimuthMotorAngle();
    IntVariable* azimuthMotorConfigurationStatus();
    IntVariable* azimuthMotorCurrent();
    IntVariable* azimuthMotorEnable();
    IntVariable* azimuthMotorFault();
    IntVariable* azimuthMotorOperationStatus();
    IntVariable* azimuthMotorPosition();
    IntVariable* azimuthMotorPower();
    IntVariable* azimuthMotorTemperature();
    DoubleVariable* batteryVoltage();
    IntVariable* dateAndTime();
    IntVariable* digitalInput();
    IntVariable* digitalOutput();
    DoubleVariable* gpsAltitude();
    IntVariable* gpsDay();
    IntVariable* gpsFixQuality();
    DoubleVariable* gpsHDOP();
    DoubleVariable* gpsLatitude();
    DoubleVariable* gpsLongitude();
    IntVariable* gpsMonth();
    DoubleVariable* gpsTime();
    IntVariable* gpsYear();
    DoubleVariable* imuCalibrationStatus();
    DoubleVariable* imuPitch();
    DoubleVariable* imuRoll();
    IntVariable* imuTemperature();
    DoubleVariable* imuXGyro();
    DoubleVariable* imuYGyro();
    DoubleVariable* imuYaw();
    DoubleVariable* imuZGyro();
    IntVariable* nodeId();
    DoubleVariable* temperature();
    DoubleVariable* thrustMotorCurrent();
    IntVariable* thrustMotorEnable();
    IntVariable* thrustMotorFault();
    IntVariable* thrustMotorPower();
    DoubleVariable* thrustMotorSpeed();
    IntVariable* timeMs();
    IntVariable* thrustMotorTemperature();
    IntVariable* gpsNSatellite();

signals:

    void azimuthMotorAngleChanged();
    void azimuthMotorConfigurationStatusChanged();
    void azimuthMotorCurrentChanged();
    void azimuthMotorEnableChanged();
    void azimuthMotorFaultChanged();
    void azimuthMotorOperationStatusChanged();
    void azimuthMotorPositionChanged();
    void azimuthMotorPowerChanged();
    void azimuthMotorTemperatureChanged();
    void batteryVoltageChanged();
    void dateAndTimeChanged();
    void digitalInputChanged();
    void digitalOutputChanged();
    void gpsAltitudeChanged();
    void gpsDayChanged();
    void gpsFixQualityChanged();
    void gpsHDOPChanged();
    void gpsLatitudeChanged();
    void gpsLongitudeChanged();
    void gpsMonthChanged();
    void gpsTimeChanged();
    void gpsYearChanged();
    void imuCalibrationStatusChanged();
    void imuPitchChanged();
    void imuRollChanged();
    void imuTemperatureChanged();
    void imuXGyroChanged();
    void imuYGyroChanged();
    void imuYawChanged();
    void imuZGyroChanged();
    void nodeIdChanged();
    void temperatureChanged();
    void thrustMotorCurrentChanged();
    void thrustMotorEnableChanged();
    void thrustMotorFaultChanged();
    void thrustMotorPowerChanged();
    void thrustMotorSpeedChanged();
    void timeMsChanged();
    void thrustMotorTemperatureChanged();
    void gpsNSatelliteChanged();

private:
    DoubleVariable m_azimuthMotorAngle;
    IntVariable m_azimuthMotorConfigurationStatus;
    IntVariable m_azimuthMotorCurrent;
    IntVariable m_azimuthMotorEnable;
    IntVariable m_azimuthMotorFault;
    IntVariable m_azimuthMotorOperationStatus;
    IntVariable m_azimuthMotorPosition;
    IntVariable m_azimuthMotorPower;
    IntVariable m_azimuthMotorTemperature;
    DoubleVariable m_batteryVoltage;
    IntVariable m_dateAndTime;
    IntVariable m_digitalInput;
    IntVariable m_digitalOutput;
    DoubleVariable m_gpsAltitude;
    IntVariable m_gpsDay;
    IntVariable m_gpsFixQuality;
    DoubleVariable m_gpsHDOP;
    DoubleVariable m_gpsLatitude;
    DoubleVariable m_gpsLongitude;
    IntVariable m_gpsMonth;
    DoubleVariable m_gpsTime;
    IntVariable m_gpsYear;
    DoubleVariable m_imuCalibrationStatus;
    DoubleVariable m_imuPitch;
    DoubleVariable m_imuRoll;
    IntVariable m_imuTemperature;
    DoubleVariable m_imuXGyro;
    DoubleVariable m_imuYGyro;
    DoubleVariable m_imuYaw;
    DoubleVariable m_imuZGyro;
    IntVariable m_nodeId;
    DoubleVariable m_temperature;
    DoubleVariable m_thrustMotorCurrent;
    IntVariable m_thrustMotorEnable;
    IntVariable m_thrustMotorFault;
    IntVariable m_thrustMotorPower;
    DoubleVariable m_thrustMotorSpeed;
    IntVariable m_timeMs;
    IntVariable m_thrustMotorTemperature;
    IntVariable m_gpsNSatellite;
};

#endif // MINION_STATUS_H
