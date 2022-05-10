/*************************************************************************
 *
 * This element contains the view of a single minion. It is intended to be
 * used as a content of a tab bar where all minions can be viewed.
 * At the beginning all elements coming from the cpp model are defined.
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../Panels"

Item {
    id: minion_view
    property int minimumXDim : minion_panel_cln.implicitWidth
    property int minimumYDim: minion_panel_cln.implicitHeight

    required property var prefix
    readonly property var publish_topic: data_model.data_source.publishMessage

    //----------------------------------------------------------------------------------------------
    // from cpp model - status
    //----------------------------------------------------------------------------------------------

    // GENERIC
    readonly property real   nodeID: prefix.minionState.nodeId.value
    readonly property string date_and_time: prefix.minionState.dateAndTime.value
    readonly property real nop_counter: prefix.minionState.nopCounter.value
    readonly property real   battery_voltage: prefix.minionState.batteryVoltage.value

    // THRUST
    readonly property real thrust_motor_current:  prefix.minionState.thrustMotorCurrent.value
    readonly property int  thrust_motor_temperature:  prefix.minionState.thrustMotorTemperature.value
    readonly property real thrust_motor_speed:  prefix.minionState.thrustMotorSpeed.value

    // AZIMUTH
    readonly property int  azimuth_motor_position:  prefix.minionState.azimuthMotorPosition.value
    readonly property real azimuth_motor_angle:  prefix.minionState.azimuthMotorAngle.value
    readonly property int  azimuth_motor_temperature:  prefix.minionState.azimuthMotorTemperature.value
    readonly property int  azimuth_motor_current:  prefix.minionState.azimuthMotorCurrent.value

    // IMU
    readonly property real imu_yaw:  prefix.minionState.imuYaw.value
    readonly property real imu_pitch:  prefix.minionState.imuPitch.value
    readonly property real imu_roll:  prefix.minionState.imuRoll.value
    readonly property real imu_temperature:  prefix.minionState.imuTemperature.value
    readonly property real imu_x_gyro:  prefix.minionState.imuXGyro.value
    readonly property real imu_y_gyro:  prefix.minionState.imuYGyro.value
    readonly property real imu_z_gyro:  prefix.minionState.imuZGyro.value

    // GPS
    readonly property real gps_latitude:  prefix.minionState.gpsLatitude.value
    readonly property real gps_longitude:  prefix.minionState.gpsLongitude.value
    readonly property real gps_altitude:  prefix.minionState.gpsAltitude.value
    readonly property int  gps_fix:  prefix.minionState.gpsFixQuality.value
    readonly property int  gps_ns:  prefix.minionState.gpsNSatellite.value

    //----------------------------------------------------------------------------------------------
    // from cpp model - command
    //----------------------------------------------------------------------------------------------

    // GENERIC
    readonly property string log_tn: prefix.minionCmd.log.topic_name
    readonly property string changeTlmAddr_tn: prefix.minionCmd.changeTlmAddr.topic_name
    readonly property string shutdown_tn: prefix.minionCmd.shutdown.topic_name
    readonly property string reboot_tn: prefix.minionCmd.reboot.topic_name

    // THRUST
    readonly property string thrust_motor_power_tn: prefix.minionCmd.thrustMotorPower.topic_name
    readonly property string thrust_motor_enable_tn: prefix.minionCmd.thrustMotorEnable.topic_name
    readonly property string thrust_motor_set_reference_tn: prefix.minionCmd.thrustMotorSetReference.topic_name

    // AZIMUTH
    readonly property string azimuth_motor_power_tn: prefix.minionCmd.azimuthMotorPower.topic_name
    readonly property string azimuth_motor_enable_tn: prefix.minionCmd.azimuthMotorEnable.topic_name
    readonly property string azimuth_motor_set_reference_tn: prefix.minionCmd.azimuthMotorSetReference.topic_name
    readonly property string azimuth_motor_set_home_tn: prefix.minionCmd.azimuthSetHome.topic_name
    readonly property string azimuth_motor_go_home_tn: prefix.minionCmd.azimuthGoHome.topic_name
    readonly property string azimuth_motor_set_max_speed_tn: prefix.minionCmd.azimuthSetMaxSpeed.topic_name


    ColumnLayout{
        id: minion_panel_cln
        anchors{
            fill: parent
        }
        spacing: 2
        MinionGenericPanel{
            id: generic
            Layout.minimumHeight: generic.implicitHeight
            Layout.minimumWidth: generic.implicitWidth
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

                pump_motor_enable: prefix.minionState.thrustMotorEnable.value
                pump_motor_fault:  prefix.minionState.thrustMotorFault.value
                pump_motor_power:  prefix.minionState.thrustMotorPower.value

                Layout.minimumHeight: Math.max(pump_panel.implicitHeight, azimuth_panel.implicitHeight)
                Layout.minimumWidth: pump_panel.implicitWidth
                //Layout.preferredHeight: pump_panel.minimumHeight
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            MinionAzimuthPanel{
                id: azimuth_panel

                azimuth_motor_enable: prefix.minionState.azimuthMotorEnable.value
                azimuth_motor_fault:  prefix.minionState.azimuthMotorFault.value
                azimuth_motor_power:  prefix.minionState.azimuthMotorPower.value

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
