/*************************************************************************
 *
 * Slider that contains one handle in order to set a value. It also has
 * a title which is positioned on the left of the slider, a reset button
 * to move the slider to 0  and an editable textInput box to show and modify
 * the slider value. This version also has a textOutput box to show the ref
 * value that comes back from the vehicle.
 *
 *************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: slider_root
    implicitHeight: slider_row.implicitHeight
    implicitWidth: slider_row.implicitWidth

    property alias slider_text: control_button.text_on_button
    property alias slider_from: control.from
    property alias slider_to: control.to
    property alias mask_input: slider_value_id.inputMask
    property alias ref_value: slider_out_value_id.text
    property double value: 0.0
    property alias step_size: control.stepSize
    property alias clicked : control_button.down
    property bool button_enabled : true
    property alias slider_width: rect.implicitWidth
    property alias button_width : control_button.button_width

    RowLayout {
        id: slider_row
        anchors.fill: parent
        spacing: 3

        BasicButton{
            id: control_button
            Layout.alignment: Qt.AlignLeft
            Layout.rightMargin: 10
            Layout.topMargin: 4
            button_width: 100
            button_enabled : slider_root.button_enabled
        }

        Slider {
            id: control
            property bool __pressed: false
            Layout.alignment: Qt.AlignRight
            Layout.preferredWidth: rect.implicitWidth
            width: rect.implicitWidth
            stepSize: 0.1
            from: -99
            value: 0
            to: 99

            background: Rectangle {
                id: rect
                x: control.leftPadding
                y: control.topPadding + control.availableHeight / 2 - height / 2
                //implicitWidth: 260
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
            onPressedChanged: pressed ? "" : slider_root.value =  Math.round(control.value * 100) / 100
        }
        FocusScope {
            id: text_input_id
            property int maxWidth: 50
            Layout.preferredWidth: maxWidth
            implicitWidth: text_input_id.maxWidth
            Layout.preferredHeight: slider_value_id.implicitHeight + 6
            Layout.alignment: Qt.AlignRight
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
                    text: control.onMoved ? Math.round(control.valueAt(control.position) * 100) / 100  : 0
                    onEditingFinished: {
                        control.value = text * 1
                        slider_root.value = control.value
                    }
                }
            }
        }

        Rectangle {
            id: reset_button
            Layout.alignment: Qt.AlignRight
            Layout.preferredHeight: control.implicitHandleHeight
            Layout.preferredWidth: control.implicitHandleHeight
            //Layout.rightMargin: 10
            implicitWidth: reset.width
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
                // TODO send 0 signal
                anchors.fill: parent
                onClicked: {
                    control.value = 0
                    slider_root.value = control.value
                }
            }
        }
        Rectangle{
            id: slider_text_output
            Layout.preferredWidth: text_input_id.maxWidth
            Layout.preferredHeight: slider_out_value_id.implicitHeight + 6
            implicitWidth: text_input_id.maxWidth
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 10
            clip: true
            color: "whitesmoke"
            border.color: "black"
            border.width: 2
            radius: 3
            Text{
                id: slider_out_value_id
                anchors.fill: parent
                anchors.margins: 4
                font.family: "Helvetica"
                font.pixelSize: 20
            }
        }

    }
}
