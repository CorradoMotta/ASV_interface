/*************************************************************************
 *
 * Panel elements to interact with the dynamic bathymetry model.
 * It allows to stop and play, remove all depth points or save them to disk.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "../BasicItems"

Rectangle {
    id: root_bath_panel

    // properties
    Layout.preferredHeight: slider_depth.implicitHeight + icon_row.implicitHeight + 33 //TODO not having numbers here.
    radius: 5.0
    border {
        color: "black"
        width: 2
    }

    // custom properties
    property bool isPLaying: false
    property string dateTime: data_model.data_source.swamp_status.time_status.dateTime.value

    // alias
    property alias max_depth : slider_depth.max_value
    property alias min_depth: slider_depth.min_value

    BasicRangeSlider{
        id: slider_depth
        slider_text: "Bathymetry"
        anchors{
            left: parent.left
            top: parent.top
            topMargin: 8
            leftMargin: 10
        }
    }
    RowLayout{
        id: icon_row
        spacing: 15
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: slider_depth.bottom
            topMargin: 12
            leftMargin: 10
        }
        Image {
            id: play_and_pause
            visible: true
            source: root_bath_panel.isPLaying? "../../Images/pause_resized.png" : "../../Images/play-button_resized.png"
            property bool play : false
            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    if(root_bath_panel.isPLaying) root_bath_panel.isPLaying = false
                    else root_bath_panel.isPLaying = true
                }
            }

        }
        Image {
            id: download_icon
            visible: true
            source: "../../Images/download_resized.png"
            opacity: root_bath_panel.isPLaying? 0.4 : 1
            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    if(!root_bath_panel.isPLaying) {
                        var message = _bathymetry_model.saveToDisk(root_bath_panel.dateTime)
                        root.messagePrompt(message)
                    }
                }
            }
        }
        Image {
            id: reset_icon
            visible: true
            source: "../../Images/stop_resized.png"
            opacity: root_bath_panel.isPLaying? 0.4 : 1
            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    if(!root_bath_panel.isPLaying) {

                        _bathymetry_model.reset()
                        minion_view.bathymetryReset = true
                        navigation_map.bath_counter = 0
                    }
                }
            }
        }
    }
}
