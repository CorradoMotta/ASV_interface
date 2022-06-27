import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"
import QtQuick.Controls 2.15

Rectangle{
    id : control_panel

    property string value : ""
    property var prefix: data_model.data_source.swamp_status.ngc_status
    readonly property string surgeTn: prefix.surge.act.topic_name
    readonly property string swayTn: prefix.sway.act.topic_name
    readonly property string yawTn: prefix.yaw.act.topic_name
    readonly property string headingTn: prefix.heading.act.topic_name
    readonly property var publish_topic: data_model.data_source.publishMessage

    readonly property real surgeRef : prefix.surge.ref.value
    readonly property real swayRef : prefix.sway.ref.value
    readonly property real yawRef : prefix.yaw.ref.value
    readonly property real headingRef : prefix.heading.ref.value
    property alias xValue : x.value

    Layout.preferredHeight: cl.implicitHeight
    height: cl.implicitHeight
    color: "transparent"

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
                text: "CONTROL"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true

            }
            Rectangle{
                Layout.fillWidth: true
            }
        }
        Rectangle {
            id: force_slider
            height: (surge.implicitHeight * 6) + 50
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

                BasicSliderWithRef {
                    id: x
                    Layout.fillWidth: true
                    button_enabled : false
                    slider_width : 260
                    slider_text: "X         "
                    slider_from: -50
                    slider_to: 50
                    ref_value: ngc_root.xRef
                   // mask_input: "#00"
                    //onValueChanged:  rpm_panel.value = fu.value + " " + fv.value + " " + tr.value
                }
                BasicSliderWithRef {

                    id: y
                    Layout.fillWidth: true
                    button_enabled : false
                    slider_width : 260
                    slider_text: "Y         "
                    slider_from: -50
                    slider_to: 50
                    //mask_input: "#00"
                    ref_value: ngc_root.yRef
                    //onValueChanged: rpm_panel.value = fu.value + " " + fv.value + " " + tr.value
                }

                BasicSliderWithRef {
                    id: surge
                    Layout.fillWidth: true
                    slider_text: "SURGE   "
                    slider_from: -100
                    slider_to: 100
                    slider_width : 260
                    //mask_input: "#000"
                    ref_value: surgeRef
                    onValueChanged: control_panel.publish_topic(control_panel.surgeTn, value)
                    onClickedChanged: clicked ? control_panel.publish_topic(control_panel.surgeTn, value) : ""
                }
                BasicSliderWithRef {

                    id: sway
                    Layout.fillWidth: true
                    slider_text: "SWAY    "
                    slider_from: -100
                    slider_to: 100
                    slider_width : 260
                   // mask_input: "#000"
                    ref_value: swayRef
                    onValueChanged: control_panel.publish_topic(control_panel.swayTn, value)
                    onClickedChanged: clicked ? control_panel.publish_topic(control_panel.swayTn, value) : ""
                }
                BasicSliderWithRef {

                    id: yaw
                    Layout.fillWidth: true
                    slider_from: -180
                    slider_to: 180
                    slider_width : 260
                    slider_text: "YAW      "
                   // mask_input: "#000"
                    ref_value: yawRef
                    onValueChanged: control_panel.publish_topic(control_panel.yawTn, value + " " + x.value + " " + y.value)
                    onClickedChanged: clicked ? control_panel.publish_topic(control_panel.yawTn, value + " " + x.value + " " + y.value) : ""
                    //     rotation_value = value
                    //     data_model.data_source.publish_topicMessage(data_model.data_source.swamp_status.ngc_status.tr.ref.topic_name,value)
                    // }
                }
                BasicSliderWithRef{
                    id: heading
                    Layout.fillWidth: true
                    slider_from: -180
                    slider_to: 180
                    slider_width : 260
                    slider_text: "HEADING"
                   // mask_input: "#000"
                    ref_value: headingRef
                    onValueChanged: control_panel.publish_topic(control_panel.headingTn, value + " " + x.value + " " + y.value)
                    onClickedChanged: clicked ? control_panel.publish_topic(control_panel.headingTn, value + " " + x.value + " " + y.value) : ""
                }
            }
        }
    }
}
