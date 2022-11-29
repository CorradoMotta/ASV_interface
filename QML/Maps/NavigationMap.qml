/*************************************************************************
 *
 * Main map element. It contains the map and everything that is included
 * within the map. It also contains four model-view-delegate patterns.
 * One for markers, one for lines, one for coordinates of interest
 * and one for the bathymetry model.
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
import com.cnr.property 1.0
import "../BasicItems"
import "../Panels"

Rectangle{
    id: navigation_map

    // custom properties
    readonly property real hueMin : 0.513
    readonly property real hueMax : 0.652
    property int activeMap : 0
    property real latValue : lat.value
    property real lonValue: lon.value
    property bool is_centered: true
    property var initialCoordinates: QtPositioning.coordinate(lat.value, lon.value)
    property real rando : 0
    property int bath_counter: 0
    property bool ref_elements_visibility: true

    // bathymetry
    property double initialValue : 7.13
    property int max_bathymetry_depth : bathymetry_panel.max_depth
    property int min_bathymetry_depth : bathymetry_panel.min_depth
    onMax_bathymetry_depthChanged: bathView.model.newDepthRange(max_bathymetry_depth, min_bathymetry_depth)
    onMin_bathymetry_depthChanged: bathView.model.newDepthRange(max_bathymetry_depth, min_bathymetry_depth)

    // alias
    property alias mapTypes: swamp_map.supportedMapTypes
    property alias mapName: swamp_map.plugin.name
    property alias zoomLevel: swamp_map.zoomLevel

    // Cpp members
    property real ngc_timestamp: data_model.data_source.swamp_status.gps_ahrs_status.timestamp.value
    property real v_rotation : data_model.data_source.swamp_status.ngc_status.psi.value //convertToRadiant
    property var lat: data_model.data_source.swamp_status.gps_ahrs_status.latitude
    property var lon: data_model.data_source.swamp_status.gps_ahrs_status.longitude
    property real altitude: data_model.data_source.swamp_status.ngc_status.altitude.value
    property real homeLatRef: data_model.data_source.swamp_status.ngc_status.latHomeRef.value
    property real homeLonRef: data_model.data_source.swamp_status.ngc_status.lonHomeRef.value
    property real asvReflatRef: data_model.data_source.swamp_status.ngc_status.asvReflatRef.value
    property real asvReflonRef: data_model.data_source.swamp_status.ngc_status.asvReflonRef.value
    readonly property string set_lat_lon_tn: data_model.data_source.swamp_status.ngc_status.setLatLon.topic_name //TODO FIX
    readonly property string set_path_following_tn: data_model.data_source.swamp_status.ngc_status.setPFLatLon.topic_name //TODO FIX
    readonly property string set_segment_tn: data_model.data_source.swamp_status.ngc_status.setSegment.topic_name
    readonly property string set_line_lat_lon: data_model.data_source.swamp_status.ngc_status.setLineLatLon.topic_name //TODO FIX
    readonly property string set_robot_home_tn: data_model.data_source.swamp_status.ngc_status.setRobotHome.topic_name //TODO FIX
    readonly property var publish_topic: data_model.data_source.publishMessage //todo repetition
    readonly property real asvReflatLRef: data_model.data_source.swamp_status.ngc_status.asvReflatLref.value
    readonly property real asvReflonLRef: data_model.data_source.swamp_status.ngc_status.asvReflonLref.value
    readonly property real asvReflatL2ref : data_model.data_source.swamp_status.ngc_status.asvReflatL2ref.value
    readonly property real asvReflonL2ref : data_model.data_source.swamp_status.ngc_status.asvReflonL2ref.value
    readonly property real latRabbit:    data_model.data_source.swamp_status.ngc_status.latRabbit.value
    readonly property real lonRabbit :   data_model.data_source.swamp_status.ngc_status.lonRabbit.value
    readonly property real gammaRabbit : data_model.data_source.swamp_status.ngc_status.gammaRabbit.value

    // TODO use them or remove them
    readonly property var coorL : QtPositioning.coordinate(asvReflatLRef, asvReflonLRef)
    readonly property var coorL2 : QtPositioning.coordinate(asvReflatL2ref, asvReflonL2ref)

    // signals
    onLatValueChanged: lon.value !==0 ? root.startUp = false: ""
    onLonValueChanged: lat.value !==0 ? root.startUp = false: ""
    onHomeLatRefChanged: homeLonRef != 0 ? root.messagePrompt("Robot's home set in (" + homeLatRef + " " + homeLonRef +")") : ""
    onHomeLonRefChanged: homeLatRef != 0 ? root.messagePrompt("Robot's home set in (" + homeLatRef + " " + homeLonRef +")") : ""

    // to display line following
    onAsvReflatLRefChanged:   mapPolyLF.replaceCoordinate(0,QtPositioning.coordinate(asvReflatLRef,asvReflonLRef))
    onAsvReflonLRefChanged:   mapPolyLF.replaceCoordinate(0,QtPositioning.coordinate(asvReflatLRef,asvReflonLRef))
    onAsvReflatL2refChanged:  mapPolyLF.replaceCoordinate(1,QtPositioning.coordinate(asvReflatL2ref, asvReflonL2ref))
    onAsvReflonL2refChanged:  mapPolyLF.replaceCoordinate(1,QtPositioning.coordinate(asvReflatL2ref, asvReflonL2ref))

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
                pump_jet_status: data_model.data_source.swamp_status.ngc_status.pumpJetMonitor.fl_pj_status.value
                info_prefix: "FL"
            }
            MinionStateRow{
                id: minion_fr
                dotSize: status_bar.dotSize
                prefix: data_model.data_source.swamp_status.minion_fr
                pump_jet_status: data_model.data_source.swamp_status.ngc_status.pumpJetMonitor.fr_pj_status.value
                info_prefix: "FR"
            }
            MinionStateRow{
                id: minion_rl
                dotSize: status_bar.dotSize
                prefix: data_model.data_source.swamp_status.minion_rl
                pump_jet_status: data_model.data_source.swamp_status.ngc_status.pumpJetMonitor.rl_pj_status.value
                info_prefix: "RL"
            }
            MinionStateRow{
                id: minion_rr
                dotSize: status_bar.dotSize
                prefix: data_model.data_source.swamp_status.minion_rr
                pump_jet_status: data_model.data_source.swamp_status.ngc_status.pumpJetMonitor.rr_pj_status.value
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
        copyrightsVisible: false
        gesture.enabled: true
        gesture.acceptedGestures: MapGestureArea.PanGesture | MapGestureArea.PinchGesture
        gesture.onPanFinished: {
            if(!visibleRegion.contains(QtPositioning.coordinate(navigation_map.lat.value, navigation_map.lon.value)) && !root.startUp)
                navigation_map.is_centered = false
            else if(navigation_map.is_centered)
                navigation_map.is_centered = true
        }
        activeMapType: data_model.data_source.swamp_status.conf.mb_style === HciNgiInterface.MB_SATELLITE? supportedMapTypes[4]:
                                                                                                           data_model.data_source.swamp_status.conf.mb_style === HciNgiInterface.MB_STREET? supportedMapTypes[0]:
                                                                                                                                                                                            supportedMapTypes[0]
        MouseArea {
            id: navigation_mouse_area
            anchors.fill: parent
            onClicked: {
                var crd = swamp_map.toCoordinate(Qt.point(mouseX, mouseY))
                if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker)
                    mivMarker.model.insertSingleMarker(crd,0,0)
                else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.MultipleMarker)
                    mivMarkerMultiple.model.insertSingleMarker(crd)
                else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Rectangle)
                    console.log("Not implemented yet!")
                else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line){
                    mivLine.model.insertSingleMarker(crd)
                    mapPoly.addCoordinate(crd)
                }
            }
        }

        VehicleMapItem {
            id: swamp_icon
            z: 1
            rotation: navigation_map.v_rotation
            coordinate:  QtPositioning.coordinate(navigation_map.lat.value, navigation_map.lon.value)
            // bathymetry (disabled)
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



        // bathymetry (disabled)
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

        // create a listModel to provide data used for creating the map items defined by the delegate.
        MapItemView {
            id: coorView

            model: _coor_model
            delegate: DelegateSingleCoordinate{
                id: my_coor_delegate
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
                font.family: "helvetica"
                font.pixelSize: 14
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

        // =================================================================================
        // REF markers and lines
        // =================================================================================

        // show ref marker for line of sight
        MarkerRef{
            id: lf_marker_ref

            coordinate: QtPositioning.coordinate(navigation_map.asvReflatRef, navigation_map.asvReflonRef)
            label_text: "[LoS] " + navigation_map.asvReflatRef + "-" + navigation_map.asvReflonRef
            visible: ref_elements_visibility
        }

        // show ref marker for path following
        MarkerRef{
            id: pf_marker_ref
            z: 1
            coordinate: QtPositioning.coordinate(navigation_map.latRabbit, navigation_map.lonRabbit)
            label_text: "[PF] GAMMA: " + navigation_map.gammaRabbit
            visible: ref_elements_visibility
        }

        // show ref line for line following
        MapPolyline {
            id: mapPolyLF
            line.width: 3
            line.color: 'purple'
            visible: ref_elements_visibility
            path: [
                QtPositioning.coordinate(0,0),
                QtPositioning.coordinate(0,0)]
        }

        // =================================================================================
        // models
        // =================================================================================

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

        // model for multiple markers
        MapItemView {
            id: mivMarkerMultiple
            model: _multiple_marker_model // defined in c++
            delegate: DelegateMultipleMarker {
                id: my_marker_multiple_delegate
                z : 2
                coordinate: QtPositioning.coordinate(model.coordinate.latitude,
                                                     model.coordinate.longitude)
                is_enable: draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.MultipleMarker? true : false
            }
        }

        // model for polylines (e.g. segment for LF)
        MapPolyline {
            id: mapPoly
            line.width: 2.5
            line.color: 'red'
            MouseArea{
                drag.target: mapPoly
            }
        }
        // model for multiple markers (SPLINE)
        MapPolyline {
            id: map_poly_multiple_marker
            line.width: 2.5
            line.color: 'red'
        }

        MapItemView {
            id: mivLine
            model: _line_model
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

        // =================================================================================
        // Icon on map
        // =================================================================================

        RowLayout{
            id: clBottomLeft
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 20
            spacing: 4
            MapIconClickable{
                id: set_mapbox_style_image
                img_source: "../../Images/map_style.png"
                img_opacity: 0.9
                ma_enabled: data_model.data_source.swamp_status.conf.mb_style === HciNgiInterface.MB_ALL
                onClick: navigation_map.activeMap===0? setActiveMap(4) : setActiveMap(0)
            }
            MapIconClickable{
                id: set_robot_home
                img_source: "../../Images/home-button.png"
                onClick: publish_topic(set_robot_home_tn, 1)
            }
            MapIconClickable{
                id: set_ref_visibility
                img_source:  "../../Images/ref_visibility.png"
                onClick: ref_elements_visibility? ref_elements_visibility = false : ref_elements_visibility = true
            }
        }

        Rectangle{
            id: cl
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin : 80
            anchors.topMargin: 20
            MapIcon{
                id: set_north_arrow
                img_opacity: 0.8
                img_source: "../../Images/compass.png"
            }
        }

        Rectangle{
            id: set_controller_presence
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 20
            anchors.topMargin: 20
            MapIcon{
                id: set_controller_presence_image
                img_source: "../../Images/game_control.png"
                img_size: 40
                visible: QJoysticks.count > 0? true : false
            }
        }

    }
    function setActiveMap(index) {
        if(index === 0) navigation_map.activeMap = 0
        else navigation_map.activeMap = 4
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
        var n = 0
        var i = 0
        if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker)
            mivMarker.model.reset()
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.MultipleMarker){
            mivMarkerMultiple.model.reset()
            n = map_poly_multiple_marker.pathLength()
            for (i = 0; i < n; i++)  {
                map_poly_multiple_marker.removeCoordinate(0)
            }
        }
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line) {
            mivLine.model.reset()
            n = mapPoly.pathLength()
            for (i = 0; i < n; i++)  {
                mapPoly.removeCoordinate(0)
            }
        }
    }
    function uploadFile(fileName){
        if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker)
            return mivMarker.model.readDataFromFile(fileName)
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.MultipleMarker)
            return mivMarkerMultiple.model.readDataFromFile(fileName)
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line){
            var msg = mivLine.model.readDataFromFile(fileName)
            for (var i = 0; i < mivLine.model.rowCount(); i++)
                mapPoly.addCoordinate(mivLine.model.getCoordinate(i))
            return msg
        }
    }
    function send_point(){
        var lat
        var lon
        var coor_list
        var i
        if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker)
        {
            if( mivMarker.model.rowCount()!==0 && data_model.data_source.is_connected){
                // sending first marker only
                lat = mivMarker.model.getCoordinate(0).latitude
                lon = mivMarker.model.getCoordinate(0).longitude
                // todo better way to concatenate (also a function)
                publish_topic(set_lat_lon_tn, lat + " " + lon + " " + root.xValue)
                return "Sending point (" + lat +" "+ lon +") X = " + root.xValue
            }

            else if(!data_model.data_source.is_connected)
                return "Connection is not established!"
            else
                return "No points available!"
        }
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.MultipleMarker)
        {
            if( mivMarkerMultiple.model.rowCount()===6 && data_model.data_source.is_connected){
                var periodicity
                if(menu_bar_id.isPeriodic) periodicity = 1
                else periodicity = 0
                coor_list = periodicity + " " + root.xValue  //HciNgiInterface.PATH_PLANNER_COMPUTE_SPLINE +
                for (i = 0; i < 6; i++)
                    coor_list = coor_list + " " + mivMarkerMultiple.model.getCoordinate(i).latitude + " " + mivMarkerMultiple.model.getCoordinate(i).longitude

                publish_topic(set_path_following_tn, coor_list)
                return "Sending list of six points. X = " + root.xValue
            }

            else if(!data_model.data_source.is_connected)
                return "Connection is not established!"
            else
                return "Exactly six points are needed!"
        }
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line){
            if(mivLine.model.rowCount()===2){
                coor_list = ""
                for (i = 0; i < 2; i++)
                    coor_list = coor_list + " " + mivLine.model.getCoordinate(i).latitude + " " + mivLine.model.getCoordinate(i).longitude
                coor_list = coor_list + " " + root.xValue
                publish_topic(set_segment_tn, coor_list)
                return "Sending segment of two points. X = " + root.xValue
            }
            else
                return "Exactly two points are needed!"
        }
    }

    function send_line(){
        if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Marker)
        {
            if( mivMarker.model.rowCount()!==0 && data_model.data_source.is_connected){
                var lat = mivMarker.model.getCoordinate(0).latitude
                var lon = mivMarker.model.getCoordinate(0).longitude
                publish_topic(set_line_lat_lon, lat + " " + lon + " " + root.gammaValue + " " + root.xValue)
                return "Sending point (" + lat +" "+ lon +") X = " + root.xValue  +" GAMMA = " + root.gammaValue
            }
            else if(!data_model.data_source.is_connected)
                return "Connection is not established!"

            else
                return "No points available!"
        }
        else if(draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.Line){
            if(mivLine.model.rowCount()!==0  && data_model.data_source.is_connected){
                return "Use a single point from the marker box for line following"
            }
            else
                return "No points available!"
        }
    }

    function add_point(lat, lon){
        mivMarker.model.insertSingleMarker(QtPositioning.coordinate(lat, lon),0,0)
    }
    function add_coor(name ="no_name"){
        coorView.model.insertSingleMarker(QtPositioning.coordinate(navigation_map.lat.value, navigation_map.lon.value), name, navigation_map.ngc_timestamp)
    }
    function updateLine(){
        // generate path with new control points
        if(mivMarkerMultiple.model.rowCount()!==6)
            root.messagePrompt("Exactly six points are needed to generate the path")
        else
            map_poly_multiple_marker.setPath(mivMarkerMultiple.model.generatePath())
    }
}
