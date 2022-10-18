/*************************************************************************
 *
 * Slider that contains two handles in order to set a range. It also has
 * a title which is positioned on top of the slider, and two text values
 * on the corresponding ends, showing the value of the handle.
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: slider_root
    implicitHeight: control.implicitHeight //+ slider_text_id.implicitHeight
    implicitWidth: slider_row_layout.implicitWidth
    //property alias slider_text: slider_text_id.text
    property alias slider_from: control.from
    property alias slider_to: control.to
    //property alias font :  slider_text_id.font.pointSize
    //property bool isBold: false
    //property alias mask_input: slider_value_id.inputMask
    property int max_value: -10
    property int min_value: 0
    property int value: 0

//    Text {
//        id: slider_text_id
//        anchors.left: parent.left
//        anchors.top: parent.top
//        anchors.margins: slider_row_layout.spacing
//        font.family: "Helvetica"
//        font.bold: isBold
//        font.pointSize: 18
//    }
    RowLayout {
        id: slider_row_layout
        anchors.fill: parent
        spacing: 3

        Text {
            id: first_value_id
            property int maxWidth: 35
            Layout.preferredWidth: maxWidth
            //Layout.leftMargin: 10
            Layout.alignment: Qt.AlignLeft
            font.family: "Helvetica"
            font.pixelSize: 22
            text: control.first.onMoved ? control.valueAt(control.first.position) : "0"
        }
        RangeSlider {
            id: control
            property bool __pressed: false
            first.value: 0
            second.value: -10
            stepSize: 1
            from: 0
            to: -50
            snapMode: RangeSlider.SnapOnRelease

            first.onPressedChanged: first.pressed? "" :  min_value = control.first.value
            second.onPressedChanged: second.pressed? "" :  max_value = control.second.value

            background: Rectangle {
                id: rect
                x: control.leftPadding
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: 280
                implicitHeight: 4
                width: control.availableWidth
                height: implicitHeight
                radius: 2
                color: "#bdbebf"

                Rectangle {
                    x: control.first.visualPosition * parent.width
                    width: control.second.visualPosition * parent.width - x
                    height: parent.height
                    color: "#21be2b"
                    radius: 2
                }
            }

            first.handle: Rectangle {
                x: control.leftPadding + control.first.visualPosition * (control.availableWidth - width)
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: 26
                implicitHeight: 26
                radius: 13
                color: control.first.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }


            second.handle: Rectangle {
                x: control.leftPadding + control.second.visualPosition * (control.availableWidth - width)
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: 26
                implicitHeight: 26
                radius: 13
                color: control.second.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }
        }
        Text {
            id: second_value_id
            property int maxWidth: 35
            Layout.preferredWidth: maxWidth
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignRight
            font.family: "Helvetica"
            font.pixelSize: 22
            text: control.second.onMoved ? control.valueAt(control.second.position) : "0"
        }
    }
}
