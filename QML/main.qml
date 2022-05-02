import QtQuick 2.15
import QtQuick.Window 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import "BasicItems"
import "Maps"
import "Panels"
import "Views"

ApplicationWindow {
    id: root
    width: 1900
    minimumWidth: minion_view.minimum_width + main_layout.implicitWidth + 20
    minimumHeight: minion_view.minimum_height + menu_bar_id.implicitHeight + 100
    height: 1000
    visible: true
    title: qsTr("Swamp interface")
    property double pi_value: 3.1415926535
    property bool connected: false
    property bool startUp: true
    property double timestamp: 0

    function convertToRadiant(value) {
        var value_in_radiant = value * 180 / pi_value
        return value_in_radiant
    }

    onStartUpChanged:{
        navigation_map.zoomLevel = 18
        navigation_map.center =
                QtPositioning.coordinate(navigation_map.lat, navigation_map.lon)
    }

    menuBar: CustomMenuBar {
        id: menu_bar_id
    }

    // instantiate the minion view
    Minions{
        id: minion_view
    }

    RowLayout {
        id: main_layout
        anchors.fill: parent
        spacing: 10

        StackView {
            id: stack
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            Layout.topMargin: 10
            initialItem: NavigationMap{
                id: navigation_map
            }
        }

        BasicStackButton{
            id: stack_button
            Layout.topMargin: 10
            Layout.fillHeight: true
            Layout.preferredWidth: 30
        }

        Rectangle {
            id: control_panel
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 400
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
                    opacity: data_model.data_source.is_connected ? 1 : 0.3
                    enabled: data_model.data_source.is_connected

                }
                ForceSliderPanel {
                    id: force_slider_panel
                    Layout.fillWidth: true
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignTop
                    clip: true
                    opacity: data_model.data_source.is_connected ? 1 : 0.3
                    enabled: data_model.data_source.is_connected
                }
                Button {
                    id: connect_button
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    onClicked: data_model.data_source.setConnection()
                    contentItem: Text {
                        text: data_model.data_source.is_connected ? "disconnect" : "connect"
                        font.family: "Helvetica"
                        font.pointSize: 18
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
