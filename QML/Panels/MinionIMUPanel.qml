/*************************************************************************
 *
 * This element contains the Minion IMU panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15

import "../BasicItems"

BasicMinionPanelContainer{
    title: "IMU"
    implicitHeight: pump_row_id.implicitHeight + title_height + 20
    implicitWidth: pump_row_id.implicitWidth + 20

    RowLayout{
        id: pump_row_id
        spacing: 10
        anchors{
            topMargin: title_height + 20
            fill: parent
            leftMargin: 10
            rightMargin: 10
        }
        ColumnLayout{
            id: cmd_column_id
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            BasicTextOutputInverted{
                //Layout.topMargin: 30
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "YAW"
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "PITCH"
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "ROLL"
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "TEMPERATURE"
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
                //Layout.topMargin: 30
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "X_GYRO"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "Y_GYRO"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "Z_GYRO"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "CALIBRATION"
            }

        }
    }
}
