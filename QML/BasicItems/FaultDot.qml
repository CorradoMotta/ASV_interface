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

    // TODO fix the fault (0 - 1 per fault)
    enum DotStates {
        Dot_fault,
        Dot_off,
        Dot_on
    }
    property alias info_text : info_label_text.text
    property int dot_state: FaultDot.DotStates.Dot_off

    width: 40
    height: 40
    radius: 30
    //border.color: "silver"
    color: dot_state === FaultDot.DotStates.Dot_off?
               "gray" : dot_state === FaultDot.DotStates.Dot_on?
                   "green": "red"

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
            console.log(dot_state)
        }
        onExited: {
            info_label.visible = false
        }

    }
}
