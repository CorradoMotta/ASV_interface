/*************************************************************************
 *
 * Simple button with text and color change when pressed.
 *
 * Author: Corrado Motta
 * Date: 06/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

Button {
    id: control

    width: button_width
    implicitWidth: button_width

    property alias text_on_button: button_text.text
    property bool button_enabled : true
    property alias button_width: button_background.width

    contentItem: Text {
        id: button_text
        anchors.centerIn: parent
        font.family: "Helvetica"
        font.pixelSize: 18
    }

    background: Rectangle{
        id: button_background
        height: button_text.implicitHeight + 10
        implicitWidth: button_width
        color: control.button_enabled? control.down? "peachpuff" : "papayawhip" : "papayawhip"
        border.width: 1
        border.color: "black"
        radius: 6
        enabled: button_enabled
    }
}
