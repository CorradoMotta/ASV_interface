/*************************************************************************
 *
 * Main qml view. This is the main view and contains the navigation map
 * and a quick access panel.
 *
 *************************************************************************/

import QtQuick 2.15
import QtQuick.Window 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15

import "BasicItems"
import "Maps"
import "Panels"
import "Views"

ApplicationWindow {
    id: root

    minimumWidth: minion_view.minimum_width + main_layout.implicitWidth + 20
    minimumHeight: minion_view.minimum_height + menu_bar_id.implicitHeight + 116
    height: minimumHeight
    width: minimumWidth
    visible: true
    title: qsTr("Swamp interface")
    property double pi_value: 3.1415926535
    property bool connected: false
    property bool startUp: true
    property double timestamp: 0

    // TODO THIS IS DUPLICATED!
    property var prefix: data_model.data_source.swamp_status.ngc_status
    readonly property real nRef : prefix.asvRefnRef.value
    readonly property real dnRef : prefix.asvRefdnRef.value
    readonly property real alphaRef : prefix.asvRefalphaRef.value
    readonly property real xRef : prefix.asvRefXref.value
    readonly property real yRef : prefix.asvRefYref.value
    readonly property real nNRef : prefix.asvRefNref.value
    readonly property real asvRefXhat : prefix.asvRefXhat.value
    readonly property real asvRefYhat : prefix.asvRefYhat.value
    readonly property real asvRefNhat : prefix.asvRefNhat.value
    readonly property string rpmAlphaTn: prefix.rpmAlpha.topic_name
    readonly property string forceTorqueTn: prefix.forceTorque.topic_name
    readonly property var publish_topic: data_model.data_source.publishMessage

    function messagePrompt(prompt_text){
        message_prompt.message = prompt_text
        message_prompt_anim.running = true
    }

    function convertToRadiant(value) {
        var value_in_radiant = value * 180 / pi_value
        return value_in_radiant
    }

    onStartUpChanged:{
        navigation_map.zoomLevel = 18
        navigation_map.set_center(
                    QtPositioning.coordinate(navigation_map.lat.value, navigation_map.lon.value))
    }

    // button used to switch stack view. It is immediately available when controller is connected.
    Connections {
        target: QJoysticks
        function onButtonChanged(js, button, pressed) {
            if (button === 0 && pressed === true){
                if(stack_button.open_minion){
                    stack_button.push_view()
                }else{
                    stack_button.pop_view()
                }
            }
        }
    }

    menuBar: CustomMenuBar {
        id: menu_bar_id
    }

    // instantiate the minion view
    Minions{
        id: minion_view
    }

    RowLayout {
        id: main_layout
        anchors.fill: parent
        spacing: 10

        StackView {
            id: stack
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            Layout.topMargin: 10
            initialItem: NavigationMap{
                id: navigation_map
            }
        }

        BasicStackButton{
            id: stack_button
            Layout.topMargin: 10
            Layout.fillHeight: true
            Layout.preferredWidth: 30
        }

        Rectangle {
            id: control_panel
            Layout.alignment: Qt.AlignTop
            Layout.preferredWidth: 460
            Layout.preferredHeight: 800
            Layout.topMargin: 10
            ColumnLayout {
                anchors.fill: parent
                spacing: 10
                EnginePanel {
                    id: engine_panel
                    //color: "aliceblue"
                    Layout.fillWidth: true
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignTop
                    // TODO i cannot access enum?
                    enabled: data_model.data_source.is_connected
                    opacity: data_model.data_source.is_connected? 1 : 0.3
                    //enabled: true
                }
                HomingPanel{
                    id: homing_panel
                    //color: "aliceblue"
                    Layout.fillWidth: true
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignTop
                    enabled: data_model.data_source.is_connected
                    opacity: data_model.data_source.is_connected? 1 : 0.3
                }
                ThrustMappingPanel{
                    id: rpm_alpha
                    Layout.fillWidth: true
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignTop
                    slider_width: 200
                    title: "RPM_ALPHA"
                    slider1_text: "N"; slider1_from: 0; slider1_to: 1800;      slider1_ref: root.nRef   //slider1_mask: "0000";
                    slider2_text: "D"; slider2_from: -900; slider2_to: 900;  slider2_ref: root.dnRef    //slider2_mask: "#000";
                    slider3_text: "Α"; slider3_from: -180; slider3_to: 180;  slider3_ref: root.alphaRef //slider3_mask: "#000";
                    clip: true
                    panel_color: "white"
                    enabled: data_model.data_source.is_connected
                    opacity: data_model.data_source.is_connected? 1 : 0.3
                    onValueChanged: root.publish_topic(root.rpmAlphaTn, value) //console.log(value)
                }
                ThrustMappingPanel{
                    id: force_torque
                    Layout.fillWidth: true
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignTop
                    slider_width: 200
                    title: "FORCE_TORQUE"
                    slider1_text: "X"; slider1_from: -50; slider1_to: 50;  slider1_ref: root.xRef  ; slider1_act: root.asvRefXhat //slider1_mask: "#00";
                    slider2_text: "Y"; slider2_from: -50; slider2_to: 50;  slider2_ref: root.yRef  ; slider2_act: root.asvRefYhat //slider2_mask: "#00";
                    slider3_text: "N"; slider3_from: -50; slider3_to: 50;  slider3_ref: root.nNRef ; slider3_act: root.asvRefNhat //slider3_mask: "#00";
                    clip: true
                    panel_color: "white"
                    enabled: data_model.data_source.is_connected
                    opacity: data_model.data_source.is_connected? 1 : 0.3
                    onValueChanged: root.publish_topic(root.forceTorqueTn, value)
                }
                BathymetryPanel {
                    id: bathymetry_panel
                    Layout.fillWidth: true
                    Layout.rightMargin: 10
                    Layout.alignment: Qt.AlignTop
                    //opacity: data_model.data_source.is_connected ? 1 : 0.3
                    //enabled: data_model.data_source.is_connected
                    opacity: 0.3
                    enabled: false
                }
                Button {
                    id: connect_button
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    Layout.rightMargin: 10
                    onClicked: data_model.data_source.setConnection()
                    contentItem: Text {
                        text: data_model.data_source.is_connected ? "disconnect" : "connect"
                        font.family: "Helvetica"
                        font.pointSize: 18
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
    }
    Rectangle{
        id: message_prompt
        property alias message : text_prompt.text
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 100
        width: Math.max(1100, text_prompt.implicitWidth + 200)
        height: text_prompt.implicitHeight + 10
        radius: 20
        color: "cornflowerblue"
        //visible: false
        opacity: 0
        //border.color: "black"
        Text{
            id: text_prompt
            anchors.horizontalCenter: message_prompt.horizontalCenter
            anchors.verticalCenter: message_prompt.verticalCenter
            font.family: "Helvetica"
            font.pointSize: 14
        }
    }
    SequentialAnimation{
        id: message_prompt_anim
        NumberAnimation {
            target: message_prompt
            property: "opacity"
            from: 0.0; to: 1.0
            duration: 1000
            //running: true
        }
        PauseAnimation{
            duration: 2000
        }

        NumberAnimation {
            id: message_prompt_anim_disappear
            target: message_prompt
            property: "opacity"
            from: 1.0; to: 0
            duration: 600
            //running: true
        }
    }
}
