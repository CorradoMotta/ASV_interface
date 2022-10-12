/*************************************************************************
 *
 * Simple panel to enable and disable the NGC and set a new log.
 *
 * Author: Corrado Motta
 * Date: 10/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

Rectangle{

    radius: 5.0
    border {
        color: "black"
        width: 2
    }
    Layout.preferredHeight: ngc_row.implicitHeight + 10

    // Cpp model
    property var prefix: data_model.data_source.swamp_status.ngc_status
    readonly property string ngcEnableTn: data_model.data_source.swamp_status.ngc_status.ngcEnable.act.topic_name
    readonly property int ngcEnableRef : data_model.data_source.swamp_status.ngc_status.ngcEnable.ref.value
    readonly property string setLogTn: data_model.data_source.swamp_status.ngc_status.setLog.topic_name

    RowLayout{
        id: ngc_row
        anchors.fill: parent
        StatusDot{
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 10
            width: 30
            height: 30
            info_text : "enableRef"
            dot_state: ngcEnableRef
        }
        BasicSwitch{
            switch_text: "NGC_ENABLE"
            onSwitch_is_activeChanged: switch_is_active? publish_topic(ngcEnableTn, 1)
                                                       : publish_topic(ngcEnableTn, 0)
        }
        Rectangle{
            Layout.fillWidth: true
        }
        BasicButton {
            id: control
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 10
            Layout.topMargin: 4
            onClicked: publish_topic(setLogTn, 1)
            text_on_button: "NEW LOG"
            button_width: 100
        }
    }
}
