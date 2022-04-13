/*************************************************************************
 *
 * This element contains the view of a single minion. It is intended to be
 * used as a content of a tab bar where all minions can be viewed.
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../Panels"

Item {
    MinionGenericPanel{
        id: generic
        height: 200
        width: parent.width
    }
    GridLayout{
        id: minion_panel_grid
        columns: 2
        anchors{
            top:  generic.bottom
            bottom: parent.bottom; left: parent.left; right: parent.right
            topMargin: rowSpacing
        }
        MinionPumpPanel{
            id: pump_panel
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        MinionAzimuthPanel{
            id: azimuth_panel
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        MinionIMUPanel{
            id: imu_panel
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        MinionGPSPanel{
            id: gps_panel
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
}
