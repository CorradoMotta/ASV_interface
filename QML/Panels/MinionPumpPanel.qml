/*************************************************************************
 *
 * This element contains the Minion pump panel. It is intended to be
 * shown in the SingleMinion view
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15

Rectangle{
    //implicitWidth: text1.implicitWidth
    //Layout.fillHeight: true TODO
    //Layout.fillWidth: true TODO
    border.color: "gray"
    border.width: 3
    Text {id: text1; anchors.horizontalCenter: parent.horizontalCenter; text: "Pump"; font.pixelSize: 20 }
//    RowLayout{
//        anchors.top: text1.bottom
//        anchors.bottom: parent.bottom
//        anchors.left: parent.left
//        anchors.right: parent.right
//        Rectangle{
//            Layout.fillHeight: true
//            Layout.fillWidth: true
//            border.color: "gray"
//            Text {id: text6; anchors.horizontalCenter: parent.horizontalCenter; text: "Cmd"; font.pixelSize: 20 }
//        }
//        Rectangle{
//            Layout.fillHeight: true
//            Layout.fillWidth: true
//            border.color: "gray"
//            Text {id: text7; anchors.horizontalCenter: parent.horizontalCenter; text: "State"; font.pixelSize: 20 }
//        }
//    }
}
