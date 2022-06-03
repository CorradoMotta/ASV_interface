#include "minion_status.h"

MinionStatus::MinionStatus(QObject *parent)
    : QObject{parent}
{
    m_azimuthMotorAngle.setSubscribe(true);
    m_azimuthMotorConfigurationStatus.setSubscribe(true);
    m_azimuthMotorCurrent.setSubscribe(true);
    m_azimuthMotorEnable.setSubscribe(true);
    m_azimuthMotorFault.setSubscribe(true);
    m_azimuthMotorOperationStatus.setSubscribe(true);
    m_azimuthMotorPosition.setSubscribe(true);
    m_azimuthMotorPower.setSubscribe(true);
    m_azimuthMotorTemperature.setSubscribe(true);
    m_batteryVoltage.setSubscribe(true);
    m_nopCounter.setSubscribe(true);
    m_dateAndTime.setSubscribe(true);
    m_digitalInput.setSubscribe(true);
    m_digitalOutput.setSubscribe(true);
    m_gpsAltitude.setSubscribe(true);
    m_gpsDate.setSubscribe(true);
    m_gpsFixQuality.setSubscribe(true);
    m_gpsHDOP.setSubscribe(true);
    m_gpsLatitude.setSubscribe(true);
    m_gpsLongitude.setSubscribe(true);
    m_gpsMonth.setSubscribe(true);
    m_gpsTime.setSubscribe(true);
    m_gpsYear.setSubscribe(true);
    m_gpsNSatellite.setSubscribe(true);
    m_imuCalibrationStatus.setSubscribe(true);
    m_imuPitch.setSubscribe(true);
    m_imuRoll.setSubscribe(true);
    m_imuTemperature.setSubscribe(true);
    m_imuXGyro.setSubscribe(true);
    m_imuYGyro.setSubscribe(true);
    m_imuYaw.setSubscribe(true);
    m_imuZGyro.setSubscribe(true);
    m_nodeId.setSubscribe(true);
    m_temperature.setSubscribe(true);
    m_thrustMotorCurrent.setSubscribe(true);
    m_thrustMotorEnable.setSubscribe(true);
    m_thrustMotorFault.setSubscribe(true);
    m_thrustMotorPower.setSubscribe(true);
    m_thrustMotorSpeed.setSubscribe(true);
    m_timeMs.setSubscribe(true);
}

DoubleVariable *MinionStatus::azimuthMotorAngle()
{
    return &m_azimuthMotorAngle;
}

IntVariable *MinionStatus::azimuthMotorConfigurationStatus()
{
    return &m_azimuthMotorConfigurationStatus;
}

IntVariable *MinionStatus::azimuthMotorCurrent()
{
    return &m_azimuthMotorCurrent;
}

IntVariable *MinionStatus::azimuthMotorEnable()
{
    return &m_azimuthMotorEnable;
}

IntVariable *MinionStatus::azimuthMotorFault()
{
    return &m_azimuthMotorFault;
}

IntVariable *MinionStatus::azimuthMotorOperationStatus()
{
    return &m_azimuthMotorOperationStatus;
}

IntVariable *MinionStatus::azimuthMotorPosition()
{
    return &m_azimuthMotorPosition;
}

IntVariable *MinionStatus::azimuthMotorPower()
{
    return &m_azimuthMotorPower;
}

IntVariable *MinionStatus::azimuthMotorTemperature()
{
    return &m_azimuthMotorTemperature;
}

DoubleVariable *MinionStatus::batteryVoltage()
{
    return &m_batteryVoltage;
}

IntVariable *MinionStatus::dateAndTime()
{
    return &m_dateAndTime;
}

IntVariable *MinionStatus::digitalInput()
{
    return &m_digitalInput;
}

IntVariable *MinionStatus::digitalOutput()
{
    return &m_digitalOutput;
}

DoubleVariable *MinionStatus::gpsAltitude()
{
    return &m_gpsAltitude;
}

IntVariable *MinionStatus::gpsDate()
{
    return &m_gpsDate;
}

IntVariable *MinionStatus::gpsFixQuality()
{
    return &m_gpsFixQuality;
}

DoubleVariable *MinionStatus::gpsHDOP()
{
    return &m_gpsHDOP;
}

DoubleVariable *MinionStatus::gpsLatitude()
{
    return &m_gpsLatitude;
}

DoubleVariable *MinionStatus::gpsLongitude()
{
    return &m_gpsLongitude;
}

IntVariable *MinionStatus::gpsMonth()
{
    return &m_gpsMonth;
}

DoubleVariable *MinionStatus::gpsTime()
{
    return &m_gpsTime;
}

IntVariable *MinionStatus::gpsYear()
{
    return &m_gpsYear;
}

DoubleVariable *MinionStatus::imuCalibrationStatus()
{
    return &m_imuCalibrationStatus;
}

DoubleVariable *MinionStatus::imuPitch()
{
    return &m_imuPitch;
}

DoubleVariable *MinionStatus::imuRoll()
{
    return &m_imuRoll;
}

DoubleVariable *MinionStatus::imuTemperature()
{
    return &m_imuTemperature;
}

DoubleVariable *MinionStatus::imuXGyro()
{
    return &m_imuXGyro;
}

DoubleVariable *MinionStatus::imuYGyro()
{
    return &m_imuYGyro;
}

DoubleVariable *MinionStatus::imuYaw()
{
    return &m_imuYaw;
}

DoubleVariable *MinionStatus::imuZGyro()
{
    return &m_imuZGyro;
}

IntVariable *MinionStatus::nodeId()
{
    return &m_nodeId;
}

DoubleVariable *MinionStatus::temperature()
{
    return &m_temperature;
}

DoubleVariable *MinionStatus::thrustMotorCurrent()
{
    return &m_thrustMotorCurrent;
}

IntVariable *MinionStatus::thrustMotorEnable()
{
    return &m_thrustMotorEnable;
}

IntVariable *MinionStatus::thrustMotorFault()
{
    return &m_thrustMotorFault;
}

IntVariable *MinionStatus::thrustMotorPower()
{
    return &m_thrustMotorPower;
}

DoubleVariable *MinionStatus::thrustMotorSpeed()
{
    return &m_thrustMotorSpeed;
}

IntVariable *MinionStatus::timeMs()
{
    return &m_timeMs;
}

DoubleVariable *MinionStatus::thrustMotorTemperature()
{
    return &m_thrustMotorTemperature;
}

IntVariable *MinionStatus::gpsNSatellite()
{
    return &m_gpsNSatellite;
}

DoubleVariable *MinionStatus::nopCounter()
{
    return &m_nopCounter;
}

DoubleVariable *MinionStatus::gpsHeightGeoid()
{
    return &m_gpsHeightGeoid;
}

IntVariable *MinionStatus::is_alive()
{
    return &m_is_alive;
}
