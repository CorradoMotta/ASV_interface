/*************************************************************************
 *
 * This element contains the Minion generic panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle{
    id: generic
    border.color: "gray"
    border.width: 3
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Generic"
        font.pixelSize: 20
    }
}
