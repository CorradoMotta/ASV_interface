import QtQuick 2.0
import com.cnr.property 1.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import "../BasicItems"
import "../Panels"

BasicMinionPanelContainer{
    id : root
    implicitHeight: Math.max(cmd_row.implicitHeight , cmd_row_2.implicitHeight) + title_height + 20
    implicitWidth: cmd_row.implicitWidth + cmd_row_2.implicitWidth + bar.width + 200 // TODO WHY SO MUCH
    title: "NGC"
    color: "whitesmoke"

    property var prefix: data_model.data_source.swamp_status.ngc_status
    readonly property string ngcEnableTn: prefix.ngcEnable.topic_name
    readonly property string rpmAlphaTn: prefix.rpmAlpha.topic_name
    readonly property string forceTorqueTn: prefix.forceTorque.topic_name
    readonly property var publish_topic: data_model.data_source.publishMessage

    //border.color: "transparent"
    RowLayout{
        id: cmd_row
        spacing: 2
        //width: parent.width/2
        anchors{
            topMargin: 5
            //fill: parent
            top: parent.top; left: parent.left; bottom: parent.bottom; right: bar.right
            rightMargin: 10
            leftMargin: 10
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 10
            spacing: 15
        BasicSwitch{
            switch_text: "NGC_ENABLE"
            // TODO
            onSwitch_is_activeChanged: switch_is_active? root.publish_topic(root.ngcEnableTn, 1)
                                                      : root.publish_topic(root.ngcEnableTn, 0)
        }
        ThrustMappingPanel{
            id: rpm_alpha
            Layout.fillWidth: true
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignTop
            title: "RPM_ALPHA"
            slider1_text: "NREF   "; slider1_from: 0; slider1_to: 1800; slider1_mask: "0000"
            slider2_text: "DNREF  "; slider2_from: -900; slider2_to: 900; slider2_mask: "#000"
            slider3_text: "ALFAREF"; slider3_from: -180; slider3_to: 180; slider3_mask: "#000"
            clip: true
            onValueChanged: root.publish_topic(root.rpmAlphaTn, value) //console.log(value)
        }
        ThrustMappingPanel{
            id: force_torque
            Layout.fillWidth: true
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignTop
            title: "FORCE_TORQUE"
            slider1_text: "X"; slider1_from: 0; slider1_to: 1000; slider1_mask: "0000"
            slider2_text: "Y"; slider2_from: 0; slider2_to: 1000; slider2_mask: "0000"
            slider3_text: "N"; slider3_from: 0; slider3_to: 1000; slider3_mask: "0000"
            clip: true
            onValueChanged: root.publish_topic(root.forceTorqueTn, value)
        }
        ControlPanel{
            id: control_panel
            Layout.fillWidth: true
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignTop
            clip: true
            onValueChanged: console.log(value)
        }
        }

    }
    Rectangle {
        id: bar
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: title_height + 20
            bottomMargin: 30
            bottom: parent.bottom
        }
        width: 2
        color: "gray"
    }
    RowLayout{
        id: cmd_row_2
        spacing: 2
        //width: parent.width/2
        anchors{
            topMargin: 20
            leftMargin: 10
            top: parent.top; right: parent.right; bottom: parent.bottom; left: bar.right
            rightMargin: 10
        }
    }
}

