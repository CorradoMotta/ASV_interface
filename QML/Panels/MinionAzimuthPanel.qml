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
    RowLayout{
        spacing: 10
        anchors{
            topMargin: 20
            fill: parent
            leftMargin: 10
        }
        ColumnLayout{
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
                switch_text: "SET_MAX_SPEED"
            }
            BasicSwitch{
                switch_text: "SET_HOME"
            }
            BasicSwitch{
                switch_text: "GO_HOME"
            }
//            BasicSwitch{
//                switch_text: "SET_REF_TICK"
//            }
            BasicSliderVertical{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                slider_text: "SET_ANGLE"
                mask_input: "#000"
            }
            BasicSliderVertical{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                slider_text: "SET_POSITION"
                mask_input: "#000"
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
                    color: "red"
                }
                StatusDot{
                    id: enable_dot
                    info_text: "ENABLE"
                    color: "green"
                }
                StatusDot{
                    id: fault_dot
                    info_text: "FAULT"
                    color: "gray"
                }
            }
            BasicTextOutput{
                Layout.topMargin: 30
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_OP_STATUS"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_CONF_STATUS"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_POSITION"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_ANGLE"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_TEMPERATURE"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_CURRENT"
            }
        }
    }
}

