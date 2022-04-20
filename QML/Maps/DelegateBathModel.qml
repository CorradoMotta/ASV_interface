import QtQuick 2.0
import QtPositioning 5.15
import QtLocation 5.15

MapQuickItem {
    id: mqi
    //property int colorHue : 0.513
    z:2
    anchorPoint.x: imgCircle.width
    anchorPoint.y: imgCircle.height
    sourceItem: Rectangle {
        id: imgCircle
        height: 15
        width: 15
        radius: 10
        color: Qt.hsla(colorHue, 1, 0.5, 1)
    }
}
