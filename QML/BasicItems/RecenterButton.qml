import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.6
import QtGraphicalEffects 1.15

Item{
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 20
    anchors.horizontalCenter: parent.horizontalCenter
    implicitHeight: recenter_text.height + 25
    implicitWidth: recenter_text.width + 30

    Rectangle{
        id: recenter_button
        anchors.fill: parent

        radius: 30
        color: "white"
        border.color : "snow"
        visible: navigation_map.is_centered? false : true
        Text {
            id: recenter_text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.family: "arial"
            font.bold: true
            font.pointSize: 14
            color: "dodgerblue"
            text: "Recenter"
        }
        MouseArea{
            id: recenter_area
            anchors.fill: parent
            onClicked: {
                navigation_map.center = QtPositioning.coordinate(navigation_map.lat.value, navigation_map.lon.value)
                navigation_map.is_centered = true
            }
        }
    }

    DropShadow {
        anchors.fill: recenter_button
        horizontalOffset: 1
        verticalOffset: 1
        radius: 1
        samples: 2
        color: "grey"
        visible: recenter_button.visible
        source: recenter_button
    }
}
