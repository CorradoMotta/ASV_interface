import QtQuick 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Layouts 1.11
import "../BasicItems"
import "../Panels"

Item{
    id: navigation_map
    property real lat: data_model.data_source.swamp_status.gps_ahrs_status.latitude.value
    property real lon: data_model.data_source.swamp_status.gps_ahrs_status.longitude.value
    property real v_rotation : root.convertToRadiant(data_model.data_source.swamp_status.ngc_status.psi.value)
    property bool is_centered: true
    property var initialCoordinates: QtPositioning.coordinate(lat, lon)
    onLatChanged: lon !=0 ? root.startUp = false: ""
    onLonChanged: lat !=0 ? root.startUp = false: ""

    Map {
        anchors.fill: parent
        anchors.rightMargin: 30
        plugin: MapBoxPlugin {}


        gesture.enabled: true
        gesture.acceptedGestures: MapGestureArea.PanGesture | MapGestureArea.PinchGesture

        gesture.onPanFinished: {
            if(!visibleRegion.contains(QtPositioning.coordinate(lat, lon)) && !root.startUp)
                navigation_map.is_centered = false
            else if(navigation_map.is_centered)
                navigation_map.is_centered = true
        }

        activeMapType: supportedMapTypes[0]
        copyrightsVisible: false

        function setActiveMap(index) {
            activeMapType = supportedMapTypes[index]
        }

        MouseArea {
            id: navigation_mouse_area
            anchors.fill: parent
            onClicked: {
                // TODO. I should use coordinate member of QuickMapItem element. It looks more accurate.
                var crd = navigation_map.toCoordinate(Qt.point(mouseX, mouseY))
                if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker)
                    mivMarker.model.insertCoordinate(crd)
                else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Rectangle)
                    console.log("Not implemented yet!")
                else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line){
                    mivLine.model.insertCoordinate(crd)
                    mapPoly.addCoordinate(crd)
                    console.log("new coordinates: Lon: " + crd.longitude  + " , Lat:" + crd.latitude)
                }
            }
        }

        VehicleMapItem {
            id: swamp_icon
            rotation: v_rotation
            coordinate:  QtPositioning.coordinate(lat, lon)
        }

        // model for single markers
        MapItemView {
            id: mivMarker
            model: _marker_model // defined in c++
            delegate: DelegateSingleMarker {
                id: my_marker_delegate
                coordinate: QtPositioning.coordinate(model.coordinate.latitude,
                                                     model.coordinate.longitude)
                is_enable: draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker? true : false
            }
        }

        // model for lines
        MapPolyline {
            id: mapPoly
            line.width: 2.5
            line.color: 'red'
            MouseArea{
                drag.target: mapPoly
            }
        }

        MapItemView {
            id: mivLine
            model: _line_model // defined in c++
            delegate: DelegateLineGeometry {
                id: my_line_delegate
                coordinate: QtPositioning.coordinate(model.coordinate.latitude,
                                                     model.coordinate.longitude)
                is_enable: draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line? true : false
            }
        }

        RecenterButton{
            id: recenter
        }

        BoxDrawPanel{
            id: draw_panel
        }
    }
    Rectangle{
        id: buttonRect
        color: "#100000FF"
        //opacity: 0.2
        anchors{
            top: parent.top
            right: parent.right
            bottom: parent.bottom
        }


        implicitWidth: 20
        Image {
            id: image_swamp
            //anchors.horizontalCenter: buttonRect.horizontalCenter
            anchors.centerIn: buttonRect
            opacity: 0.7
            visible: true
            source: "../../Images/arrow_open.png"
            scale: 0.05
            //sourceSize.width: 40
            //sourceSize.height: 40
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("I am here")
                    stack.push("../Views/Minions.qml")
                    //stack.push("MinionView.qml")
                    //stack.push("MinionViewWithMap.qml")
                }
            }
        }
    }
}
