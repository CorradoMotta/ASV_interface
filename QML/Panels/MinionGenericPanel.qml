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
    title: "GENERIC"
    //color: "gainsboro"
    RowLayout{
        spacing: 25
        anchors{
            topMargin: 20
            fill: parent
            leftMargin: 10
        }
        BasicRebootIcon {
            id: reboot_icon_fl
            // THIS IS THE LINE NEEDED TO CONNECT ENGINES
            //engineState : engine_panel.engine_state_fl_prova
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.leftMargin: 20
            //image_size: 40
        }
        ColumnLayout{
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
//            BasicTextInput{
//                id: port_addr
//                //Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
//                title_text: "PORT_ADDR"
//            }
        }
        Item{
            Layout.fillWidth: true

        }
    }
}

