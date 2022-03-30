import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: slider_root
    implicitHeight: control.implicitHeight
    implicitWidth: control.implicitWidth

    property alias slider_text: slider_text_id.text
    property alias slider_from: control.from
    property alias slider_to: control.to
    property int value: 0

    RowLayout {
        anchors.fill: parent
        spacing: 6

        Text {
            id: slider_text_id
            font.family: "Helvetica"
            font.pointSize: 18
        }
        Slider {
            id: control
            property bool __pressed: false
            Layout.alignment: Qt.AlignLeft
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
        RowLayout {
            spacing: 3
            Image {
                Layout.alignment: Qt.AlignLeft
                source: "Images/ArrowUp.png"
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
                Layout.alignment: Qt.AlignLeft
                source: "Images/ArrowDown.png"
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
        }

        Rectangle {
            id: reset_button
            Layout.alignment: Qt.AlignLeft
            Layout.preferredHeight: control.implicitHandleHeight
            Layout.preferredWidth: control.implicitHandleHeight
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

        Text {
            id: slider_value_id
            property int maxWidth: 35
            Layout.preferredWidth: maxWidth
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignRight
            font.family: "Helvetica"
            font.pointSize: 18
            text: control.onMoved ? control.valueAt(control.position) : "0"
        }
    }
}
