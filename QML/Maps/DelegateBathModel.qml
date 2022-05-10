import QtQuick 2.0
import QtPositioning 5.15
import QtLocation 5.15

MapQuickItem {
    id: mqi
    z: 1
    anchorPoint.x: imgCircle.width
    anchorPoint.y: imgCircle.height
    sourceItem: Rectangle {
        id: imgCircle
        height: 15
        width: 15
        radius: 10
        color: Qt.hsla(colorHue, 1, 0.5, 1)

        Rectangle{
            id: info_label
            z: 3
            anchors.bottom: imgCircle.top
            anchors.bottomMargin: - (info_label_text.height/3)
            anchors.horizontalCenter: imgCircle.horizontalCenter
            width: info_label_text.implicitWidth + 6
            height: info_label_text.implicitHeight + 6
            color: "white"
            border.color: "black"
            visible: false

            Text{
                id: info_label_text
                anchors.horizontalCenter: info_label.horizontalCenter
                anchors.verticalCenter: info_label.verticalCenter
                font.pointSize: 10
                text: depth
            }
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled : true
            onEntered: {
                //info_label.visible = true
                navigation_map.updateLabel(depth, true,mqi.x, mqi.y - imgCircle.height)
            }
            onExited: {
                navigation_map.updateLabel(0, false,0,0)
            }
        }
    }
}

