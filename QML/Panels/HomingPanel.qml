import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

Rectangle {
    id: set_homing
    Layout.preferredHeight: cmd_column_id.implicitHeight + 10 //TODO not having numbers here.
    property alias set_home_is_active : set_home.switch_is_active
    property alias go_home_is_active: go_home.switch_is_active

    radius: 5.0
    border {
        color: "black"
        width: 2
    }
    ColumnLayout{
        id: cmd_column_id
        anchors.fill: parent
        anchors.leftMargin: 10
        //Layout.alignment: Qt.AlignTop | Qt.AlignLeft
        spacing: 3
        BasicSwitch{
            id: set_home
            switch_text: "SET HOME"
            //onSwitch_is_activeChanged: switch_is_active? minion_view.publish_topic(minion_view.azimuth_motor_set_home_tn, 1)
            //                                           : minion_view.publish_topic(minion_view.azimuth_motor_set_home_tn, 0)
        }
        BasicSwitch{
            id: go_home
            switch_text: "GO HOME"
            //onSwitch_is_activeChanged: switch_is_active? minion_view.publish_topic(minion_view.azimuth_motor_go_home_tn, 1)
            //                                           : minion_view.publish_topic(minion_view.azimuth_motor_go_home_tn, 0)
        }
    }
}
