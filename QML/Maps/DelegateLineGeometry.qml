import QtQuick 2.0
import QtPositioning 5.15
import QtLocation 5.15

MapQuickItem {
    id: mqi_line_circle
    property bool is_enable : false
    anchorPoint.x: image_marker.width * 0.5
    anchorPoint.y: image_marker.height * 0.5
    sourceItem: Image {
        id: image_marker
        source: "../../Images/circle_dot.png"
        sourceSize.width: 8
        sourceSize.height: 8
    }
    MouseArea{
        id: mqi_line_mouse_area
        anchors.fill: parent
        enabled: is_enable
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        drag.target: mqi_line_circle
        drag.onActiveChanged:{
            if(drag.active === false){
                // in this way it is only called when the mouse is released
                model.coordinate = mqi_line_circle.coordinate
            }
        }
        onClicked: if (mouse.button === Qt.RightButton){
                       mapPoly.removeCoordinate(index)
                       _line_model.removeSingleMarker(index)
                   }
        onPositionChanged: mapPoly.replaceCoordinate(index, mqi_line_circle.coordinate)
    }
}
