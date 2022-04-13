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

Item {
    Page{
        id: minion_page
        property int margin: 10
        anchors.fill: parent
        header: TabBar {
            id: bar
            TabButton {
                text: qsTr("general")
                onClicked:{
                    console.log("general")
                }
            }
            TabButton {
                text: qsTr("Minion 1")
            }
            TabButton {
                text: qsTr("Minion 2")
            }
            TabButton {
                text: qsTr("Minion 3")
            }
            TabButton {
                text: qsTr("Minion 4")
            }
        }

        StackLayout {
            id: view
            anchors.fill: parent
            anchors.margins: minion_page.margin
            currentIndex: bar.currentIndex

            Item {
                id: general
            }
            SingleMinion {
                id: minion1
            }
            SingleMinion {
                id: minion2
            }
            SingleMinion {
                id: minion3
            }
            SingleMinion {
                id: minion4
            }
        }
    }
}
