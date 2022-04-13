/*************************************************************************
 *
 * This element contains the Minion GPS panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle{
    //implicitWidth: text1.implicitWidth
    border.color: "gray"
    border.width: 3
    Text {
        id: text1
        anchors.horizontalCenter: parent.horizontalCenter
        text: "GPS"
        font.pixelSize: 20
    }
}
