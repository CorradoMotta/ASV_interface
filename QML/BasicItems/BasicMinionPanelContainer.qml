import QtQuick 2.0

Rectangle{
    id: generic

    property alias title : title_text.text
    property int title_height : title_text.implicitHeight

    border.color: "gray"
    border.width: 2
    radius: 3
    color: "whitesmoke"
    Text {
        id: title_text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "GENERIC"
        font.pixelSize: 20
    }
}
