/*************************************************************************
 *
 * Delegate for the single marker model-view implemented in the
 * navigation map. Such marker is displayed when the operator wants to add
 * a point on the map by clicking on it. It is possible to hover on the
 * marker to see the actual coordinates.
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
    id: mqi_marker
    property bool is_enable : false
    anchorPoint.x: image_marker.width / 2
    anchorPoint.y: image_marker.height
    sourceItem: Image {
        id: image_marker
        source: "../../Images/marker.png"
        sourceSize.width: 40
        sourceSize.height: 40

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
                text: navigation_map.roundCoor(coordinate.latitude,8) + " " + navigation_map.roundCoor(coordinate.longitude,8)
            }
        }
    }
    MouseArea{
        id: mqi_marker_mouse_area
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
        drag.target: mqi_marker
        drag.onActiveChanged:{
            if(drag.active === false){
                model.coordinate = mqi_marker.coordinate
            }
        }
        onClicked: if (mouse.button === Qt.RightButton)
                       _marker_model.removeSingleMarker(index)
    }
}
