import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "../BasicItems"

Rectangle {
    id: root
    Layout.preferredHeight: slider_depth.implicitHeight + icon_row.implicitHeight + 33 //TODO not having numbers here.
    radius: 5.0
    property alias max_depth : slider_depth.max_value //slider_value_id.text
    property alias min_depth: slider_depth.min_value
    property bool isPLaying: false
    border {
        color: "black"
        width: 2
    }
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
            property bool play : false
            visible: true
            source: root.isPLaying? "../../Images/pause_resized.png" : "../../Images/play-button_resized.png"
            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    if(root.isPLaying) root.isPLaying = false
                    else root.isPLaying = true
                }
            }

        }
        Image {
            id: download_icon
            visible: true
            source: "../../Images/download_resized.png"
            opacity: root.isPLaying? 0.4 : 1
        }
        Image {
            id: stop_icon
            visible: true
            source: "../../Images/stop_resized.png"
            opacity: root.isPLaying? 0.4 : 1
        }

    }
}
