/*************************************************************************
 *
 * This element is a basic switch that contains a text followed by a
 * switch control button. Such button is white when off and gets green when
 * is switched.
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: slider_root
    property alias switch_text: switch_text_id.text

    implicitHeight: rl.implicitHeight + 10
    implicitWidth: rl.implicitWidth  + 10

    RowLayout {
        id: rl
        anchors.fill: parent
        spacing: 20

        Switch {
            id: control
            Layout.alignment: Qt.AlignLeft
            Layout.preferredWidth: background.implicitWidth
            Layout.preferredHeight: background.implicitHeight

            indicator: Rectangle {
                id: background
                implicitWidth: 48
                implicitHeight: 26
                x: control.leftPadding
                y: parent.height / 2 - height / 2
                radius: 13
                color: control.checked ? "#17a81a" : "#ffffff"
                border.color: control.checked ? "#17a81a" : "#cccccc"

                Rectangle {
                    x: control.checked ? parent.width - width : 0
                    width: 26
                    height: 26
                    radius: 13
                    color: control.down ? "#cccccc" : "#ffffff"
                    border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"
                }
            }

            contentItem: Text {
                text: control.text
                font: control.font
                opacity: enabled ? 1.0 : 0.3
                color: control.down ? "#17a81a" : "#21be2b"
                verticalAlignment: Text.AlignVCenter
            }
        }
        Text {
            id: switch_text_id
            font.family: "Helvetica"
            font.pointSize: 14
        }
    }
}
