import QtQuick 2.12
import QtQuick.Controls 2.15
import "../Maps"

Item {
    id: stack_view

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: "../Maps/NavigationMap.qml"
    }
}
