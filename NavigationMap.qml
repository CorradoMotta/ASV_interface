import QtQuick 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Layouts 1.11


Map {
    id: navigation_map
    //anchors.fill: parent
    plugin: EsriPlugin {}
    property real lat: data_model.data_source.swampData().gps_ahrs_status.latitude.value
    property real lon: data_model.data_source.swampData().gps_ahrs_status.longitude.value
    property real v_rotation : data_model.data_source.swampData().ngc_status.psi.value
    property var initialCoordinates: QtPositioning.coordinate(lat, lon)

    onLatChanged: lon !=0 ? root.startUp = false: ""
    onLonChanged: lat !=0 ? root.startUp = false: ""
    activeMapType: supportedMapTypes[0]
    //minimumZoomLevel: 8
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

        onClicked: {
            var crd = navigation_map.toCoordinate(Qt.point(mouseX, mouseY))
            mivMarker.model.insertCoordinate(mivMarker.model.index, crd)
        }
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
        source: "Images/rect_box.png"
    }
    BoxDrawItem{
        id: rectangle_marker_item
        Layout.preferredHeight: pre_heigth
        Layout.preferredWidth: pre_width
        source: "Images/marker_box.png"
    }
    BoxDrawItem{
        id: rectangle_list_item
        Layout.preferredHeight: pre_heigth
        Layout.preferredWidth: pre_width
        source: "Images/line_box.png"
    }
    }
}
