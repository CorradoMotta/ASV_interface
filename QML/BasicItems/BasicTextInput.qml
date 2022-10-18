import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property alias title_text: title_text_input.text
    property alias mask: text_value_id.inputMask
    property string new_text_value: ""
    property alias value_width : text_input_id.width
    property alias titleSize: title_text_input.font.pixelSize

    implicitHeight: rl.implicitHeight
    implicitWidth: rl.implicitWidth

    RowLayout{
        id: rl
        spacing: 10
        anchors.fill: parent
        FocusScope {
            id: text_input_id
            width: 100; height: text_value_id.implicitHeight + 10
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
                font.pixelSize: 18
                focus: true
                onEditingFinished: text.trim() === ''?  0 : new_text_value =  text
            }
        }

        Text {
            id: title_text_input
            font.family: "Helvetica"
            font.pixelSize: 18
        }
    }
}
