import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"
import QtQuick.Controls 2.15

Rectangle{
    id : rpm_panel
    Layout.preferredHeight: cl.implicitHeight
    color: "transparent"
    ColumnLayout {
        id: cl
        spacing: 10
        //anchors.fill: parent
        RowLayout{
            Layout.alignment: Qt.AlignTop
            spacing: 100
            Text {
                id: slider_text_id
                Layout.alignment: Qt.AlignLeft
                text: "RPM_ALPHA"
                font.family: "Helvetica"
                font.pointSize: 14
            }
            Button {
                id: connect_button
                Layout.alignment: Qt.AlignRight
                width: 200
                Layout.rightMargin: 10
                //onClicked: data_model.data_source.setConnection()
                contentItem: Text {
                    text: "SEND"
                    font.family: "Helvetica"
                    font.pointSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
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

                BasicSlider {
                    id: fu
                    Layout.fillWidth: true
                    slider_text: "NREF     "
                    mask_input: "#000"
                    //onValueChanged:  data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.fu.ref.topic_name, value)
                }
                BasicSlider {

                    id: fv
                    Layout.fillWidth: true
                    slider_text: "DNREF    "
                    mask_input: "#000"
                    //onValueChanged: data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.fv.ref.topic_name, value)
                }
                BasicSlider {

                    id: tr
                    Layout.fillWidth: true
                    slider_from: -180
                    slider_to: 180
                    slider_text: "ALPHAREF"
                    mask_input: "#000"
                    // onValueChanged: {
                    //     rotation_value = value
                    //     data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.tr.ref.topic_name,value)
                    // }
                }
            }
        }
    }
}
