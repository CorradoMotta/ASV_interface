import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property alias title_text: title_text_input.text
    property alias value_text: text_value_id.text

    implicitHeight: text_input_id.height
    implicitWidth: rl.implicitWidth

    RowLayout{
        id: rl
        spacing: 10
        anchors.fill: parent
        FocusScope {
            id: text_input_id
            width: 200; height: text_value_id.implicitHeight + 10
            Rectangle {
                anchors.fill: parent
                color: "white"
                border.color: "black"

            }

            TextEdit {
                id: text_value_id
                anchors.fill: parent
                anchors.margins: 4
                font.family: "Helvetica"
                font.pointSize: 14
                focus: true
            }
        }

        Text {
            id: title_text_input
            font.family: "Helvetica"
            font.pointSize: 14
        }
    }
}
