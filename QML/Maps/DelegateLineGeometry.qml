/*************************************************************************
 *
 * Delegate for the line model-view implemented in the navigation map.
 * This element is a small dot that is added on each vertex of the
 * polyline. When dragged, the dot position is updated as well as the rest
 * of the line.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

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
        sourceSize.width: 10
        sourceSize.height: 10
        Rectangle{
            // TODO this should be an element
            id: info_label
            z: 3
            anchors.bottom: image_marker.top
            anchors.bottomMargin: - (info_label_text.height/3)
            anchors.horizontalCenter: image_marker.horizontalCenter
            width: info_label_text.implicitWidth + 6
            height: info_label_text.implicitHeight + 6
            color: "white"
            border.color: "black"
            visible: false
            radius: 10

            Text{
                id: info_label_text
                anchors.horizontalCenter: info_label.horizontalCenter
                anchors.verticalCenter: info_label.verticalCenter
                font.family: "helvetica"
                font.pixelSize: 14
                font.bold: true
                text: index + ": " + navigation_map.roundCoor(coordinate.latitude,8) + " " + navigation_map.roundCoor(coordinate.longitude,8)
            }
        }
    }
    MouseArea{
        id: mqi_line_mouse_area
        anchors.fill: parent
        enabled: is_enable
        hoverEnabled : true
        onEntered: {
            info_label.visible = true
        }
        onExited: {
            info_label.visible = false
        }
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        drag.target: mqi_line_circle
        drag.onActiveChanged:{
            // to call only when released
            if(drag.active === false){
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
