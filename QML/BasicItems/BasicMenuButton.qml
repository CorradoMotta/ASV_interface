/*************************************************************************
 *
 * Similar to BasicButton but customized for being used in the context of
 * Menu content.
 *
 * Author: Corrado Motta
 * Date: 10/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.15

Button {
    id: control_line

    property alias row_title : row_text.text

    contentItem: Text {
        id: row_text
        font.family: "Helvetica"
        font.pixelSize: 13
        anchors.horizontalCenter: background_line.horizontalCenter
    }

    background: Rectangle{
        id: background_line
        height: row_text.implicitHeight + 10
        width: row_text.implicitWidth + 10
        color: control_line.down? "peachpuff" : "papayawhip"
        border.width: 1
        border.color: "black"
        radius: 3
    }
}
