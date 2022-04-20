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
            topMargin: 20
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
            Layout.leftMargin: 5

            Layout.topMargin: title_height + 10
            //image_size: 40
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 10
            BasicTextInput{
                id: tlm_ddr
                //Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                title_text: "TLM_ADDR"
            }
            BasicTextInput{
                id: ip_addr
                //Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                title_text: "IP_ADDR"
            }
            BasicTextInput{
                id: udp_port
                //Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
                title_text: "UDP_PORT"
            }
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 10
            BasicSwitchInverted{
                Layout.alignment: Qt.AlignRight
                switch_text: "ENABLE_DEBUG_LOG"
            }
            BasicSwitchInverted{
                Layout.alignment: Qt.AlignRight
                switch_text: "SET_DIGITAL"
            }
            BasicSwitchInverted{
                Layout.alignment: Qt.AlignRight
                switch_text: "SET_ANALOG"
            }
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
                title_text: "NODE_ID"
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "DATE_TIME"
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "NOP_COUNTER"
            }
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignRight
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 200
                title_text: "DIGITAL_INPUT"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 200
                title_text: "DIGITAL_OUTPUT"
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 200
                title_text: "BATTERY_VOLTAGE"
            }
        }
    }
}

