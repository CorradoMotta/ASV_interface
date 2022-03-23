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
            onValueChanged: publish_force_data(value, timestamp, "fu")
        }
        BasicSlider {

            id: fv
            Layout.fillWidth: true
            slider_text: "Fv"
            onValueChanged: publish_force_data(value, timestamp, "fv")
        }
        BasicSlider {

            id: tr
            Layout.fillWidth: true
            slider_from: -180
            slider_to: 180
            slider_text: "Tr"
            onValueChanged: {
                rotation_value = value
                publish_force_data(value, timestamp, "tr")
            }
        }
    }

    function publish_force_data(value, timestamp, ID) {

        var topic = "CNR-INM/swamp/NGC/force/" + ID + "/manual"
        var str_value = value + ".0 " + timestamp + " 1"
        mqtt_client.publishMessage(topic, str_value)
    }
}
