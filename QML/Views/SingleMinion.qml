/*************************************************************************
 *
 * This element contains the view of a single minion. It is intended to be
 * used as a content of a tab bar where all minions can be viewed.
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../Panels"

Item {
    id: minion_view
    property int minimumXDim : minion_panel_cln.implicitWidth
    property int minimumYDim: minion_panel_cln.implicitHeight

    // from cpp model - status
    required property var prefix
    readonly property real nodeID: prefix.minionState.nodeId.value
    readonly property string date_and_time: prefix.minionState.dateAndTime.value
    // todo add nop_counter ? property real nop_counter
    readonly property real battery_voltage: prefix.minionState.batteryVoltage.value

    // THRUST
    readonly property real thrust_motor_current:  prefix.minionState.thrustMotorCurrent.value
    readonly property int thrust_motor_temperature:  prefix.minionState.thrustMotorTemperature.value
    readonly property real thrust_motor_speed:  prefix.minionState.thrustMotorSpeed.value

    // AZIMUTH
    readonly property int azimuth_motor_position:  prefix.minionState.azimuthMotorPosition.value
    readonly property real azimuth_motor_angle:  prefix.minionState.azimuthMotorAngle.value
    readonly property int azimuth_motor_temperature:  prefix.minionState.azimuthMotorTemperature.value
    readonly property int  azimuth_motor_current:  prefix.minionState.azimuthMotorCurrent.value

    // IMU
    readonly property real imu_yaw:  prefix.minionState.imuYaw.value
    readonly property real imu_pitch:  prefix.minionState.imuPitch.value
    readonly property real imu_roll:  prefix.minionState.imuRoll.value
    readonly property int imu_temperature:  prefix.minionState.imuTemperature.value
    readonly property real imu_x_gyro:  prefix.minionState.imuXGyro.value
    readonly property real imu_y_gyro:  prefix.minionState.imuYGyro.value
    readonly property real imu_z_gyro:  prefix.minionState.imuZGyro.value

    // GPS
    readonly property real gps_latitude:  prefix.minionState.gpsLatitude.value
    readonly property real gps_longitude:  prefix.minionState.gpsLongitude.value
    readonly property real gps_altitude:  prefix.minionState.gpsAltitude.value
    readonly property int gps_fix:  prefix.minionState.gpsFixQuality.value
    readonly property int gps_ns:  prefix.minionState.gpsNSatellite.value

    ColumnLayout{
        id: minion_panel_cln
        anchors{
            fill: parent
        }
        spacing: 2
        MinionGenericPanel{
            id: generic
            Layout.minimumHeight: implicitHeight
            Layout.minimumWidth: implicitWidth
            Layout.preferredHeight: generic.minimumHeight + 50
            Layout.fillWidth: true
        }
        GridLayout{
            id: minion_panel_grid
            columns: 2
            columnSpacing: 2
            rowSpacing: 2

            MinionPumpPanel{
                id: pump_panel
                Layout.minimumHeight: Math.max(pump_panel.implicitHeight, azimuth_panel.implicitHeight)
                Layout.minimumWidth: pump_panel.implicitWidth
                //Layout.preferredHeight: pump_panel.minimumHeight
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            MinionAzimuthPanel{
                id: azimuth_panel
                Layout.minimumHeight: Math.max(pump_panel.implicitHeight, azimuth_panel.implicitHeight)
                //Layout.preferredHeight: azimuth_panel.minimumHeight
                Layout.minimumWidth: azimuth_panel.implicitWidth
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            MinionIMUPanel{
                id: imu_panel
                Layout.minimumHeight: Math.max(imu_panel.implicitHeight, gps_panel.implicitHeight)
                Layout.minimumWidth: imu_panel.implicitWidth
                //Layout.preferredHeight: imu_panel.minimumHeight
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            MinionGPSPanel{
                id: gps_panel
                Layout.minimumHeight: Math.max(imu_panel.implicitHeight, gps_panel.implicitHeight)
                Layout.minimumWidth: gps_panel.implicitWidth
                //Layout.preferredHeight: gps_panel.minimumHeight
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
