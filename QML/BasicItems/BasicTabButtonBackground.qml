import QtQuick 2.0

Rectangle {
    radius: 10
    property alias text_content: tabText.text
    property alias text_color: tabText.color

    Text {
        id: tabText
        anchors.centerIn: parent
        font.family: "Helvetica"
        font.pointSize: 12
    }
}
