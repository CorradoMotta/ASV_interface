/*************************************************************************
 *
 * Main map element. It contains the map and everything that is included
 * within the map. It also contains three model-view-delegate patterns.
 * One for markers, one for lines and one for the bathymetry model.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

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
    property real homeLatRef: data_model.data_source.swamp_status.ngc_status.latHomeRef.value
    property real homeLonRef: data_model.data_source.swamp_status.ngc_status.lonHomeRef.value
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
    property alias zoomLevel: swamp_map.zoomLevel
    //property int resetValue: false

    onLatValueChanged: lon.value !==0 ? root.startUp = false: ""
    onLonValueChanged: lat.value !==0 ? root.startUp = false: ""
    onMax_bathymetry_depthChanged: bathView.model.newDepthRange(max_bathymetry_depth, min_bathymetry_depth)
    onMin_bathymetry_depthChanged: bathView.model.newDepthRange(max_bathymetry_depth, min_bathymetry_depth)

    onHomeLatRefChanged: homeLonRef != 0 ? root.messagePrompt("Robot's home set in (" + homeLatRef + " " + homeLonRef +")") : ""
    onHomeLonRefChanged: homeLatRef != 0 ? root.messagePrompt("Robot's home set in (" + homeLatRef + " " + homeLonRef +")") : ""

    readonly property string set_lat_lon_tn: data_model.data_source.swamp_status.ngc_status.setLatLon.topic_name //TODO FIX
    readonly property string set_line_lat_lon: data_model.data_source.swamp_status.ngc_status.setLineLatLon.topic_name //TODO FIX
    readonly property string set_robot_home_tn: data_model.data_source.swamp_status.ngc_status.setRobotHome.topic_name //TODO FIX
    readonly property var publish_topic: data_model.data_source.publishMessage //todo repetition

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

            spacing: 80
            anchors.centerIn: parent

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
                    mivMarker.model.insertSingleMarker(crd)
                else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Rectangle)
                    console.log("Not implemented yet!")
                else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line){
                    mivLine.model.insertSingleMarker(crd)
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

        // SHOWS ROBOT'S HOME
        MapQuickItem {
            id: marker
            coordinate: QtPositioning.coordinate(navigation_map.homeLatRef, navigation_map.homeLonRef)
            anchorPoint.x: image.width/4
            anchorPoint.y: image.height

            sourceItem: Image {
                id: image
                source: "../../Images/Swamp_home.png"
                sourceSize.width: 50
                sourceSize.height: 50
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
        // TODO move it into element
        Rectangle{
            id: set_robot_home
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 68

            //            Rectangle{
            //                id: info_label_set_home
            //                z: 5
            //                anchors.bottom: set_robot_home.top
            //                anchors.bottomMargin:-(info_label_text_set_home.height/3)
            //                anchors.left: set_robot_home.left
            //                width: info_label_text_set_home.implicitWidth + 6
            //                height: info_label_text_set_home.implicitHeight + 6
            //                color: "white"
            //                border.color: "black"
            //                visible: mouseArea_rect.containsMouse ? true : false

            //                Text{
            //                    id: info_label_text_set_home
            //                    text: "set robot home"
            //                    anchors.horizontalCenter: info_label_set_home.horizontalCenter
            //                    anchors.verticalCenter: info_label_set_home.verticalCenter
            //                    font.pointSize: 10
            //                }
            //            }


            Image {
                id: set_robot_home_image
                enabled: data_model.data_source.is_connected
                opacity: data_model.data_source.is_connected? 1: 0.3
                visible: true
                sourceSize.width: 50
                sourceSize.height: 50
                //opacity: boxRectangle.isActive?  1 : 0.65
                source: "../../Images/home-button.png"
                scale: mouseArea_rect.containsMouse ? 1.0 : 0.8

                MouseArea {
                    id: mouseArea_rect
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: publish_topic(set_robot_home_tn, 1)
                }
            }
        }

        // TODO move it into element
        Rectangle{
            id: set_controller_presence
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 20
            anchors.topMargin: 20

            Image {
                id: set_controller_presence_image
                sourceSize.width: 40
                sourceSize.height: 40
                visible: QJoysticks.count > 0? true : false
                source: "../../Images/game_control.png"
                //scale: mouseArea_rect.containsMouse ? 1.0 : 0.8

                MouseArea {
                    id: mouseArea_controller
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
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

    function resetMarker(){
        if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker)
            mivMarker.model.reset()
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line) {
            mivLine.model.reset()
            var n = mapPoly.pathLength()
            for (var i = 0; i < n; i++)  {
                mapPoly.removeCoordinate(0)
            }
        }
    }
    function uploadFile(fileName){
        if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker)
            return mivMarker.model.readDataFromFile(fileName)
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line){
            var msg = mivLine.model.readDataFromFile(fileName)
            for (var i = 0; i < mivLine.model.rowCount(); i++)
                mapPoly.addCoordinate(mivLine.model.getCoordinate(i))
            return msg
        }
    }
    function send_point(){
        if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker)
        {
            if( mivMarker.model.rowCount()!==0 && data_model.data_source.is_connected){
                // sending first marker only
                var lat = mivMarker.model.getCoordinate(0).latitude
                var lon = mivMarker.model.getCoordinate(0).longitude
                // todo better way to concatenate (also a function)
                publish_topic(set_lat_lon_tn, lat + " " + lon + " " + root.xValue)
                return "Sending point (" + lat +" "+ lon +") X = " + root.xValue
            }
            else if(!data_model.data_source.is_connected)
                return "Connection is not established!"
            else
                return "No points available!"
        }
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line){
            if(mivLine.model.rowCount()!==0){
                //publish_topic()
                return "Not implemented yet"
            }
            else
                return "No points available!"
        }
    }
    function add_point(lat, lon){
        mivMarker.model.insertSingleMarker(QtPositioning.coordinate(lat, lon))
    }
}
