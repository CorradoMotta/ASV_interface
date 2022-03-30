import QtQuick 2.0
import QtQuick.Layouts 1.15

Rectangle {
    id: force_slider
    Layout.preferredHeight: (fu.implicitHeight * 3) + 50
    radius: 5.0
    property int rotation_value: 0
    property double timestamp: 0

    border {
        color: "black"
        width: 2
    }

    ColumnLayout {
        id: force_slider_panel

        anchors.fill: parent
        anchors.leftMargin: 20
        //anchors.topMargin: 15
        spacing: 2

        BasicSlider {

            id: fu
            Layout.fillWidth: true
            slider_text: "Fu"
            onValueChanged:  data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.fu.ref.topic_name, value)
        }
        BasicSlider {

            id: fv
            Layout.fillWidth: true
            slider_text: "Fv"
            onValueChanged: data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.fv.ref.topic_name, value)
        }
        BasicSlider {

            id: tr
            Layout.fillWidth: true
            slider_from: -180
            slider_to: 180
            slider_text: "Tr"
            onValueChanged: {
                rotation_value = value
                data_model.data_source.publishMessage(data_model.data_source.swamp_status.ngc_status.tr.ref.topic_name,value)
            }
        }
    }
}
