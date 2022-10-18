/*************************************************************************
 *
 * Panel for thrust mapping (raw mode). This panel is composed by 3 fixed
 * sliders of BasicSliderWithRefAndAct type where each value of each
 * slider can be customized. It also shows a rectangle with a text label
 * on top.
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
    property string value : ""
    property int slider_width : 260

    // alias values
    property alias xvalue : fu.value
    property alias yvalue: fv.value
    property alias zvalue: tr.value
    property alias title : text_id.text
    property alias slider1_text : fu.slider_text
    property alias slider2_text : fv.slider_text
    property alias slider3_text : tr.slider_text
    property alias slider1_from : fu.slider_from
    property alias slider2_from : fv.slider_from
    property alias slider3_from : tr.slider_from
    property alias slider1_to : fu.slider_to
    property alias slider2_to : fv.slider_to
    property alias slider3_to : tr.slider_to
    property alias slider1_ref : fu.ref_value
    property alias slider2_ref : fv.ref_value
    property alias slider3_ref : tr.ref_value
    property alias slider1_act : fu.act_value
    property alias slider2_act : fv.act_value
    property alias slider3_act : tr.act_value
    property alias panel_color: force_slider.color

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
            height: (fu.implicitHeight * 3) + 50
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
                spacing: 2

                BasicSliderWithRefAndAct {
                    id: fu
                    Layout.fillWidth: true
                    slider_width : rpm_panel.slider_width
                    slider_from: 0
                    slider_to: 100
                    step_size: 1
                    onValueChanged: {
                        controlValue = fu.value
                        rpm_panel.value = fu.value + " " + fv.value + " " + tr.value
                    }
                }

                BasicSliderWithRefAndAct {
                    id: fv
                    Layout.fillWidth: true
                    slider_width : rpm_panel.slider_width
                    slider_from: 0
                    slider_to: 100
                    step_size: 1
                    onValueChanged: rpm_panel.value = fu.value + " " + fv.value + " " + tr.value
                }
                BasicSliderWithRefAndAct {
                    id: tr
                    Layout.fillWidth: true
                    slider_width : rpm_panel.slider_width
                    slider_from: 0
                    slider_to: 100
                    step_size: 1
                    onValueChanged:  {
                        controlValue = tr.value
                        rpm_panel.value = fu.value + " " + fv.value + " " + tr.value
                    }
                }
            }
        }
    }
}
