import QtQuick 2.15
import QtQuick.Window 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

ApplicationWindow {
    id: root
    width: 1410
    height: 850
    visible: true
    title: qsTr("Swamp interface")
    property bool connected: false
    property bool startUp: true
    property double timestamp: 0

    onStartUpChanged: navigation_map.center =
                      QtPositioning.coordinate(navigation_map.lat, navigation_map.lon)

    menuBar: CustomMenuBar {}

    Connections {
        target: mqtt_client
        function onNewCoordinate(top, coor) {

            if (top === "longitude")
                navigation_map.lon = coor
            else
                navigation_map.lat = coor

            if (startUp & navigation_map.lon!= 0 & navigation_map.lat!=0 ) {
                navigation_map.center = QtPositioning.coordinate(
                            navigation_map.lat, navigation_map.lon)
                navigation_map.zoomLevel = 17
                startUp = false
            }
        }

        function onStateChanged(state) {
            if (state === 2)
                connected = true
            else
                connected = false
        }
        function onNewTimeStamp(value) {
            force_slider_panel.timestamp = value
            engine_panel.timestamp = value
        }
        function onNewRotation(top, value){
            // TODO is this the best way to send the rotation value?
            // alternative: custom signals + connections{}
            // model view delegate for all values coming from mqtt peraphs grouped?
            navigation_map.rotation = value
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 10

        NavigationMap {
            // move to custom item
            id: navigation_map

            //Layout.preferredWidth: 1000
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 10
            //Layout.bottom: root.bottom
            //rotation: force_slider_panel.rotation_value
        }

        Item {
            Layout.alignment: Qt.AlignTop
            id: rect

            Layout.preferredWidth: 400
            //Layout.fillWidth: true
            Layout.preferredHeight: 800
            Layout.topMargin: 10
            ColumnLayout {
                anchors.fill: parent
                spacing: 10
                EnginePanel {
                    id: engine_panel
                    Layout.fillWidth: true
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignTop
                    // TODO i cannot access enum?
                    opacity: root.connected ? 1 : 0.3
                    enabled: root.connected
                }
                ForceSliderPanel {
                    id: force_slider_panel
                    Layout.fillWidth: true
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignTop
                    clip: true
                    opacity: root.connected ? 1 : 0.3
                    enabled: root.connected
                }
                Button {
                    id: connect_button
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    onClicked: {
                        if (!root.connected) {
                            mqtt_client.connectToHost()
                        } else {
                            mqtt_client.disconnectFromHost()
                        }
                    }
                    contentItem: Text {
                        text: root.connected ? "disconnect" : "connect"
                        font.family: "Helvetica"
                        font.pointSize: 18
                        //opacity: connect_button.connect ? 1.0 : 0.3
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }
}
