/*************************************************************************
 *
 * Panel elements to control naval maneuvers. It allows to launch, stop
 * and resume the maneuvers.
 *
 * Author: Corrado Motta
 * Date: 09/2022
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

    // custom properties
    property bool isPLaying: false
    property bool isStopped: false

    // alias
    property alias title : text_id.text
    property alias panel_color: rect.color

    // Cpp members
    readonly property string stop_file_cmd_tn: data_model.data_source.swamp_status.ngc_status.stopFileCmd.topic_name
    readonly property string start_file_cmd_tn: data_model.data_source.swamp_status.ngc_status.startFileCmd.topic_name
    readonly property string resume_file_cmd_tn: data_model.data_source.swamp_status.ngc_status.resumeFileCmd.topic_name

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
            height: icon_row.implicitHeight + 20
            width: icon_row.implicitWidth + 20
            Layout.alignment: Qt.AlignTop
            radius: 5.0
            color: "aliceblue"
            border {
                color: "black"
                width: 2
            }
            RowLayout{
                id: icon_row
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                //anchors.leftMargin: 50
                spacing: 15

                ColumnLayout{
                    Layout.alignment: Qt.AlignHCenter
                    Image {
                        id: play_icon
                        visible: true
                        source: "../../Images/play-button_resized.png"
                        opacity: isPLaying? 0.2: isStopped ? 1 : 1
                        enabled: isPLaying? false : isStopped? true : true
                        property bool play : false
                        MouseArea{
                            id: add_ma
                            anchors.fill: parent
                            onClicked: {
                                publish_topic(start_file_cmd_tn, 1)
                                isPLaying = true
                            }
                        }
                    }
                    Text {
                        id: start_text
                        font.bold: true
                        Layout.leftMargin: 4
                        text: qsTr("START")
                    }
                }
                ColumnLayout{
                    Layout.alignment: Qt.AlignHCenter
                    Image {
                        id: pause_icon
                        visible: true
                        source: "../../Images/pause_resized.png"
                        opacity: isPLaying ? 1 : 0.2
                        enabled: isPLaying? true : false
                        MouseArea{
                            id: download_ma
                            anchors.fill: parent
                            onClicked: {
                                publish_topic(stop_file_cmd_tn, 1)
                                isPLaying = false
                                isStopped = true
                            }
                        }

                    }
                    Text {
                        id: pause_text
                        font.bold: true
                        Layout.leftMargin: 4
                        text: qsTr("PAUSE")
                    }
                }
                ColumnLayout{
                    Layout.alignment: Qt.AlignHCenter
                    Image {
                        id: resume_icon
                        visible: true
                        opacity: isPLaying? 0.2 : isStopped? 1 : 0.2
                        enabled: isPLaying? false : isStopped? true : false
                        source: "../../Images/resume.png"
                        MouseArea{
                            id: reset_ma
                            anchors.fill: parent
                            onClicked: {
                                publish_topic(resume_file_cmd_tn, 1)
                                isPLaying = true
                                isStopped = false
                            }
                        }
                    }
                    Text {
                        id: resume_text
                        font.bold: true
                        Layout.leftMargin: 3
                        text: qsTr("RESUME")
                    }
                }
            }
        }
    }
}
