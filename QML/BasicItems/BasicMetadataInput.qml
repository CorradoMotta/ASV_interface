import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.15

Item {
    id: root
    property alias title_text: label.text
    property alias value_text: label_text.text
    property alias title_color: label.color
    property string currentValue: ""
    implicitHeight: rl.implicitHeight
    implicitWidth: rl.implicitWidth

    RowLayout{
        id: rl
        anchors.fill: parent

        Label {
            id: label
            Layout.minimumWidth: 140
        }
        TextField {
            id: label_text
            Layout.fillWidth: true
            onEditingFinished: root.currentValue = label_text.text
        }
    }
}
