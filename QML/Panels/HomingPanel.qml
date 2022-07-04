import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

Rectangle {
    id: set_homing
    Layout.preferredHeight: cmd_column_id.implicitHeight
                         //TODO not having numbers here.

    property alias set_home_is_active : set_home.pressed
    property alias go_home_is_active: go_home.pressed
    property alias set_angle_is_active: set_angle.pressed

    radius: 5.0
    border {
        color: "black"
        width: 2
    }
    ColumnLayout{
        id: cmd_column_id
        anchors.fill: parent
        anchors.leftMargin: 10
        spacing: 7

        BasicButton{
            id: go_home
            Layout.topMargin: 7
            text_on_button: "GO HOME"
            button_width: 200
        }
        BasicButton{
            id: set_angle
            text_on_button: "SET ANGLE"
            button_width: 200
        }
        BasicButton{
            id: set_home
            Layout.bottomMargin: 7
            text_on_button: "SET HOME"
            button_width: 200
        }
    }
}
