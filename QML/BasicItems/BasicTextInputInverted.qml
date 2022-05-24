import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property alias title_text: title_text_input.text
    property string new_text_value: ""
    property alias value_width : text_input_id.width
    property alias titleSize: title_text_input.font.pointSize

    implicitHeight: rl.implicitHeight
    implicitWidth: rl.implicitWidth

    RowLayout{
        id: rl
        spacing: 10
        anchors.fill: parent

        Text {
            id: title_text_input
            font.family: "Helvetica"
            font.pointSize: 14
        }
        FocusScope {
            id: text_input_id
            width: 200; height: text_value_id.implicitHeight + 10
            Rectangle {
                anchors.fill: parent
                color: "white"
                border.color: "black"

            }

            TextInput {
                id: text_value_id
                anchors.fill: parent
                anchors.margins: 4
                font.family: "Helvetica"
                font.pointSize: 14
                focus: true
                onEditingFinished: new_text_value = text
            }
        }

    }
}
