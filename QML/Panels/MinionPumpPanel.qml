/*************************************************************************
 *
 * This element contains the Minion pump panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

Rectangle{
    //implicitWidth: text1.implicitWidth
    //Layout.fillHeight: true TODO
    //Layout.fillWidth: true TODO
    border.color: "gray"
    border.width: 3
    Text {
        id: text1
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Pump"
        font.pixelSize: 20
    }
    ColumnLayout{
        spacing: 2
        anchors{
            top: text1.bottom
            right: parent.right; left: parent.left; bottom: parent.bottom
            leftMargin: 10
        }

        EngineIcon {
            id: engine_icon_fl
            engineIconText: "Thrust"
        }
        BasicSlider {
            id: fu
            //Layout.fillWidth: true
            slider_text: "SetReference"
            mask_input: "#000"
            onValueChanged:  data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.fu.ref.topic_name, value)
        }
    }
}
