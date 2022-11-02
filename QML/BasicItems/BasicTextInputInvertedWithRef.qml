/*************************************************************************
 *
 * Text input element with a box where the text can be added and edited
 * and a title on the left side. Another box, on the right, is used to
 * display the reference value which is sent back from the vehicle. This
 * helps to understand if the new value was correctly received by
 * the vehicle. Every time the editing is finished
 * the "new_text_value" property is updated with the new text value.
 *
 * Author: Corrado Motta
 * Date: 05/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property alias text_input: basic_input.title_text
    property alias text_value: basic_input.new_text_value
    property alias ref_value: ref_box_value.text

    implicitHeight: text_input_row.implicitHeight
    implicitWidth: text_input_row.implicitWidth

    RowLayout{
        id: text_input_row
        anchors.fill: parent

        BasicTextInputInverted {
            id: basic_input
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignLeft
            titleSize: 13
            value_width: 42
        }
        Rectangle{
            id: ref_box
            Layout.preferredWidth: basic_input.value_width
            Layout.preferredHeight: basic_input.implicitHeight
            Layout.alignment: Qt.AlignLeft
            clip: true
            color: "whitesmoke"
            border.color: "black"

            Text{
                id: ref_box_value
                anchors.fill: parent
                anchors.margins: 4
                font.family: "Helvetica"
                font.pixelSize: 17
            }
        }
    }
}
