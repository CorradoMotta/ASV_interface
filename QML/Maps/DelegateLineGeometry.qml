import QtQuick 2.0
import QtPositioning 5.15
import QtLocation 5.15

MapQuickItem {
    id: mqi_line_circle
    //property bool is_enable : false
    anchorPoint.x: image_marker.width * 0.5
    anchorPoint.y: image_marker.height * 0.5
    sourceItem: Image {
        id: image_marker
        //parent.anchorPoint.x: width
        source: "../../Images/circle.png"
        sourceSize.width: 10
        sourceSize.height: 10
    }
    MouseArea{
        id: mqi_line_mouse_area
        anchors.fill: parent
        enabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        drag.target: mqi_line_circle
        onClicked: if (mouse.button === Qt.RightButton){
                       mapPoly.removeCoordinate(index)
                       _line_model.removeCoordinate(index)
                   }
        onPositionChanged: mapPoly.replaceCoordinate(index, mqi_line_circle.coordinate)
    }
}
