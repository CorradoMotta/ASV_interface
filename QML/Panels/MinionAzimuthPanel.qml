/*************************************************************************
 *
 * This element contains the Minion azimuth panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

BasicMinionPanelContainer{
    title: "AZIMUTH"

    required property int azimuth_motor_enable
    required property int azimuth_motor_fault
    required property int azimuth_motor_power

    implicitHeight: pump_row_id.implicitHeight + title_height + 20
    implicitWidth: pump_row_id.implicitWidth + 20

    RowLayout{
        id: pump_row_id
        spacing: 10
        anchors{
            topMargin: title_height
            fill: parent
            leftMargin: 10
        }
        ColumnLayout{
            id: cmd_column_id
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            spacing: 5
            EngineIcon {
                id: engine_icon_fl_azm
                // THIS IS THE LINE NEEDED TO CONNECT ENGINES
                //engineState : engine_panel.engine_state_fl_prova
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                image_size: 60
                set_border: true

            }
            BasicSwitch{
                Layout.topMargin: 15
                switch_text: "SET_HOME"
                onSwitch_is_activeChanged: switch_is_active? minion_view.publish_topic(minion_view.azimuth_motor_set_home_tn, 1)
                                                           : minion_view.publish_topic(minion_view.azimuth_motor_set_home_tn, 0)
            }
            BasicSwitch{
                switch_text: "GO_HOME"
                onSwitch_is_activeChanged: switch_is_active? minion_view.publish_topic(minion_view.azimuth_motor_go_home_tn, 1)
                                                           : minion_view.publish_topic(minion_view.azimuth_motor_go_home_tn, 0)
            }
            BasicSliderVertical {
                id: set_reference
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                //Layout.fillWidth: true
                slider_text: "SET_REFERENCE"
                slider_from: -180
                slider_to: 180
                mask_input: "#000"
                onValueChanged:  minion_view.publish_topic(minion_view.azimuth_motor_set_reference_tn, value)
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
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignTop | Qt.AlignRight

            RowLayout{
                spacing:10
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                //                anchors.right: parent.right
                //                anchors.top: parent.top
                //                anchors.topMargin: 20
                //                anchors.rightMargin: 10
                StatusDot{
                    id: power_dot
                    info_text: "POWER"
                    dot_state: azimuth_motor_power
                }
                StatusDot{
                    id: enable_dot
                    info_text: "ENABLE"
                    dot_state: azimuth_motor_enable
                }
                StatusDot{
                    id: fault_dot
                    info_text: "FAULT"
                    dot_state: azimuth_motor_fault
                }
            }
            //            BasicTextOutput{
            //                Layout.topMargin: 30
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                title_text: "MTR_OP_STATUS"
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                title_text: "MTR_CONF_STATUS"
            //            }
            BasicTextOutput{
                Layout.topMargin: 30
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_POSITION"
                value_text: minion_view.azimuth_motor_position
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_ANGLE"
                value_text: minion_view.azimuth_motor_angle
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_TEMPERATURE"
                value_text: minion_view.azimuth_motor_temperature
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_CURRENT"
                value_text: minion_view.azimuth_motor_current
            }
        }
    }
}

