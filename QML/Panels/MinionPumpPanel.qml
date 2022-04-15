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
    id: pump_root

    title: "PUMP"
    RowLayout{
        spacing: 10
        anchors{
            topMargin: 20
            fill: parent
            leftMargin: 10
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            spacing: 30
            EngineIcon {
                id: engine_icon_fl
                // THIS IS THE LINE NEEDED TO CONNECT ENGINES
                //engineState : engine_panel.engine_state_fl_prova
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                image_size: 60
                set_border: true

            }
            BasicSliderVertical {
                id: set_reference
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                //Layout.fillWidth: true
                slider_text: "SET_REF"
                mask_input: "#000"
                //onValueChanged:  data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.fu.ref.topic_name, value)
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
                    color: "gray"
                }
                StatusDot{
                    id: enable_dot
                    info_text: "ENABLE"
                    color: "gray"
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
                title_text: "MTR_CURRENT"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_TEMPERATURE"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "MTR_SPEED"
            }
        }
    }

}
