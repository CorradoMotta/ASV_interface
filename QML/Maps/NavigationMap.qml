import QtQuick 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Layouts 1.11
import "../BasicItems"
Map {
    id: navigation_map
    //anchors.fill: parent
    plugin: MapBoxPlugin {}
    property real lat: data_model.data_source.swamp_status.gps_ahrs_status.latitude.value
    property real lon: data_model.data_source.swamp_status.gps_ahrs_status.longitude.value
    property real v_rotation : root.convertToRadiant(data_model.data_source.swamp_status.ngc_status.psi.value)
    property bool is_centered: true
    property var initialCoordinates: QtPositioning.coordinate(lat, lon)

    gesture.enabled: true
    gesture.acceptedGestures: MapGestureArea.PanGesture | MapGestureArea.PinchGesture
    onLatChanged: lon !=0 ? root.startUp = false: ""
    onLonChanged: lat !=0 ? root.startUp = false: ""
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

    VehicleMapItem {
        id: swamp_icon
        rotation: v_rotation
        coordinate:  QtPositioning.coordinate(lat, lon)
    }

    MapItemView {
        id: mivMarker
        model: _marker_model // defined in c++
        delegate: DelegateSingleMarker {
            coordinate: QtPositioning.coordinate(model.coordinate.latitude,
                                                 model.coordinate.longitude)
        }
    }

    MouseArea {
        id: navigation_mouse_area
        anchors.fill: parent
        onPressAndHold: console.log("released")
        onClicked: {
            var crd = navigation_map.toCoordinate(Qt.point(mouseX, mouseY))
            mivMarker.model.insertCoordinate(mivMarker.model.index, crd)
        }
    }

    RecenterButton{
        id: recenter
    }

    ColumnLayout{
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.rightMargin: 20
    anchors.bottomMargin: 20

    BoxDrawItem{
        clip: true
        id: rectangle_box_item
        Layout.preferredHeight: pre_heigth
        Layout.preferredWidth: pre_width
        source: "../../Images/rect_box.png"
    }
    BoxDrawItem{
        id: rectangle_marker_item
        Layout.preferredHeight: pre_heigth
        Layout.preferredWidth: pre_width
        source: "../../Images/marker_box.png"
    }
    BoxDrawItem{
        id: rectangle_list_item
        Layout.preferredHeight: pre_heigth
        Layout.preferredWidth: pre_width
        source: "../../Images/line_box.png"
    }
    }
}
