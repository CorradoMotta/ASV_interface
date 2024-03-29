import QtQuick 2.15
import QtQuick.Controls 2.15
/*************************************************************************
 *
 * Text input element with a box where the text can be added and edited
 * and a title on the right side. Every time the editing is finished
 * the "new_text_value" property is updated with the new text value.
 *
 * Author: Corrado Motta
 * Date: 05/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick.Layouts 1.15

Item {
    property alias title_text: title_text_input.text
    property string new_text_value: "0"
    property alias make_bold : title_text_input.font.bold
    property alias value_width : text_input_id.width
    property alias titleSize: title_text_input.font.pixelSize
    property alias text_value: text_value_id.text

    implicitHeight: rl.implicitHeight
    implicitWidth: rl.implicitWidth

    RowLayout{
        id: rl
        spacing: 10
        anchors.fill: parent

        Text {
            id: title_text_input
            font.family: "Helvetica"
            font.pixelSize: 14
        }
        Item {
            id: space
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        FocusScope {
            id: text_input_id
            width: 200;
            height: text_value_id.implicitHeight + 10
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
                font.pixelSize: 17
                focus: true
                text: new_text_value
                onEditingFinished: new_text_value = text
            }
        }
    }
}
