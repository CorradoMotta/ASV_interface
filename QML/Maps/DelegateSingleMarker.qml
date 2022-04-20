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
    }
    MouseArea{
        id: mqi_marker_mouse_area
        anchors.fill: parent
        enabled: is_enable
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        drag.target: mqi_marker
        //        drag.onActiveChanged:{
        //            if(drag.active === false){
        //                // TODO not implemented yet!
        //                //console.log("released!")
        //                // use coordinate member of MapQuickItem element
        //                //console.log("new coordinates: Lon: " + mqi_marker.coordinate.longitude  + " , Lat:" + mqi_marker.coordinate.latitude + " , Index:" +index)
        //                }
        //        }

        onClicked: if (mouse.button === Qt.RightButton)
                       _marker_model.removeCoordinate(index)

    }
}
