import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
Button {
    id: control_button
    Layout.alignment: Qt.AlignLeft
    Layout.rightMargin: 10
    Layout.topMargin: 4
    width: 300
    //onClicked: console.log(testo.implicitWidth)//publish_topic(setLogTn, 1)
    contentItem: Text {
        id: testo
        font.family: "Helvetica"
        font.pointSize: 14
        anchors.horizontalCenter: background_b.horizontalCenter
        //verticalAlignment: background_b.AlignVCenter
    }
    background: Rectangle{
        id: background_b
        height: testo.implicitHeight + 10
        width: 84 // TODO should bne automatic
        color: button_enabled? control_button.down? "peachpuff" : "papayawhip" : "papayawhip"
        border.width: 1
        border.color: "black"
        enabled: button_enabled
        radius: 6
    }
}
