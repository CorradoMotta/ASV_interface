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

        source: "../../Images/Swamp.png"
        //transform: Rotation {origin.x: 50; origin.y: 50; angle: vehicle_rotation}
        sourceSize.width: 50
        sourceSize.height: 50
    }

}
