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
    GridLayout{
        columns: 2
        rowSpacing: 10
        anchors{
            topMargin: title_height
            fill: parent
            leftMargin: 10
        }

        EngineIcon {
            id: engine_icon_fl
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            //engineIconText: "THRUST"
        }
        RowLayout{
            Layout.alignment: Qt.AlignTop | Qt.AlignRight
            StatusDot{
                id: power_dot
                info_text: "POWER"
            }
            StatusDot{
                id: enable_dot
                info_text: "ENABLE"
            }
            StatusDot{
                id: fault_dot
                info_text: "FAULT"
            }


        }
        BasicSliderVertical {
            id: set_reference
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            //Layout.fillWidth: true
            slider_text: "SETREF"
            mask_input: "#000"
            //onValueChanged:  data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.fu.ref.topic_name, value)
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            opacity: 0
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            opacity: 0
        }
    }
}
