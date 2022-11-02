/*************************************************************************
 *
 * Simple tab element to control text and color of tabs.
 *
 * Author: Corrado Motta
 * Date: 05/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle {
    radius: 10

    property alias text_content: tabText.text
    property alias text_color: tabText.color

    Text {
        id: tabText
        anchors.centerIn: parent
        font.family: "Helvetica"
        font.pointSize: 12
    }
}
