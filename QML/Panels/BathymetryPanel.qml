import QtQuick 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import "../BasicItems"

Rectangle {
    Layout.preferredHeight: slider_depth.implicitHeight + 10
    radius: 5.0
    property alias max_depth : slider_depth.max_value //slider_value_id.text
    property alias min_depth: slider_depth.min_value
    border {
        color: "black"
        width: 2
    }
    BasicRangeSlider{
        id: slider_depth
        slider_text: "Depth range"
        anchors.fill: parent
        anchors.leftMargin: 10
    }
}
