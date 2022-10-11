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
            titleSize: 10
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
                font.pointSize: 16
            }
        }
    }
}
