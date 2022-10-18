/*************************************************************************
 *
 * This element contains the Minions view. It is created as a page that
 * gets opened via the BasicStackButton. The page is structured with a tab
 * bar controlled by a StackLayout. Each item of the StackLayout is
 * described by the SingleMinion View. An extra tab called dashboard
 * contains the vehicle telemetry.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQml 2.15
import "../Panels"
import "../Views"
import "../Charts"

Item {

    // custom properties
    readonly property int tabLen: 3
    property int minimum_width : Math.max(dashboard.minimumXDim, minion_fl.minimumXDim)
    property int minimum_height: Math.max(dashboard.minimumYDim, minion_fl.minimumYDim)

    // alias TODO: make signals instead
    property alias bathymetryPoint : dashboard.newPoint
    property alias bathymetryReset: dashboard.reset
    property alias maxDepth: dashboard.yMAX

    Page{
        id: minion_page
        anchors.fill: parent
        property int margin: 10

        header: TabBar {
            id: bar
            TabButton {
                text: qsTr("Dashboard")
            }
            TabButton {
                text: qsTr("Minion FL")
            }
            TabButton {
                text: qsTr("Minion FR")
            }
            TabButton {
                text: qsTr("Minion RL")
            }
            TabButton {
                text: qsTr("Minion RR")
            }
        }

        StackLayout {
            id: view
            anchors.fill: parent
            anchors.margins: minion_page.margin
            currentIndex: bar.currentIndex

            Dashboard {
                id: dashboard
            }
            SingleMinion {
                id: minion_fl
                engineState: engine_panel.engine_state_fl
                prefix: data_model.data_source.swamp_status.minion_fl
            }
            SingleMinion {
                id: minion_fr
                engineState: engine_panel.engine_state_fr
                prefix: data_model.data_source.swamp_status.minion_fr
            }
            SingleMinion {
                id: minion_rl
                engineState: engine_panel.engine_state_rl
                prefix: data_model.data_source.swamp_status.minion_rl
            }
            SingleMinion {
                id: minion_rr
                engineState: engine_panel.engine_state_rr
                prefix: data_model.data_source.swamp_status.minion_rr
            }
        }
    }

    Connections {
        // to switch between tabs
        target: QJoysticks
        enabled: data_model.data_source.is_connected

        function onButtonChanged(js, button, pressed) {
            if (button === 2 && pressed === true){
                bar.currentIndex = bar.currentIndex > tabLen? 0 : bar.currentIndex+1
            }
        }
    }
}
