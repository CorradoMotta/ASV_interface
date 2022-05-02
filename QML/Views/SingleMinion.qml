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
    property int minimumXDim : minion_panel_cln.implicitWidth
    property int minimumYDim: minion_panel_cln.implicitHeight

    ColumnLayout{
        id: minion_panel_cln
        anchors{
            fill: parent
        }
        spacing: 2
        MinionGenericPanel{
            id: generic
            Layout.minimumHeight: implicitHeight
            Layout.minimumWidth: implicitWidth
            Layout.preferredHeight: generic.minimumHeight + 50
            Layout.fillWidth: true
        }
        GridLayout{
            id: minion_panel_grid
            columns: 2
            columnSpacing: 2
            rowSpacing: 2

            MinionPumpPanel{
                id: pump_panel
                Layout.minimumHeight: Math.max(pump_panel.implicitHeight, azimuth_panel.implicitHeight)
                Layout.minimumWidth: implicitWidth
                Layout.preferredHeight: pump_panel.minimumHeight + 50
                Layout.fillWidth: true
                //Layout.fillHeight: true
            }
            MinionAzimuthPanel{
                id: azimuth_panel
                Layout.minimumHeight: Math.max(pump_panel.implicitHeight, azimuth_panel.implicitHeight)
                Layout.preferredHeight: azimuth_panel.minimumHeight + 50
                Layout.minimumWidth: implicitWidth
                Layout.fillWidth: true
                //Layout.fillHeight: true
            }
            MinionIMUPanel{
                id: imu_panel
                Layout.minimumHeight: Math.max(imu_panel.implicitHeight, gps_panel.implicitHeight)
                Layout.minimumWidth: implicitWidth
                Layout.preferredHeight: imu_panel.minimumHeight + 50
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            MinionGPSPanel{
                id: gps_panel
                Layout.minimumHeight: Math.max(imu_panel.implicitHeight, gps_panel.implicitHeight)
                Layout.minimumWidth: implicitWidth
                Layout.preferredHeight: gps_panel.minimumHeight + 50
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
