/*************************************************************************
 *
 * This element contains the Minion pump panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "../BasicItems"

BasicMinionPanelContainer{
    title: "PUMP"

    required property int pump_motor_enable
    required property int pump_motor_fault
    required property int pump_motor_power

    implicitHeight: pump_row_id.implicitHeight + title_height + 20
    implicitWidth: pump_row_id.implicitWidth + 20

    RowLayout{
        id: pump_row_id
        spacing: 10
        anchors{
            topMargin: title_height+ 10
            fill: parent
            leftMargin: 10
        }
        ColumnLayout{
            id: cmd_column_id
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            spacing: 30
            EngineIcon {
                id: engine_icon_fl
                // THIS IS THE LINE NEEDED TO CONNECT ENGINES
                //engineState : engine_panel.engine_state_fl_prova
                engineState : minion_view.engineState
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                image_size: 60
                set_border: true
                onEngineStateChanged:{
                    if      (engineState === EngineIcon.EngineStates.Engine_inter) minion_view.publish_topic(minion_view.thrust_motor_power_tn,1)
                    else if (engineState === EngineIcon.EngineStates.Engine_on) minion_view.publish_topic(minion_view.thrust_motor_enable_tn,1)
                    else if (engineState === EngineIcon.EngineStates.Engine_off) minion_view.publish_topic(minion_view.thrust_motor_power_tn,0)
                    else if (engineState === EngineIcon.EngineStates.Engine_backToInter) minion_view.publish_topic(minion_view.thrust_motor_enable_tn,0)
                }

            }
            BasicSliderVertical {
                id: set_reference
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                //Layout.fillWidth: true
                slider_text: "SET_RPM"
                slider_from: 0
                slider_to: 2000
                mask_input: "0000"
                onValueChanged:  minion_view.publish_topic(minion_view.thrust_motor_set_reference_tn, value)
                ref_value: minion_view.thrust_motor_speed_ref
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

                spacing: 5
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                //                anchors.right: parent.right
                //                anchors.top: parent.top
                //                anchors.topMargin: 20
                //                anchors.rightMargin: 10
                StatusDot{
                    id: power_dot
                    info_text: "POWER"
                    //color: "gray"
                    dot_state: pump_motor_power
                }
                StatusDot{
                    id: enable_dot
                    info_text: "ENABLE"
                    //color: "gray"
                    dot_state: pump_motor_enable
                }
                FaultDot{
                    id: fault_dot
                    info_text: "FAULT"
                    //color: "gray"
                    dot_state: pump_motor_fault
                }
            }
            BasicTextOutput{
                Layout.topMargin: 30
                value_width: text_value_width
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "CURRENT"
                value_text: minion_view.thrust_motor_current
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: text_value_width
                title_text: "TEMPERATURE"
                value_text: minion_view.thrust_motor_temperature
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: text_value_width
                title_text: "SPEED"
                value_text: minion_view.thrust_motor_speed
            }
        }
    }

}
