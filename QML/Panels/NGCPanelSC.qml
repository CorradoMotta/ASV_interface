/*************************************************************************
 *
 * This panel allows short access to NGC elements in the main view.
 * It can be customized by adding more sliders to it from the NGC.
 * Right now only two slider are present, one for X and one for gamma.
 * Also a button is present to invert the line for line following.
 *
 * Author: Corrado Motta
 * Date: 08/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"
import QtQuick.Controls 2.15

Rectangle{
    id : rpm_panel

    // properties
    Layout.preferredHeight: cl.implicitHeight
    Layout.preferredWidth: cl.implicitWidth
    implicitWidth: cl.implicitWidth
    color: "transparent"

    // custom properties
    property int slider_width : 260

    // alias
    property alias title : text_id.text
    property alias slider1_text : x.slider_text
    property alias slider1_from : x.slider_from
    property alias slider1_to : x.slider_to
    property alias slider1_mask : x.mask_input
    property alias slider1_ref : x.ref_value
    property alias slider2_text : gamma.slider_text
    property alias slider2_from : gamma.slider_from
    property alias slider2_to : gamma.slider_to
    property alias slider2_mask : gamma.mask_input
    property alias slider2_ref : gamma.ref_value
    property alias panel_color: force_slider.color
    property alias xValue : x.value
    property alias gammaValue : gamma.value
    readonly property string setSegmentToggle: data_model.data_source.swamp_status.ngc.ngcCmd.setSegmentToggle.topic_name


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
        }
        Rectangle {
            id: force_slider
            height: force_slider_panel.implicitHeight + 40
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
                BasicButton{
                    // todo move these elements outside
                    Layout.alignment: Qt.AlignLeft
                    Layout.topMargin: 4
                    text_on_button: "INVERT LF"
                    button_width: 100
                    onClicked: publish_topic(setSegmentToggle, 1)
                }
                BasicSliderWithRefAndAct {
                    id: x
                    Layout.fillWidth: true
                    slider_width : rpm_panel.slider_width
                    slider_from: 0
                    slider_to: 100
                }

                BasicSliderWithRefAndAct {
                    id: gamma
                    Layout.fillWidth: true
                    slider_width : rpm_panel.slider_width
                    slider_from: 0
                    slider_to: 100
                    step_size: 1
                }
            }
        }
    }
}
