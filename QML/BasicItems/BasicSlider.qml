/*************************************************************************
 *
 * Slider that contains one handle in order to set a value. It also has
 * a title which is positioned on the left of the slider, a reset button
 * to move the slider to 0, two arrows to increase and decrease the slider
 * value, and an editable textInput box to show and modify the slider value.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: slider_root
    implicitHeight: slider_row.implicitHeight
    implicitWidth: slider_row.implicitWidth

    property alias slider_text: slider_text_id.text
    property alias slider_from: control.from
    property alias slider_to: control.to
    property alias mask_input: slider_value_id.inputMask
    property int value: 0

    RowLayout {
        id: slider_row
        anchors.fill: parent
        spacing: 3

        Text {
            id: slider_text_id
            Layout.alignment: Qt.AlignLeft
            font.family: "Helvetica"
            font.pixelSize: 18
        }
        Slider {
            id: control
            property bool __pressed: false
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: rect.implicitWidth
            stepSize: 1
            from: -99
            value: 0
            to: 99

            background: Rectangle {
                id: rect
                x: control.leftPadding
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: 200
                implicitHeight: 4
                width: control.availableWidth
                height: implicitHeight
                radius: 2
                color: "#bdbebf"

                Rectangle {
                    width: control.visualPosition * parent.width
                    height: parent.height
                    color: (control.valueAt(control.position)
                            < 0) ? "red" : (control.valueAt(
                                                control.position) > 0) ? "#21be2b" : "grey"
                    radius: 2
                }
            }

            handle: Rectangle {
                x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
                y: control.topPadding + control.availableHeight / 2 - height / 2
                implicitWidth: 26
                implicitHeight: 26
                radius: 13
                color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                border.color: "#bdbebf"
            }
            snapMode: Slider.SnapOnRelease
            onPressedChanged: pressed ? "" : slider_root.value = control.value
        }
        FocusScope {
            id: text_input_id
            property int maxWidth: 48

            Layout.preferredWidth: maxWidth
            Layout.preferredHeight: slider_value_id.implicitHeight + 6
            Layout.alignment: Qt.AlignLeft

            Rectangle{
                id: slider_text_input
                anchors.fill: parent
                border.color: "gray"
                border.width: 2
                radius: 3
                TextInput {
                    id: slider_value_id
                    anchors.fill: parent
                    anchors.margins: 4
                    font.family: "Helvetica"
                    font.pixelSize: 20
                    focus: true
                    text: control.onMoved ? control.valueAt(control.position) : 0
                    onEditingFinished: {
                        control.value = text * 1
                        slider_root.value = control.value
                    }
                }
            }
        }
        Image {
            Layout.alignment: Qt.AlignRight
            source: "../../Images/ArrowUp.png"
            sourceSize.height: 25
            sourceSize.width: 25
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    control.increase()
                    slider_root.value = control.value
                }
            }
        }

        Image {
            Layout.alignment: Qt.AlignRight
            source: "../../Images/ArrowDown.png"
            sourceSize.height: 25
            sourceSize.width: 25
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    control.decrease()
                    slider_root.value = control.value
                }
            }
        }

        Rectangle {
            id: reset_button
            Layout.alignment: Qt.AlignRight
            Layout.preferredHeight: control.implicitHandleHeight
            Layout.preferredWidth: control.implicitHandleHeight
            Layout.rightMargin: 10
            radius: 15
            color: "#f08080"
            Rectangle {
                id: reset
                anchors.centerIn: reset_button
                width: control.implicitHandleHeight / 2.5
                height: control.implicitHandleHeight / 2.5
                radius: 15
                color: "#2f4f4f"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    control.value = 0
                    slider_root.value = control.value
                }
            }
        }
    }
}
