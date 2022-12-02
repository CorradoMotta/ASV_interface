/*************************************************************************
 *
 * Panel elements to control surge, sway, yaw and heading of the vehicle.
 * Each element is composed by a BasicSliderWithRef, the text of the slider
 * is clickable to send the data individually to the vehicle. This is the
 * version to fit the main view
 *
 * Author: Corrado Motta
 * Date: 06/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"
import QtQuick.Controls 2.15

Rectangle{
    id : control_panel

    // properties
    implicitWidth : cl.implicitWidth
    Layout.preferredHeight: cl.implicitHeight + 40
    height: cl.implicitHeight + 40
    color: "transparent"

    // custom properties
    property int slider_width : 200
    property string value : ""
    property var prefix: data_model.data_source.swamp_status.ngc.ngc_status
    property var prefix_tn: data_model.data_source.swamp_status.ngc.ngcCmd

    // Cpp members
    readonly property string surgeTn: prefix_tn.surge.act.topic_name
    readonly property string swayTn: prefix_tn.sway.act.topic_name
    readonly property string yawTn: prefix_tn.yaw.act.topic_name
    readonly property string headingTn: prefix_tn.heading.act.topic_name
    readonly property var publish_topic: data_model.data_source.publishMessage
    readonly property real surgeRef : prefix_tn.surge.ref.value
    readonly property real swayRef : prefix_tn.sway.ref.value
    readonly property real yawRef : prefix_tn.yaw.ref.value
    readonly property real headingRef: prefix_tn.heading.ref.value
    // to do duplicates
    readonly property real xRef : prefix.asvRefXref.value
    readonly property real yRef : prefix.asvRefYref.value

    // alias
    property alias xValue : x.value

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
            height: (force_slider_panel.implicitHeight ) + 50
            implicitHeight: (force_slider_panel.implicitHeight ) + 50
            width: force_slider_panel.implicitWidth
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
                spacing: 6

                BasicSliderWithRef {
                    id: x
                    Layout.fillWidth: true
                    button_enabled : false
                    slider_width : 200
                    button_width: 70
                    slider_text: "X"
                    slider_from: -50
                    slider_to: 50
                    ref_value: xRef
                }
                BasicSliderWithRef {

                    id: y
                    Layout.fillWidth: true
                    button_enabled : false
                    slider_width : 200
                    button_width: 70
                    slider_text: "Y"
                    slider_from: -50
                    slider_to: 50
                    ref_value: yRef
                }

                BasicSliderWithRef {
                    id: surge
                    Layout.fillWidth: true
                    slider_text: "SURGE"
                    slider_from: -100
                    slider_to: 100
                    slider_width : 200
                    button_width: 70
                    ref_value: surgeRef
                    onValueChanged: control_panel.publish_topic(control_panel.surgeTn, value)
                    onClickedChanged: clicked ? control_panel.publish_topic(control_panel.surgeTn, value) : ""
                }
                BasicSliderWithRef {

                    id: sway
                    Layout.fillWidth: true
                    slider_text: "SWAY"
                    slider_from: -100
                    slider_to: 100
                    slider_width :200
                    button_width: 70
                    ref_value: swayRef
                    onValueChanged: control_panel.publish_topic(control_panel.swayTn, value)
                    onClickedChanged: clicked ? control_panel.publish_topic(control_panel.swayTn, value) : ""
                }
                BasicSliderWithRef {

                    id: yaw
                    Layout.fillWidth: true
                    slider_from: -180
                    slider_to: 180
                    slider_width : 200
                    button_width: 70
                    step_size:1
                    slider_text: "YAW"
                    ref_value: yawRef
                    onValueChanged: control_panel.publish_topic(control_panel.yawTn, value + " " + x.value + " " + y.value)
                    onClickedChanged: clicked ? control_panel.publish_topic(control_panel.yawTn, value + " " + x.value + " " + y.value) : ""
                }
                BasicSliderWithRef{
                    id: heading
                    Layout.fillWidth: true
                    slider_from: -180
                    slider_to: 180
                    slider_width : 200
                    button_width: 70
                    step_size:1
                    slider_text: "HEAD"
                    ref_value: headingRef
                    onValueChanged: control_panel.publish_topic(control_panel.headingTn, value + " " + x.value + " " + y.value)
                    onClickedChanged: clicked ? control_panel.publish_topic(control_panel.headingTn, value + " " + x.value + " " + y.value) : ""
                }
            }
        }
    }
}
