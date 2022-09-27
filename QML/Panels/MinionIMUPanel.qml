/*************************************************************************
 *
 * This element contains the Minion IMU panel. It is intended to be
 * shown in the SingleMinion view. It displays the telemetry received from
 * the minion IMU.
 *
 * Author: Corrado Motta
 * Date: 03/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15

import "../BasicItems"

BasicMinionPanelContainer{
    title: "IMU"

    // properties
    implicitHeight: pump_row_id.implicitHeight + title_height + 20
    implicitWidth: pump_row_id.implicitWidth + 20

    RowLayout{
        id: pump_row_id
        spacing: 10
        anchors{
            topMargin: title_height
            fill: parent
            leftMargin: 10
            rightMargin: 10
        }
        ColumnLayout{
            id: cmd_column_id
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "YAW"
                value_text: minion_view.imu_yaw
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "PITCH"
                value_text: minion_view.imu_pitch
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "ROLL"
                value_text: minion_view.imu_roll
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "TEMPERATURE"
                value_text: minion_view.imu_temperature
            }
        }
        Rectangle {
            Layout.fillHeight: true
            Layout.bottomMargin: 60
            Layout.topMargin: title_height + 40
            width: 2
            color: "gray"
        }
        ColumnLayout{
            id: status_column_id
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "X_GYRO"
                value_text: minion_view.imu_x_gyro
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "Y_GYRO"
                value_text: minion_view.imu_y_gyro
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "Z_GYRO"
                value_text: minion_view.imu_z_gyro
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "CALIB"
                value_text: minion_view.imuCalibrationStatus
            }
        }
    }
}
