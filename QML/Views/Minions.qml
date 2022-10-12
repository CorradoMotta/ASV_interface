/*************************************************************************
 *
 * This element contains the Minions view. It is created as a page that
 * gets opened via the BasicStackButton. The page is structured with a tab
 * bar controlled by a StackLayout. Each item of the StackLayout is
 * described by the SingleMinion View.
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

    //todo put max here
    property int minimum_width : Math.max(ngc.minimumXDim,minion_fl.minimumXDim)
    property int minimum_height:  Math.max(ngc.minimumYDim,minion_fl.minimumYDim)
    // bathymetry (disabled) TODO FIX
    //property alias bathymetryPoint : btChr.newPoint
    //property alias bathymetryReset: btChr.reset
    //property alias maxDepth: btChr.yMAX

    //property alias xValue: ngc.xValue

    readonly property int tabLen: 3


    // button used to switch between minion's tab
    Connections {
        target: QJoysticks
        enabled: data_model.data_source.is_connected
        function onButtonChanged(js, button, pressed) {
            if (button === 2 && pressed === true){
                bar.currentIndex = bar.currentIndex > tabLen? 0 : bar.currentIndex+1
            }
        }
    }

    Page{
        id: minion_page
        property int margin: 10

        anchors.fill: parent
        header: TabBar {
            id: bar
            TabButton {
                id: ngc_tab
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
            // bathymetry (disabled)
//            TabButton {
//                text: qsTr("Dashboard")
//            }
        }

        StackLayout {
            id: view
            anchors.fill: parent
            anchors.margins: minion_page.margin
            currentIndex: bar.currentIndex
            Ngc {
                id: ngc
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
            // bathymetry (disabled)
//            Rectangle {
//                id: general
//            }
        }
    }
}
