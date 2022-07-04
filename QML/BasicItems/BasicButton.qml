import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

Button {
    id: control

    property alias text_on_button: button_text.text
    property bool button_enabled : true
    property alias button_width: button_background.width

    width: button_width

    contentItem: Text {
        id: button_text
        font.family: "Helvetica"
        font.pointSize: 14
        anchors.horizontalCenter: button_background.horizontalCenter
    }
    background: Rectangle{
        id: button_background
        height: button_text.implicitHeight + 10
        color: button_enabled? control.down? "peachpuff" : "papayawhip" : "papayawhip"
        border.width: 1
        border.color: "black"
        radius: 6
        enabled: button_enabled
    }
}
