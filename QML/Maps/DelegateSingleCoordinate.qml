/*************************************************************************
 *
 * Delegate for the single coordinate model-view implemented in the
 * navigation map. This element is used when the operator wants to set a
 * marker on the specific location where the vehicle stands.
 * The color of the marker is purple.
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
    anchorPoint.x: image_marker.width / 2
    anchorPoint.y: image_marker.height
    sourceItem: Image {
        id: image_marker
        source: "../../Images/marker_coor.png"
        sourceSize.width: 40
        sourceSize.height: 40
    }
    MouseArea{
        id: mqi_marker_mouse_area
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        drag.target: mqi_marker
        drag.onActiveChanged:{
            if(drag.active === false){
                // in this way it is only called when the mouse is released
                model.coordinate = mqi_marker.coordinate
            }
        }
        onClicked: if (mouse.button === Qt.RightButton)
                       _coor_model.removeSingleMarker(index)
    }
}
