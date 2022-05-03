/*************************************************************************
 *
 * This element contains the Minion generic panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "../BasicItems"

BasicMinionPanelContainer{
    implicitHeight: Math.max(cmd_row.implicitHeight , cmd_row_2.implicitHeight) + title_height + 20
    implicitWidth: cmd_row.implicitWidth + cmd_row_2.implicitWidth + 20
    title: "GENERIC"
    color: "aliceblue"
    //border.color: "transparent"
    RowLayout{
        id: cmd_row
        spacing: 2
        //width: parent.width/2
        anchors{
            topMargin: 5
            //fill: parent
            top: parent.top; left: parent.left; bottom: parent.bottom; right: bar.right
            rightMargin: 10
            leftMargin: 10
        }
        BasicRebootIcon {
            id: reboot_icon_fl
            // THIS IS THE LINE NEEDED TO CONNECT ENGINES
            //engineState : engine_panel.engine_state_fl_prova
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Layout.leftMargin: 10
            Layout.topMargin: title_height + 30
            // TODO deactivated for now
//            onRebootStateChanged: {
//                    if(rebootState === BasicRebootIcon.RebootStates.Reboot) minion_view.publish_topic(minion_view.reboot_tn, 1)
//                    else if(rebootState === BasicRebootIcon.RebootStates.Shutdown) minion_view.publish_topic(minion_view.shutdown_tn, 1)
//            }
        }
//        ColumnLayout{
//            Layout.alignment: Qt.AlignLeft
//            Layout.leftMargin: 10
////            BasicTextInput{
////                id: tlm_ddr
////                //Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
////                title_text: "TLM_ADDR"
////            }
////            BasicSwitch{
////                //Layout.alignment: Qt.AlignRight
////                switch_text: "ENABLE_DEBUG_LOG"
////            }
//            //            BasicTextInput{
//            //                id: ip_addr
//            //                //Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
//            //                title_text: "IP_ADDR"
//            //            }
//            //            BasicTextInput{
//            //                id: udp_port
//            //                //Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
//            //                title_text: "UDP_PORT"
//            //            }
//        }
        ColumnLayout{
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 10
            BasicSwitchInverted{
                Layout.alignment: Qt.AlignRight
                switch_text: "LOG"
                onSwitch_is_activeChanged: switch_is_active? minion_view.publish_topic(minion_view.log_tn, 1)
                                                           : minion_view.publish_topic(minion_view.log_tn, 0)
            }
            BasicTextInputInverted{
                id: tlm_ddr
                //Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                title_text: "TLM_ADDR"
                // TODO add loss of scope
                onNew_text_valueChanged: minion_view.publish_topic(minion_view.changeTlmAddr_tn, new_text_value)
            }

            //            BasicSwitchInverted{
            //                Layout.alignment: Qt.AlignRight
            //                switch_text: "SET_DIGITAL"
            //            }
            //            BasicSwitchInverted{
            //                Layout.alignment: Qt.AlignRight
            //                switch_text: "SET_ANALOG"
            //            }
        }
    }
    Rectangle {
        id: bar
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: title_height + 20
            bottomMargin: 30
            bottom: parent.bottom
        }
        width: 2
        color: "gray"
    }
    RowLayout{
        id: cmd_row_2
        spacing: 2
        //width: parent.width/2
        anchors{
            topMargin: 20
            leftMargin: 10
            top: parent.top; right: parent.right; bottom: parent.bottom; left: bar.right
            rightMargin: 10
        }

        ColumnLayout{
            Layout.alignment: Qt.AlignLeft
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "NODE_ID"
                value_text: minion_view.nodeID

            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "DATE_TIME"
                value_text: minion_view.date_and_time
            }
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignRight
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "NOP_COUNTER"
                value_text: minion_view.nop_counter
            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 200
            //                title_text: "DIGITAL_INPUT"
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 200
            //                title_text: "DIGITAL_OUTPUT"
            //            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "VOLTAGE"
                value_text: minion_view.battery_voltage
            }
        }
    }
}

