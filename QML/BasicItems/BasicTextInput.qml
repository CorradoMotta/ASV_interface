import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property alias title_text: title_text_input.text
    property alias value_text: text_value_id.text

    implicitHeight: text_input_id.height
    implicitWidth: title_text_input.implicitWidth + rl.spacing + text_input_id.width

    RowLayout{
        id: rl
        spacing: 10
        anchors.fill: parent
        FocusScope {
            width: 200; height: 40
            Rectangle {
                id: text_input_id
                anchors.fill: parent
                color: "white"
                border.color: "black"

            }

//            property alias text: input.text
//            property alias input: input

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
