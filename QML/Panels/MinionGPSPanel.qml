/*************************************************************************
 *
 * This element contains the Minion GPS panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

BasicMinionPanelContainer{
    title: "GPS"
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
                //Layout.topMargin: 30
                value_width: 200
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                title_text: "LATITUDE"
                value_text: minion_view.gps_latitude
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 200
                title_text: "LONGITUDE"
                value_text: minion_view.gps_longitude
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 200
                title_text: "ALTITUDE"
                value_text: minion_view.gps_altitude
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
                title_text: "FIX"
                value_text: minion_view.gps_fix
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                title_text: "NS"
                value_text: minion_view.gps_ns
            }
//            BasicTextOutput{
//                Layout.alignment: Qt.AlignTop | Qt.AlignRight
//                title_text: "HEIGHT"
//            }
        }
    }
}
