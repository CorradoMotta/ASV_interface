import QtQuick 2.0
import QtQuick.Controls 2.15

Button {
    id: control_line
    property alias row_title : row_text.text

    contentItem: Text {
        id: row_text
        font.family: "Helvetica"
        font.pointSize: 10
        anchors.horizontalCenter: background_line.horizontalCenter
    }

    background: Rectangle{
        id: background_line
        height: row_text.implicitHeight + 10
        width: row_text.implicitWidth + 10
        color: control_line.down? "peachpuff" : "papayawhip"
        border.width: 1
        border.color: "black"
        radius: 3
    }
}
