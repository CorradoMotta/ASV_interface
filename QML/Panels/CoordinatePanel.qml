/*************************************************************************
 *
 * Panel elements to interact with the coordinate model.
 * It allows to set a new purple marker on the vehicle position, set a
 * name for it, add it to the model and download all of them to file.
 * It is also possible to remove the single marker or all markers.
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
    Layout.preferredHeight: cl.implicitHeight
    color: "transparent"

    // alias
    property alias title : text_id.text
    property alias panel_color: rect.color



    //property string dateTime: data_model.data_source.swamp_status.time_status.dateTime.value
    //radius: 5.0
    //property alias max_depth : slider_depth.max_value //slider_value_id.text
    //property alias min_depth: slider_depth.min_value
    //property bool isPLaying: false

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
                font.pixelSize: 18
                font.bold: true
            }
            Rectangle{
                Layout.fillWidth: true
            }
        }
        Rectangle{
            id: rect
            Layout.fillWidth: true
            height: data_column.implicitHeight + 50
            width: data_column.implicitWidth + 50
            Layout.alignment: Qt.AlignTop
            radius: 5.0
            color: "aliceblue"
            border {
                color: "black"
                width: 2
            }
            ColumnLayout {
                id: data_column
                anchors.fill: parent
                //anchors.leftMargin: 10
                spacing: 0
                BasicTextInputInverted{
                    id: testo
                    Layout.leftMargin: 10
                    title_text: "POINT NAME"
                    titleSize: 18
                    new_text_value: ""
                    value_width: 240
                }

                RowLayout{
                    id: icon_row
                    spacing: 15
                    Layout.alignment: Qt.AlignHCenter

                    Image {
                        id: play_and_pause
                        property bool play : false
                        visible: true
                        source: "../../Images/plus_resized.png"
                        opacity: add_ma.pressed ? 0.8 : 1
                        MouseArea{
                            id: add_ma
                            anchors.fill: parent
                            onClicked: {
                                navigation_map.add_coor(testo.text_value)
                                testo.text_value = ""
                            }
                        }
                    }
                    Image {
                        id: download_icon
                        visible: true
                        source: "../../Images/download_resized.png"
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
                        source: "../../Images/stop_resized.png"
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
}
