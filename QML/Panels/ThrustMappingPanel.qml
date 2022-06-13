import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"
import QtQuick.Controls 2.15

Rectangle{
    id : rpm_panel

    property string value : ""
    property alias xvalue : fu.value
    property alias yvalue: fv.value
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
    property alias slider1_mask : fu.mask_input
    property alias slider2_mask : fv.mask_input
    property alias slider3_mask : tr.mask_input
    property alias slider1_ref : fu.ref_value
    property alias slider2_ref : fv.ref_value
    property alias slider3_ref : tr.ref_value
    property int slider_width : 260
    property alias panel_color: force_slider.color
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

//            Button {
//                id: control
//                Layout.alignment: Qt.AlignRight
//                width: 200
//                onClicked: value = fu.value + " " + fv.value + " " + tr.value
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
            height: (fu.implicitHeight * 3) + 50
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
                    id: fu
                    Layout.fillWidth: true
                    slider_width : rpm_panel.slider_width
                    //slider_text: "NREF     "
                    slider_from: 0
                    slider_to: 100
                    mask_input: "#000"
                    onValueChanged:  rpm_panel.value = fu.value + " " + fv.value + " " + tr.value
                }
                BasicSliderWithRef {

                    id: fv
                    Layout.fillWidth: true
                    slider_width : rpm_panel.slider_width
                    //slider_text: "DNREF    "
                    slider_from: 0
                    slider_to: 100
                    mask_input: "#000"
                    onValueChanged: rpm_panel.value = fu.value + " " + fv.value + " " + tr.value
                }
                BasicSliderWithRef {

                    id: tr
                    Layout.fillWidth: true
                    slider_width : rpm_panel.slider_width
                    slider_from: 0
                    slider_to: 100
                    //slider_text: "ALPHAREF"
                    mask_input: "#000"
                    onValueChanged: rpm_panel.value = fu.value + " " + fv.value + " " + tr.value
                    // onValueChanged: {
                    //     rotation_value = value
                    //     data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.tr.ref.topic_name,value)
                    // }
                }
            }
        }
    }
}
