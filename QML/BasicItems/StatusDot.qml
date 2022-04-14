/*************************************************************************
 *
 * This element contains a simple dot that can be used to signal a Status
 * such as on, off or fault. It can also show information text when passing
 * over with the cursor. info_text should be set for that purpose.
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle{
    id: dot

    property alias info_text : info_label_text.text
    enum DotStates {
        Dot_off,
        Dot_on,
        Dot_fault
    }

    width: 30
    height: 30
    radius: 30
    //border.color: "silver"
    color: "gray"

    Rectangle{
        id: info_label
        z: 1
        anchors.bottom: dot.top
        anchors.bottomMargin: - (info_label_text.height/3)
        anchors.horizontalCenter: dot.horizontalCenter
        width: info_label_text.implicitWidth + 6
        height: info_label_text.implicitHeight + 6
        color: "white"
        border.color: "black"
        visible: false

        Text{
            id: info_label_text
            anchors.horizontalCenter: info_label.horizontalCenter
            anchors.verticalCenter: info_label.verticalCenter
            font.pointSize: 10
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
