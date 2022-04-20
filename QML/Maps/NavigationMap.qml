import QtQuick 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Layouts 1.11
import "../BasicItems"
import "../Panels"

Map {
    id: navigation_map
    property real lat: data_model.data_source.swamp_status.gps_ahrs_status.latitude.value
    property real lon: data_model.data_source.swamp_status.gps_ahrs_status.longitude.value
    property real v_rotation : root.convertToRadiant(data_model.data_source.swamp_status.ngc_status.psi.value)
    property bool is_centered: true
    property var initialCoordinates: QtPositioning.coordinate(lat, lon)
    property double initialValue : 0.513
    onLatChanged: lon !=0 ? root.startUp = false: ""
    onLonChanged: lat !=0 ? root.startUp = false: ""

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
                //console.log("new coordinates: Lon: " + crd.longitude  + " , Lat:" + crd.latitude)
            }
        }
    }

    VehicleMapItem {
        id: swamp_icon
        z :1
        rotation: v_rotation
        coordinate:  QtPositioning.coordinate(lat, lon)
        onCoordinateChanged:
        {
            if(!root.startUp &( Math.abs(old_lat - roundCoor(swamp_icon.coordinate.latitude,5)) > 0
                               | Math.abs(old_lon - roundCoor(swamp_icon.coordinate.longitude,5))>0))
            {
                //var crd = navigation_map.toCoordinate(Qt.point(mouseX, mouseY))
                //mivMarker.model.insertCoordinate(swamp_icon.coordinate)
                console.log(navigation_map.initialValue)

                navigation_map.initialValue = roundCoor(navigation_map.initialValue + 0.005, 3)
                markerModel.append({
                                       "latitude": swamp_icon.coordinate.latitude,
                                       "longitude": swamp_icon.coordinate.longitude,
                                       "colorHue": navigation_map.initialValue
                                   })
                //my_bath_delegate.colore = Qt.hsla(navigation_map.initialValue, 1, 0.5, 1)
                //bath_poly.addCoordinate(swamp_icon.coordinate)
                //bath_poly.line.color = Qt.hsla(navigation_map.initialValue, 1, 0.5, 1)
                old_lat = roundCoor(swamp_icon.coordinate.latitude,5)
                old_lon = roundCoor(swamp_icon.coordinate.longitude,5)
            }
        }
    }

    // model for single markers
    MapItemView {
        id: mivMarker
        model: _marker_model // defined in c++
        delegate: DelegateSingleMarker {
            id: my_marker_delegate
            z : 2
            coordinate: QtPositioning.coordinate(model.coordinate.latitude,
                                                 model.coordinate.longitude)
            is_enable: draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker? true : false
        }
    }

    // --------------------------------------------------------
    // ADDED FOR BATHIMETRY
    // --------------------------------------------------------
    MapPolyline {
        id: bath_poly
        line.width: 5
        line.color:  Qt.hsla(0.513, 1, 0.5, 1)
    }

    ListModel {
        id: markerModel
    }

    MapItemView {
        id: bathMarker
        // create a listModel to provide data used for creating the map items defined by the delegate.
        model: markerModel
        delegate: DelegateBathModel{
            id: my_bath_delegate
            coordinate: QtPositioning.coordinate(latitude, longitude)
        }
    }
    // --------------------------------------------------------
    // END
    // --------------------------------------------------------

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

    function roundCoor(coor, dec){
        return Math.round(coor * Math.pow(10, dec))/ Math.pow(10, dec)
    }
}
