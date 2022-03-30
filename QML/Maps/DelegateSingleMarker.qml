import QtQuick 2.0
import QtPositioning 5.15
import QtLocation 5.15

MapQuickItem {
    id: mqiBox

    anchorPoint.x: image_marker.width / 2
    anchorPoint.y: image_marker.height
    sourceItem: Image {
            id: image_marker
            //parent.anchorPoint.x: width
            source: "../../Images/marker.png"
            sourceSize.width: 40
            sourceSize.height: 40
        }
}
