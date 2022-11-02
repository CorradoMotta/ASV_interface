/*************************************************************************
 *
 * This element contains a simple dot that can be used to signal a Status
 * such as on, off or fault. It can also show information text when passing
 * over with the cursor. info_text should be set for that purpose.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle{
    id: dot

    enum DotStates {
        Dot_off,
        Dot_fault,
        Dot_on
    }

    property alias info_text : info_label_text.text
    property int dot_state: FaultDot.DotStates.Dot_off
    property color off_color: "gray"
    property bool label_on_side: false

    width: 40
    height: 40
    radius: 30
    color: dot_state === FaultDot.DotStates.Dot_off?
               off_color : dot_state === FaultDot.DotStates.Dot_on?
                   "green": "red"

    Rectangle{
        id: info_label
        z: 1
        anchors.bottom: dot.label_on_side? dot.bottom : dot.top
        anchors.bottomMargin: dot.label_on_side? (info_label_text.height/3) : - (info_label_text.height/3)
        anchors.right: dot.label_on_side? parent.horizontalCenter : parent.right
        width: info_label_text.implicitWidth + 6
        height: info_label_text.implicitHeight + 6
        color: "white"
        border.color: "black"
        visible: false

        Text{
            id: info_label_text
            anchors.horizontalCenter: info_label.horizontalCenter
            anchors.verticalCenter: info_label.verticalCenter
            font.family: "helvetica"
            font.pixelSize: 14
        }
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled : true
        onEntered: {
            info_label.visible = true
        }
        onExited: {
            info_label.visible = false
        }
    }
}
