import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"
import QtQuick.Controls 2.15

Rectangle{
    id : rpm_panel

    property alias title : text_id.text
    property alias slider1_text : x.slider_text
    property alias slider1_from : x.slider_from
    property alias slider1_to : x.slider_to
    property alias slider1_mask : x.mask_input
    property alias slider1_ref : x.ref_value

    property int slider_width : 260
    property alias panel_color: force_slider.color
    property alias xValue : x.value


    Layout.preferredHeight: cl.implicitHeight
    color: "transparent"

    ColumnLayout {
        id: cl
        spacing: 0
        anchors.fill: parent

        RowLayout{
            Layout.alignment: Qt.AlignTop
            Layout.fillWidth: true
            //spacing: 100

            Text {
                id: text_id
                Layout.alignment: Qt.AlignLeft
                Layout.leftMargin: 4
                //text: "RPM_ALPHA"
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
            height: x.implicitHeight + 50
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

                BasicSliderWithRefAndAct {
                    id: x
                    Layout.fillWidth: true
                    slider_width : rpm_panel.slider_width
                    //slider_text: "NREF     "
                    slider_from: 0
                    slider_to: 100
                }
            }
        }
    }
}
