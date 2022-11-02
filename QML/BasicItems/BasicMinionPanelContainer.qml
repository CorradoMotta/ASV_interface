/*************************************************************************
 *
 * Rectangle with text on top (inside), used as a basic container for the
 * panels in each minion view.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle{
    id: generic

    property alias title : title_text.text
    property int title_height : title_text.implicitHeight

    border.color: "gray"
    border.width: 2
    radius: 3
    color: "whitesmoke"

    Text {
        id: title_text

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 6

        text: "GENERIC"
        font.pixelSize: 20
        font.bold: true
    }
}
