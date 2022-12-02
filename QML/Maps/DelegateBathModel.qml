/*************************************************************************
 *
 * Delegate for the bathymetry model-view implemented in the navigation map.
 * This element is composed by a dot with a color dynamically updated
 * according to the depth. When hovering on it, the actual depth is
 * shown on a label on top of the dot.
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

        MouseArea{
            anchors.fill: parent
            hoverEnabled : true
            onEntered: {
                navigation_map.updateLabel(depth, true,mqi.x, mqi.y - imgCircle.height)
            }
            onExited: {
                navigation_map.updateLabel(0, false,0,0)
            }
        }
    }
}

