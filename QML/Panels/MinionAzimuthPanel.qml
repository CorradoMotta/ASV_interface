/*************************************************************************
 *
 * This element contains the Minion azimuth panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15

Rectangle{
    //implicitWidth: text1.implicitWidth
    border.color: "gray"
    border.width: 3
    Text {
        id: text1
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Azimuth"
        font.pixelSize: 20
    }
}
