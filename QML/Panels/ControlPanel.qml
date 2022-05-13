import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"
import QtQuick.Controls 2.15

Rectangle{
    id : control_panel

    property string value : ""
    property var prefix: data_model.data_source.swamp_status.ngc_status
    readonly property string surgeTn: prefix.surge.topic_name
    readonly property string swayTn: prefix.sway.topic_name
    readonly property string yawTn: prefix.yaw.topic_name
    readonly property string headingTn: prefix.heading.topic_name
    readonly property var publish_topic: data_model.data_source.publishMessage

    Layout.preferredHeight: cl.implicitHeight
    color: "transparent"

    ColumnLayout {
        id: cl
        spacing: 4
        anchors.fill: parent

        RowLayout{
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true

            Text {
                id: text_id
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 4
                text: "CONTROL"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true

            }
            Rectangle{
                Layout.fillWidth: true
            }

            //            Button {
            //                id: control
            //                Layout.alignment: Qt.AlignRight
            //                width: 200
            //                onClicked: value = surge.value + " " + sway.value + " " + yaw.value + " " + heading.value
            //                //Layout.rightMargin: 10
            //                //onClicked: data_model.data_source.setConnection()
            //                contentItem: Text {
            //                    id: testo
            //                    text: "SEND"
            //                    font.family: "Helvetica"
            //                    font.pointSize: 14
            //                    anchors.horizontalCenter: background_b.horizontalCenter
            //                    //verticalAlignment: background_b.AlignVCenter
            //                }
            //                background: Rectangle{
            //                    id: background_b
            //                    height: testo.implicitHeight + 10
            //                    width: testo.implicitWidth + 10
            //                    color: control.down? "peachpuff" : "papayawhip"
            //                    border.width: 1
            //                    border.color: "black"
            //                    radius: 4
            //                }
            //            }
        }
        Rectangle {
            id: force_slider
            height: (surge.implicitHeight * 4) + 50
            width: force_slider_panel.implicitWidth + 50
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            radius: 5.0
            color: "aliceblue"
            border {
                color: "black"
                width: 2
            }

            ColumnLayout {
                id: force_slider_panel
                anchors.fill: parent
                anchors.leftMargin: 10
                spacing: 2

                BasicSlider {
                    id: surge
                    Layout.fillWidth: true
                    slider_text: "SURGE   "
                    slider_from: 0
                    slider_to: 100
                    mask_input: "#000"
                    onValueChanged: control_panel.publish_topic(control_panel.surgeTn, value)
                }
                BasicSlider {

                    id: sway
                    Layout.fillWidth: true
                    slider_text: "SWAY    "
                    slider_from: 0
                    slider_to: 100
                    mask_input: "#000"
                    onValueChanged: control_panel.publish_topic(control_panel.swayTn, value)
                }
                BasicSlider {

                    id: yaw
                    Layout.fillWidth: true
                    slider_from: 0
                    slider_to: 100
                    slider_text: "YAW      "
                    mask_input: "#000"
                     onValueChanged: control_panel.publish_topic(control_panel.yawTn, value)
                    //     rotation_value = value
                    //     data_model.data_source.publish_topicMessage(data_model.data_source.swamp_status.ngc_status.tr.ref.topic_name,value)
                    // }
                }
                BasicSlider{
                    id: heading
                    Layout.fillWidth: true
                    slider_from: 0
                    slider_to: 100
                    slider_text: "HEADING"
                    mask_input: "#000"
                    onValueChanged: control_panel.publish_topic(control_panel.headingTn, value)
                }
            }
        }
    }
}
