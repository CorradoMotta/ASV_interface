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
    Layout.preferredHeight: cl.implicitHeight
    radius: 5.0
    color: "transparent"

    property alias title : text_id.text
    property alias panel_color: rect.color
    property bool isPLaying: false

    ColumnLayout {
        id: cl
        spacing: 0
        anchors.fill: parent
        RowLayout{
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true

            Text {
                id: text_id
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 4
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true
            }
            Rectangle{
                Layout.fillWidth: true
            }
        }
        Rectangle{
            id: rect
            Layout.fillWidth: true
            height: icon_row.implicitHeight + 50
            width: icon_row.implicitWidth + 50
            Layout.alignment: Qt.AlignTop
            radius: 5.0
            color: "aliceblue"
            border {
                color: "black"
                width: 2
            }

            RowLayout{
                id: icon_row
                anchors.centerIn: parent
                anchors.leftMargin: 10

                spacing: 15
                Layout.alignment: Qt.AlignHCenter

                Image {
                    id: play_and_pause
                    property bool play : false
                    visible: true
                    source: "../../Images/play-button_resized.png"
                    opacity: add_ma.pressed ? 0.8 : 1
                    MouseArea{
                        id: add_ma
                        anchors.fill: parent
                        onClicked: navigation_map.add_coor(testo.text_value)
                    }

                }
                Image {
                    id: download_icon
                    visible: true
                    source: "../../Images/pause_resized.png"
                    opacity: download_ma.pressed ? 0.8 : 1
                    MouseArea{
                        id: download_ma
                        anchors.fill: parent
                        onClicked:
                        {
                            if(!root_bath_panel.isPLaying) {
                                var message = _coor_model.saveToDisk(data_model.data_source.swamp_status.conf.coordinatePath)
                                root.messagePrompt(message)
                            }
                        }
                    }
                }
                Image {
                    id: reset_icon
                    visible: true
                    opacity: reset_ma.pressed ? 0.8 : 1
                    source: "../../Images/resume.png"
                    MouseArea{
                        id: reset_ma
                        anchors.fill: parent
                        onClicked: _coor_model.reset()
                    }
                }
            }
        }
    }
}

