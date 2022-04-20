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
        //Layout.fillHeight: true
        //Layout.fillWidth: true
        height: implicitHeight + 50
        width: parent.width
    }
    GridLayout{
        id: minion_panel_grid
        columns: 2
        columnSpacing: 2
        rowSpacing: 2
        anchors{
            top:  generic.bottom
            bottom: parent.bottom; left: parent.left; right: parent.right
            topMargin: rowSpacing
        }
        MinionPumpPanel{
            id: pump_panel
            Layout.minimumHeight: Math.max(pump_panel.implicitHeight, azimuth_panel.implicitHeight)
            Layout.minimumWidth: implicitWidth
            Layout.preferredHeight: minimumHeight + 50
            Layout.fillWidth: true
            //Layout.fillHeight: true
        }
        MinionAzimuthPanel{
            id: azimuth_panel
            Layout.minimumHeight: Math.max(pump_panel.implicitHeight, azimuth_panel.implicitHeight)
            Layout.preferredHeight: minimumHeight + 50
            Layout.minimumWidth: implicitWidth
            Layout.fillWidth: true
            //Layout.fillHeight: true
        }
        MinionIMUPanel{
            id: imu_panel
            Layout.minimumHeight: Math.max(imu_panel.implicitHeight, gps_panel.implicitHeight)
            Layout.minimumWidth: implicitWidth
            Layout.preferredHeight: minimumHeight + 50
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        MinionGPSPanel{
            id: gps_panel
            Layout.minimumHeight: Math.max(imu_panel.implicitHeight, gps_panel.implicitHeight)
            Layout.minimumWidth: implicitWidth
            Layout.preferredHeight: minimumHeight + 50
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
