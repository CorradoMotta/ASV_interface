import QtQuick 2.0

Rectangle{

    color: "transparent"
    implicitHeight: angle_text.implicitHeight + rpm_text.implicitHeight + 3
    implicitWidth: 60
    property alias angle_text: angle_text.text
    property alias rpm_text: rpm_text.text
    property bool align_right

    Text{
        id: angle_text
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        font.family: "Helvetica"
        font.pixelSize: 15
        color: "blue"
        horizontalAlignment : align_right? Text.AlignRight : Text.AlignLeft
    }
    Text{
        id: rpm_text
        anchors.top: angle_text.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 3
        font.family: "Helvetica"
        font.pixelSize: 15
        color: "red"
        horizontalAlignment : align_right? Text.AlignRight : Text.AlignLeft
    }
}
