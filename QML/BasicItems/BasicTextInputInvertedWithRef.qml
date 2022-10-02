import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    property alias text_input: basic_input.title_text
    property alias text_value: basic_input.new_text_value
    property alias ref_value: ref_box_value.text

    height: text_input_row.implicitHeight
    width: text_input_row.implicitWidth

    RowLayout{
        id: text_input_row
        BasicTextInputInverted {
            id: basic_input
            titleSize: 10
            value_width: 50
        }
        Rectangle{
            id: ref_box
            Layout.preferredWidth: basic_input.value_width
            Layout.preferredHeight: basic_input.implicitHeight
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 10
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
