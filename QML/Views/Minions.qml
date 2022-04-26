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

    property alias minimum_width : minion1.minimumXDim
    property alias minimum_height: minion1.minimumYDim
    property alias bathYValue : btChr.new_point

    Page{
        id: minion_page
        property int margin: 10

        anchors.fill: parent
        header: TabBar {
            id: bar
            //            TabButton {
            //                text: qsTr("general")
            //            }
            TabButton {
                text: qsTr("Bathimetry")
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

            Rectangle {
                id: general
                //color: "aliceblue"
                BathymetryChart{
                    id: btChr

                }
            }
            SingleMinion {
                id: minion_fl
                prefix: data_model.data_source.swamp_status.minion_fl
            }
            SingleMinion {
                id: minion_fr
                prefix: data_model.data_source.swamp_status.minion_fr
            }
            SingleMinion {
                id: minion_rl
                prefix: data_model.data_source.swamp_status.minion_rl
            }
            SingleMinion {
                id: minion_rr
                prefix: data_model.data_source.swamp_status.minion_rr
            }
        }
    }
}
