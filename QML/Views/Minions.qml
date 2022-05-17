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
import "../Panels"
import "../Views"
import "../Charts"
Item {

    property alias minimum_width : minion_fl.minimumXDim
    property alias minimum_height: minion_fl.minimumYDim
    property alias bathymetryPoint : btChr.newPoint
    property alias bathymetryReset: btChr.reset
    //property alias maxDepth: btChr.yMAX

    Page{
        id: minion_page
        property int margin: 10

        anchors.fill: parent
        header: TabBar {
            id: bar
            TabButton {
                text: qsTr("NGC")
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
            TabButton {
                text: qsTr("Bathimetry")
            }
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
            Rectangle {
                id: general
                BathymetryChart{
                    id: btChr

                }
            }
        }
    }
}
