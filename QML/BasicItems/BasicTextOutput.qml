import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    property alias title_text: title_text_output.text
    property alias value_text: info_label_text.text
    property alias value_width : info_label.width
    property alias titleSize: info_label_text.font.pixelSize

    implicitHeight: rl.implicitHeight
    implicitWidth: rl.implicitWidth

    RowLayout{
        id: rl
        spacing: 10
        anchors.fill: parent
        Text {
            id: title_text_output
            font.family: "Helvetica"
            font.pixelSize: 18
        }
        Rectangle{
            id: info_label
            width: 100
            height: info_label_text.implicitHeight + 10
            clip: true
            color: "white"
            border.color: "black"
            Text{
                id: info_label_text
                horizontalAlignment : Text.AlignLeft
                //anchors.horizontalCenter: info_label.horizontalCenter
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.verticalCenter: info_label.verticalCenter
                font.family: "Helvetica"
                font.pixelSize: 18
            }
        }
    }
}
