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
    id: azimuth
    title: "AZIMUTH"

    required property int azimuth_motor_enable
    required property int azimuth_motor_fault
    required property int azimuth_motor_power

    property int engineState

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
            spacing: 8
            EngineIcon {
                id: engine_icon_fl_azm
                // THIS IS THE LINE NEEDED TO CONNECT ENGINES
                engineState : minion_view.engineState //engine_panel.engine_state_fl_prova
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                image_size: 60
                set_border: true
                onEngineStateChanged:{
                    if (engineState === EngineIcon.EngineStates.Engine_inter) minion_view.publish_topic(minion_view.azimuth_motor_power_tn,1)
                    else if (engineState === EngineIcon.EngineStates.Engine_on) minion_view.publish_topic(minion_view.azimuth_motor_enable_tn,1)
                    else if(engineState === EngineIcon.EngineStates.Engine_off) minion_view.publish_topic(minion_view.azimuth_motor_power_tn,0)
                    else if(engineState === EngineIcon.EngineStates.Engine_backToInter) minion_view.publish_topic(minion_view.azimuth_motor_enable_tn,0)
                }
            }
            BasicTextInput{
                Layout.topMargin: 15
                id: set_speed
                //Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                title_text: "SET_SPEED"
                mask: "0000"
                onNew_text_valueChanged: minion_view.publish_topic(minion_view.azimuth_motor_set_max_speed_tn, new_text_value)
            }

            Connections {
                target: homing_panel
                function onSet_angle_is_activeChanged() {
                    if (homing_panel.set_angle_is_active)
                        set_reference.value = minion_view.azimuth_motor_angle_act
                }
                function onGo_home_is_activeChanged(){
                    if (homing_panel.go_home_is_active)
                        minion_view.publish_topic(minion_view.azimuth_motor_go_home_tn, 1)
                }

                function onSet_home_is_activeChanged(){
                    if (homing_panel.set_home_is_active)
                        minion_view.publish_topic(minion_view.azimuth_motor_set_home_tn, 1)
                }

            }

            BasicButton{
                text_on_button: "GO_HOME"
                button_width: 200
                onClicked: minion_view.publish_topic(minion_view.azimuth_motor_go_home_tn, 1)
            }
            BasicButton{
                text_on_button: "SET_HOME"
                button_width: 200
                onClicked: minion_view.publish_topic(minion_view.azimuth_motor_set_home_tn, 1)
            }

            BasicSliderVertical {
                id: set_reference
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                slider_text: "SET_ANGLE"
                slider_from: -180
                slider_to: 180
                mask_input: "#000"
                value: 0
                onValueChanged:  minion_view.publish_topic(minion_view.azimuth_motor_set_reference_tn, value)
                ref_value: minion_view.azimuth_motor_angle_ref
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
                FaultDot{
                    id: fault_dot
                    info_text: "FAULT"
                    dot_state: azimuth_motor_fault
                }
            }
            //            BasicTextOutput{
            //                Layout.topMargin: 30
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                title_text: "OP_STATUS"
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                title_text: "CONF_STATUS"
            //            }
            BasicTextOutput{
                Layout.topMargin: 30
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "POSITION"
                value_text: minion_view.azimuth_motor_position
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "ANGLE"
                value_text: minion_view.azimuth_motor_angle
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "TEMPERATURE"
                value_text: minion_view.azimuth_motor_temperature
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "CURRENT"
                value_text: minion_view.azimuth_motor_current
            }
        }
    }
}

