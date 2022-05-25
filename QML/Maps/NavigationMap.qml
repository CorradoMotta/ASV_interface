import QtQuick 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Layouts 1.11
import "../BasicItems"
import "../Panels"

Rectangle{
    id: navigation_map
    property var lat: data_model.data_source.swamp_status.gps_ahrs_status.latitude
    property var lon: data_model.data_source.swamp_status.gps_ahrs_status.longitude
    property real altitude: data_model.data_source.swamp_status.ngc_status.altitude.value
    property real latValue : lat.value
    property real lonValue: lon.value
    property real v_rotation : data_model.data_source.swamp_status.ngc_status.psi.value //convertToRadiant
    property bool is_centered: true
    property var initialCoordinates: QtPositioning.coordinate(lat.value, lon.value)
    //property double initialValue : 7.13
    property real rando : 0
    property int bath_counter: 0
    property int max_bathymetry_depth : bathymetry_panel.max_depth
    property int min_bathymetry_depth : bathymetry_panel.min_depth
    readonly property real hueMin : 0.513
    readonly property real hueMax : 0.652
    property alias mapTypes: swamp_map.supportedMapTypes
    property alias mapName: swamp_map.plugin.name

    onLatValueChanged: lon.value !==0 ? root.startUp = false: ""
    onLonValueChanged: lat.value !==0 ? root.startUp = false: ""
    onMax_bathymetry_depthChanged: bathView.model.newDepthRange(max_bathymetry_depth, min_bathymetry_depth)
    onMin_bathymetry_depthChanged: bathView.model.newDepthRange(max_bathymetry_depth, min_bathymetry_depth)

    Rectangle{
        id: status_bar
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: 34
        color: "aliceblue"
        property int dotSize: 25

        RowLayout{

            spacing: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10

            MinionStateRow{
                id: minion_fl
                dotSize: status_bar.dotSize
                prefix: data_model.data_source.swamp_status.minion_fl
                info_prefix: "FL"

            }
            MinionStateRow{
                id: minion_fr
                dotSize: status_bar.dotSize
                prefix: data_model.data_source.swamp_status.minion_fr
                info_prefix: "FR"
            }
            MinionStateRow{
                id: minion_rl
                dotSize: status_bar.dotSize
                prefix: data_model.data_source.swamp_status.minion_rl
                info_prefix: "RL"

            }
            MinionStateRow{
                id: minion_rr
                dotSize: status_bar.dotSize
                prefix: data_model.data_source.swamp_status.minion_rr
                info_prefix: "RR"
            }
        }
    }

    Map {
        id: swamp_map
        anchors{
            topMargin: 8
            top: status_bar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        plugin: MapBoxPlugin {}

        gesture.enabled: true
        gesture.acceptedGestures: MapGestureArea.PanGesture | MapGestureArea.PinchGesture
        gesture.onPanFinished: {
            if(!visibleRegion.contains(QtPositioning.coordinate(navigation_map.lat.value, navigation_map.lon.value)) && !root.startUp)
                navigation_map.is_centered = false
            else if(navigation_map.is_centered)
                navigation_map.is_centered = true
        }

        activeMapType: supportedMapTypes[0]
        copyrightsVisible: false

        MouseArea {
            id: navigation_mouse_area
            anchors.fill: parent
            onClicked: {
                // TODO. I should use coordinate member of QuickMapItem element. It looks more accurate.
                var crd = swamp_map.toCoordinate(Qt.point(mouseX, mouseY))
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
            z: 1
            rotation: navigation_map.v_rotation
            coordinate:  QtPositioning.coordinate(navigation_map.lat.value, navigation_map.lon.value)
            onCoordinateChanged:
            {
                if(!root.startUp &( Math.abs(old_lat - navigation_map.roundCoor(lat.value,5)) > 0
                                   | Math.abs(old_lon - navigation_map.roundCoor(lon.value,5)) > 0))
                {
                    if(bathymetry_panel.isPLaying){
                        bathView.model.addDepthPoint(navigation_map.latValue,
                                                     lon.value,
                                                     lat.timeStamp,
                                                     navigation_map.altitude, // positive value expected
                                                     navigation_map.max_bathymetry_depth,
                                                     navigation_map.min_bathymetry_depth
                                                     )

                        navigation_map.bath_counter += 5
                        var x = navigation_map.bath_counter
                        var y = - navigation_map.altitude
                        minion_view.bathymetryPoint = Qt.point(x,y)//navigation_map.initialValue
                        old_lat = navigation_map.roundCoor(lat.value,5)
                        old_lon = navigation_map.roundCoor(lon.value,5)
                    }
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
        MapItemView {
            id: bathView
            // create a listModel to provide data used for creating the map items defined by the delegate.
            model: _bathymetry_model
            delegate: DelegateBathModel{
                id: my_bath_delegate
                coordinate: QtPositioning.coordinate(model.coordinate.latitude,
                                                     model.coordinate.longitude)
            }
        }

        Rectangle{
            id: info_label
            property alias depth_value : info_label_text.text
            width: info_label_text.implicitWidth + 6
            height: info_label_text.implicitHeight + 6
            color: "white"
            border.color: "black"
            visible: false

            Text{
                id: info_label_text
                anchors.horizontalCenter: info_label.horizontalCenter
                anchors.verticalCenter: info_label.verticalCenter
                font.pointSize: 10
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


    }
    function setActiveMap(index) {
        swamp_map.activeMapType = swamp_map.supportedMapTypes[index]
    }

    function roundCoor(coor, dec){
        return Math.round(coor * Math.pow(10, dec))/ Math.pow(10, dec)
    }

    // TODO CHECK IF THIS STILL WORK
    function updateLabel(depth, visibility, xVal, yVal){
        info_label.depth_value = depth
        info_label.visible = visibility
        info_label.x = xVal
        info_label.y = yVal
    }

    function set_center(centerCor){
        swamp_map.center = centerCor
    }
}
