/*************************************************************************
 *
 * Main qml view. This is the main view and contains the navigation map
 * and a quick access panel.
 *
 * Author: Corrado Motta
 * Date: 10/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../BasicItems"
import "../Maps"
import "../Panels"
import "../Views"

Item {
    id: root

    // custom properties
    property bool isMainView: true
    property int myHeight: Math.max(minion_view.minimum_height, main_layout.implicitHeight) + 60
    property int myWidth: minion_view.minimum_width + main_layout.implicitWidth + 20
    property var prefix: data_model.data_source.swamp_status.ngc.ngc_status
    property var prefix_tn: data_model.data_source.swamp_status.ngc.ngcCmd

    // alias TODO make signals
    property alias xValue : ngc_auto.xValue
    property alias gammaValue : ngc_auto.gammaValue

    // Cpp model
    readonly property real nRef : prefix.asvRefnRef.value
    readonly property real dnRef : prefix.asvRefdnRef.value
    readonly property real alphaRef : prefix.asvRefalphaRef.value
    readonly property real xRef : prefix.asvRefXref.value
    readonly property real yRef : prefix.asvRefYref.value
    readonly property real nNRef : prefix.asvRefNref.value
    readonly property real gammaRef : prefix.asvRefgammaLref.value
    readonly property real asvRefXhat : prefix.asvRefXhat.value
    readonly property real asvRefYhat : prefix.asvRefYhat.value
    readonly property real asvRefNhat : prefix.asvRefNhat.value
    readonly property string rpmAlphaTn: prefix_tn.rpmAlpha.topic_name
    readonly property string forceTorqueTn: prefix_tn.forceTorque.topic_name
    readonly property var publish_topic: data_model.data_source.publishMessage
    readonly property int maxRPMSpeed: data_model.data_source.swamp_status.conf.maxRPMSpeed
    readonly property bool hciIsConnected: data_model.data_source.is_connected
    readonly property int tabLen: 1

    // for controller
    property real x_curr_value : 0
    property real y_curr_value : 0
    property real x_index : 0
    property real y_index : 1
    property real pi : Math.PI
    property real nmax : data_model.data_source.swamp_status.conf.maxControllerSpeed
    property real rho_thr: 0.2
    property real alfa_cos : 0
    property bool startUp: true
    property int currentJoystick: 0
    property bool connected: false
    property double timestamp: 0

    onStartUpChanged:{
        navigation_map.zoomLevel = 18
        navigation_map.set_center(
                    QtPositioning.coordinate(navigation_map.lat.value, navigation_map.lon.value))
    }


    // for controller. Timer gets automatically active when the controller is connected
    Timer {
        id: timer

        interval: 100;
        repeat: true
        running: QJoysticks.count > 0? true : false

        onTriggered: {
            var alfa = Math.atan2(x_curr_value,y_curr_value)

            // calculate cos alfa for each situation
            if(alfa >= (-pi/4) && alfa < (pi/4)) alfa_cos = Math.cos(alfa)
            else if(alfa >= (pi/4) && alfa < (3/4*pi)) alfa_cos = Math.cos(alfa - pi/2)
            else if(alfa >= (-3/4*pi) && alfa < (-pi/4)) alfa_cos = Math.cos(alfa + pi/2)
            else if(alfa >= (3/4*pi) && alfa < (pi)) alfa_cos = Math.cos(alfa - pi)
            else if(alfa >= (-pi) && alfa < (-3/4*pi)) alfa_cos = Math.cos(alfa + pi)

            // get normalized rho value
            var rho = (Math.sqrt(Math.pow(x_curr_value,2)+ Math.pow(y_curr_value,2))) * alfa_cos

            // update values in the slider
            if(rho >= rho_thr) {rpm_alpha.xvalue = nmax * rho; rpm_alpha.zvalue = alfa * 180/pi}
            else {rpm_alpha.xvalue =0; rpm_alpha.zvalue = 0}

        }
    }

    Connections {
        target: QJoysticks
        enabled: hciIsConnected
        function onAxisChanged(js, axis, value) {
            if (currentJoystick === js && x_index === axis)
                x_curr_value = QJoysticks.getAxis (js, x_index)
            else if (currentJoystick === js && y_index === axis)
                y_curr_value = - QJoysticks.getAxis (js, y_index)
        }
    }

    // button used to switch to NGC and minion views. It is immediately available when controller is connected.
    Connections {
        target: QJoysticks
        enabled: hciIsConnected
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

    Connections {
        // to switch between tabs
        target: QJoysticks
        enabled: data_model.data_source.is_connected

        function onButtonChanged(js, button, pressed) {
            if (button === 3 && pressed === true){
                bar.currentIndex = bar.currentIndex > tabLen? 0 : bar.currentIndex+1
            }
        }
    }

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


        Page{
            id: main_view_page
            property int margin: 10
            Layout.alignment: Qt.AlignTop
            Layout.fillHeight: true
            Layout.preferredWidth: 460
            Layout.preferredHeight: 800
            Layout.topMargin: 10
            Layout.rightMargin: 10
            Layout.bottomMargin: 10

            header: TabBar {
                id: bar
                height: 36
                spacing: 4


                TabButton {
                    id: ngc_1_tab
                    background: BasicTabButtonBackground {
                        id: btb
                        implicitHeight: bar.height
                        implicitWidth: ngc_1_tab.implicitWidth
                        text_content: qsTr("SET UP")
                        color: bar.currentIndex === 0 ? "aliceblue" : "lightskyblue"
                        text_color: bar.currentIndex === 0 ? "black" : "white"
                    }
                }
                TabButton {
                    id: ngc_2_tab
                    background: BasicTabButtonBackground {
                        implicitHeight: bar.height
                        implicitWidth: ngc_2_tab.implicitWidth
                        text_content: qsTr("NGC")
                        color: bar.currentIndex === 1 ? "aliceblue" : "lightskyblue"
                        text_color: bar.currentIndex === 1 ? "black" : "white"
                    }
                }
                TabButton {
                    id: ngc_3_tab
                    background: BasicTabButtonBackground {
                        implicitHeight: bar.height
                        implicitWidth: ngc_3_tab.implicitWidth
                        text_content: qsTr("OTHER")
                        color: bar.currentIndex === 2 ? "aliceblue" : "lightskyblue"
                        text_color: bar.currentIndex === 2 ? "black" : "white"
                    }
                }
            }
            footer: Button {
                id: connect_button

                onClicked: data_model.data_source.setConnection()
                contentItem: Text {
                    text: hciIsConnected ? "disconnect" : "connect"
                    font.family: "Helvetica"
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            StackLayout {
                id: view
                anchors.fill: parent
                anchors.margins: main_view_page.margin
                currentIndex: bar.currentIndex
                Rectangle {
                    id: control_panel
                    implicitHeight: main_cl.implicitHeight

                    ColumnLayout {
                        id: main_cl
                        anchors.fill: parent
                        spacing: 10
                        EnginePanel {
                            id: engine_panel
                            //color: "aliceblue"
                            Layout.fillWidth: true
                            //Layout.alignment: Qt.AlignTop
                            enabled: hciIsConnected
                            opacity: hciIsConnected? 1 : 0.3
                        }
                        HomingPanel{
                            id: homing_panel
                            //color: "aliceblue"
                            Layout.fillWidth: true
                            //Layout.alignment: Qt.AlignTop
                            enabled: hciIsConnected
                            opacity: hciIsConnected? 1 : 0.3
                        }
                        NgcEnabledPanel{
                            Layout.fillWidth: true
                            Layout.topMargin: 4
                            //Layout.alignment: Qt.AlignTop
                            color: "transparent"
                            enabled: hciIsConnected
                            opacity: hciIsConnected? 1 : 0.3
                        }

                        NGCPanelSC{
                            id: ngc_auto
                            Layout.fillWidth: true
                            //Layout.alignment: Qt.AlignTop
                            clip: true
                            panel_color: "aliceblue"
                            slider_width: 200
                            title: "CONTROL"
                            enabled: hciIsConnected
                            opacity: hciIsConnected? 1 : 0.3
                            slider1_text: "X"; slider1_from: -50.0; slider1_to: 50.0;  slider1_ref: xRef  //slider1_mask: "#00";
                            slider2_text: "G"; slider2_from: -180; slider2_to: 180;    slider2_ref: gammaRef  //slider1_mask: "#00";
                        }
                        ThrustMappingPanel{
                            id: rpm_alpha
                            Layout.fillWidth: true
                            //Layout.alignment: Qt.AlignTop
                            slider_width: 200
                            title: "RPM_ALPHA"
                            slider1_text: "N"; slider1_from: 0; slider1_to: root.maxRPMSpeed;  slider1_ref: root.nRef;   //slider1_mask: "#000";
                            slider2_text: "D"; slider2_from: -900; slider2_to: 900;  slider2_ref: root.dnRef    //slider2_mask: "#000";
                            slider3_text: "Α"; slider3_from: -180; slider3_to: 180;  slider3_ref: root.alphaRef //slider3_mask: "#000";
                            clip: true
                            panel_color: "aliceblue"
                            enabled: hciIsConnected
                            opacity: hciIsConnected? 1 : 0.3
                            onValueChanged: root.publish_topic(root.rpmAlphaTn, value) //console.log(value)
                        }
                        //                        Rectangle {
                        //                            Layout.fillWidth: true
                        //                            Layout.fillHeight: true
                        //                        }
                    }
                }

                Rectangle {
                    id: ngc_2_panel
                    implicitHeight: ngc_2_cl.implicitHeight

                    ColumnLayout {
                        id: ngc_2_cl
                        anchors.fill: parent
                        spacing: 10
                        ThrustMappingPanel{
                            id: force_torque
                            Layout.fillWidth: true
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
                        ControlPanelSC{
                            id: control_panel_2
                            Layout.fillWidth: true
                            enabled: hciIsConnected
                            opacity: hciIsConnected? 1 : 0.3
                            Layout.alignment: Qt.AlignTop
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                    }

                }
                Rectangle {
                    id: ngc_3_panel
                    implicitHeight: ngc_2_cl.implicitHeight

                    ColumnLayout {
                        id: ngc_3_cl
                        anchors.fill: parent
                        spacing: 10
                        ManeuversPanel{
                            id: man_panel
                            title: "MANEUVERS"
                            Layout.fillWidth: true
                            panel_color: "white"
                            Layout.alignment: Qt.AlignTop
                            enabled: data_model.data_source.is_connected
                            opacity: data_model.data_source.is_connected? 1 : 0.3
                        }
                        BathymetryPanel {
                            id: bathymetry_panel
                            title: "BATHYMETRY"
                            panel_color: "white"
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignTop
                            opacity: hciIsConnected ? 1 : 0.3
                            enabled: hciIsConnected
                        }
                        CoordinatePanel{
                            id: coordinate_panel
                            title: "COORDINATES"
                            Layout.fillWidth: true
                            panel_color: "aliceblue"
                            Layout.alignment: Qt.AlignTop
                            enabled: data_model.data_source.is_connected
                            opacity: data_model.data_source.is_connected? 1 : 0.3
                        }
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                    }
                }
            }
        }
    }
    function messagePrompt(prompt_text){
        app_root.messagePrompt(prompt_text)
    }
    function add_point(lat, lon){
        navigation_map.add_point(lat, lon)
    }
}
