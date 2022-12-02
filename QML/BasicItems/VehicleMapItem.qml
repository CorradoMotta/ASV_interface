/*************************************************************************
 *
 * Swamp icon that is displayed on the map.
 *
 * Author: Corrado Motta
 * Date: 06/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtPositioning 5.5
import QtLocation 5.6

MapQuickItem {
    id: swampBox

    property double old_lat : 0
    property double old_lon : 0
    anchorPoint.x: image_swamp.width/2
    anchorPoint.y: image_swamp.height/2

    sourceItem: Image {
        id: image_swamp
        visible: true
        source: "../../Images/swamp_arw.png"
        sourceSize.width: 50
        sourceSize.height: 50
    }
    MouseArea{
        id: mqi_marker_mouse_area
        anchors.fill: parent
        hoverEnabled : true
        onEntered: {
            info_label.visible = true
        }
        onExited: {
            info_label.visible = false
        }
    }
}
