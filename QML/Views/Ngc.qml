/*************************************************************************
 *
 * This element contains the NGC view. Both commands and telemetry are
 * showed in this panel.
 *
 * Joystick integration is also performed here. A timer set to 100 ms is
 * used to limit the number of packets sent out from the interface.
 *
 *************************************************************************/

import QtQuick 2.0
import com.cnr.property 1.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import "../BasicItems"
import "../Panels"

BasicMinionPanelContainer{
    id : ngc_root

    implicitHeight: Math.max(cmd_row.implicitHeight , cmd_row_2.implicitHeight) + title_height
    implicitWidth: cmd_row.implicitWidth + cmd_row_2.implicitWidth + bar.width + 250 // TODO WHY SO MUCH
    property int minimumXDim : implicitWidth
    property int minimumYDim: implicitHeight
    title: "NGC"
    color: "whitesmoke"
    property int blockSize: 12
    property int currentJoystick: 0
    property var prefix: data_model.data_source.swamp_status.ngc_status
    property alias xValue : control_panel.xValue
    readonly property string ngcEnableTn: prefix.ngcEnable.act.topic_name
    readonly property string rpmAlphaTn: prefix.rpmAlpha.topic_name
    readonly property string forceTorqueTn: prefix.forceTorque.topic_name
    readonly property string setLogTn: prefix.setLog.topic_name
    readonly property var publish_topic: data_model.data_source.publishMessage

    // STATUS
    // IMU
    readonly property real psi :     prefix.psi.value
    readonly property real phiIMU :  prefix.phiIMU.value
    readonly property real thetaIMU :prefix.thetaIMU.value
    readonly property real rIMU :    prefix.rIMU.value
    readonly property real pIMU :    prefix.pIMU.value
    readonly property real qIMU :    prefix.qIMU.value

    //ASVHAT
    readonly property real asvHatX :   prefix.asvHatX.value
    readonly property real asvHatY :   prefix.asvHatY.value
    readonly property real asvHatpsi : prefix.asvHatpsi.value
    readonly property real asvHatu :   prefix.asvHatu.value
    readonly property real asvHatv :   prefix.asvHatv.value
    readonly property real asvHatr :   prefix.asvHatr.value
    readonly property real asvHatxDot :prefix.asvHatxDot.value
    readonly property real asvHatyDot :prefix.asvHatyDot.value
    readonly property real asvHatlat : prefix.asvHatlat.value
    readonly property real asvHatlon : prefix.asvHatlon.value

    // ASVREF
    readonly property real asvReflatRef : prefix.asvReflatRef.value
    readonly property real asvReflonRef : prefix.asvReflonRef.value
    readonly property real asvRefxLref  : prefix.asvRefxLref.value
    readonly property real asvRefyLref  : prefix.asvRefyLref.value
    readonly property real asvReflatLref: prefix.asvReflatLref.value
    readonly property real asvReflonLref: prefix.asvReflonLref.value
    readonly property real asvRefgammaLRef : prefix.asvRefgammaLref.value
    readonly property real asvRefXRef   : prefix.asvRefxRef.value
    readonly property real asvRefYRef   : prefix.asvRefyRef.value

    // NOT ADDED YET
    //    asvRefnFL();
    //    asvRefnFR();
    //    asvRefnRR();
    //    asvRefnRL();
    //    asvRefazimuthFL
    //    asvRefazimuthFR
    //    asvRefazimuthRR
    //    asvRefazimuthRL

    readonly property real nRef : prefix.asvRefnRef.value
    readonly property real dnRef : prefix.asvRefdnRef.value
    readonly property real alphaRef : prefix.asvRefalphaRef.value
    readonly property real xRef : prefix.asvRefXref.value
    readonly property real yRef : prefix.asvRefYref.value
    readonly property real nNRef : prefix.asvRefNref.value
    readonly property real asvRefXhat : prefix.asvRefXhat.value
    readonly property real asvRefYhat : prefix.asvRefYhat.value
    readonly property real asvRefNhat : prefix.asvRefNhat.value


    // MODES
    readonly property int ngcEnableRef : prefix.ngcEnable.ref.value
    readonly property int executionWorking_modeRef : prefix.refExecutionWorking_mode.value
    readonly property int working_modeRef : prefix.refWorking_mode.value
    readonly property int manual_modeRef : prefix.refManual_mode.value
    readonly property int autoModeRef    : prefix.refAutoMode.value

    // azimuth ref
    readonly property real asvRefazimuthFL : prefix.asvRefazimuthFL.value // azimuth[FL]
    readonly property real asvRefazimuthFR : prefix.asvRefazimuthFR.value // azimuth[FR]
    readonly property real asvRefazimuthRR : prefix.asvRefazimuthRR.value // azimuth[RR]
    readonly property real asvRefazimuthRL : prefix.asvRefazimuthRL.value // azimuth[RL]

    // n ref
    readonly property real asvRefnFL : prefix.asvRefnFL.value // n[FL]
    readonly property real asvRefnFR : prefix.asvRefnFR.value // n[FR]
    readonly property real asvRefnRR : prefix.asvRefnRR.value // n[RR]
    readonly property real asvRefnRL : prefix.asvRefnRL.value // n[RL]

    // for controller
    property real x_curr_value : 0
    property real y_curr_value : 0
    property real x_index : 0
    property real y_index : 1
    property real pi : Math.PI
    property real nmax : 1600
    property real rho_thr: 0.2
    property real alfa_cos : 0

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

        function onAxisChanged(js, axis, value) {
            if (currentJoystick === js && x_index === axis)
                x_curr_value = QJoysticks.getAxis (js, x_index)
            else if (currentJoystick === js && y_index === axis)
                y_curr_value = - QJoysticks.getAxis (js, y_index)
        }
    }

    //border.color: "transparent"
    RowLayout{
        id: cmd_row
        Layout.alignment: Qt.AlignTop
        spacing: 2
        //width: parent.width/2
        anchors{
            topMargin: 10
            //fill: parent
            top: parent.top; left: parent.left; bottom: parent.bottom; right: bar.right
            rightMargin: 10
            leftMargin: 10
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 10
            spacing: 15
            RowLayout{
                Layout.fillWidth: true
                StatusDot{
                    Layout.alignment: Qt.AlignLeft
                    Layout.leftMargin: 10
                    width: 30
                    height: 30
                    info_text : "enableRef"
                    dot_state: ngcEnableRef
                }
                BasicSwitch{
                    switch_text: "NGC_ENABLE"
                    // TODO
                    onSwitch_is_activeChanged: switch_is_active? ngc_root.publish_topic(ngc_root.ngcEnableTn, 1)
                                                               : ngc_root.publish_topic(ngc_root.ngcEnableTn, 0)
                }
                Rectangle{
                    Layout.fillWidth: true
                }
                BasicButton {
                    id: control
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: 10
                    Layout.topMargin: 4
                    onClicked: publish_topic(setLogTn, 1)
                    text_on_button: "NEW LOG"
                    button_width: 100
                }
            }
            ThrustMappingPanel{
                id: rpm_alpha
                Layout.fillWidth: true
                Layout.rightMargin: 10
                Layout.alignment: Qt.AlignTop
                title: "RPM_ALPHA"
                slider1_text: "N "; slider1_from: 0; slider1_to: 1800;      slider1_ref: ngc_root.nRef   //slider1_mask: "0000";
                slider2_text: "DN"; slider2_from: -900; slider2_to: 900;  slider2_ref: ngc_root.dnRef    //slider2_mask: "#000";
                slider3_text: "A "; slider3_from: -180; slider3_to: 180;  slider3_ref: ngc_root.alphaRef //slider3_mask: "#000";
                clip: true
                onValueChanged: ngc_root.publish_topic(ngc_root.rpmAlphaTn, value) //console.log(value)
            }
            ThrustMappingPanel{
                id: force_torque
                Layout.fillWidth: true
                Layout.rightMargin: 10
                Layout.alignment: Qt.AlignTop
                title: "FORCE_TORQUE"
                slider1_text: "X"; slider1_from: -100.0; slider1_to: 100.0;  slider1_ref: ngc_root.xRef ; slider1_act: ngc_root.asvRefXhat //slider1_mask: "#00";
                slider2_text: "Y"; slider2_from: -50.0; slider2_to: 50.0;  slider2_ref: ngc_root.yRef ; slider2_act: ngc_root.asvRefYhat //slider2_mask: "#00";
                slider3_text: "N"; slider3_from: -100.0; slider3_to: 100.0;  slider3_ref: ngc_root.nNRef; slider3_act: ngc_root.asvRefNhat //slider3_mask: "#00";
                clip: true
                onValueChanged: ngc_root.publish_topic(ngc_root.forceTorqueTn, value)
            }

            ControlPanel{
                id: control_panel
                Layout.fillWidth: true
                Layout.rightMargin: 10
                Layout.alignment: Qt.AlignTop
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
        Layout.alignment: Qt.AlignTop
        spacing: 2
        //width: parent.width/2
        anchors{
            topMargin: 40
            leftMargin: 10
            top: parent.top; right: parent.right;  left: bar.right
            rightMargin: 10
        }

        ColumnLayout{
            Layout.alignment: Qt.AlignLeft
            Text {
                id: imu_text_id
                Layout.alignment: Qt.AlignTop |Qt.AlignLeft
                Layout.leftMargin: 4
                text: "IMU"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true

            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "IMU_PSI"
                value_text: ngc_root.psi

            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "IMU_PHI"
                value_text: ngc_root.phiIMU
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "IMU_THETA"
                value_text: ngc_root.thetaIMU
            }
            Text {
                id: asv_text_id
                Layout.alignment: Qt.AlignTop |Qt.AlignLeft
                Layout.leftMargin: 4
                Layout.topMargin: ngc_root.blockSize
                text: "KINEMATIC STATE"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true

            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "ASV_H_X"
                value_text: ngc_root.asvHatX
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "ASV_H_Y"
                value_text: ngc_root.asvHatY
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "ASV_H_PSI"
                value_text: ngc_root.asvHatpsi
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "ASV_H_SURGE"
                value_text: ngc_root.asvHatu
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "ASV_H_SWAY"
                value_text: ngc_root.asvHatv
            }

            Text {
                id: modes_text_id
                Layout.alignment: Qt.AlignTop |Qt.AlignLeft
                Layout.leftMargin: 4
                Layout.topMargin: ngc_root.blockSize
                text: "MODES"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true

            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "MAN_M_REF"
                value_text: ngc_root.manual_modeRef
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "AUTO_M_REF"
                value_text: ngc_root.autoModeRef
            }
            Text {
                id: azimuth_text_id
                Layout.alignment: Qt.AlignTop |Qt.AlignLeft
                Layout.leftMargin: 4
                Layout.topMargin: ngc_root.blockSize
                text: "AZIMUTH"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true

            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "azimuth[FL]"
                value_text: ngc_root.asvRefazimuthFL
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "azimuth[RL]"
                value_text: ngc_root.asvRefazimuthRL
            }


            Text {
                id: rpm_text_id
                Layout.alignment: Qt.AlignTop |Qt.AlignLeft
                Layout.leftMargin: 4
                Layout.topMargin: ngc_root.blockSize
                text: "RPM"
                font.family: "Helvetica"
                font.pointSize: 14
                font.bold: true

            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "n[FL]"
                value_text: ngc_root.asvRefnFL
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "n[RL]"
                value_text: ngc_root.asvRefnRL
            }


        }
        ColumnLayout{
            Layout.alignment: Qt.AlignRight
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                Layout.topMargin: imu_text_id.implicitHeight
                value_width: 120
                title_text: "IMU_R"
                value_text: ngc_root.rIMU
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "IMU_P"
                value_text: ngc_root.pIMU
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "IMU_Q"
                value_text: ngc_root.qIMU
            }



            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                Layout.topMargin: modes_text_id.implicitHeight + ngc_root.blockSize
                value_width: 120
                //Layout.topMargin: ngc_root.blockSize
                title_text: "ASV_H_YAW"
                value_text: ngc_root.asvHatr
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "ASV_XDOT"
                value_text: ngc_root.asvHatxDot
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "ASV_YDOT"
                value_text: ngc_root.asvHatyDot
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "ASV_LAT"
                value_text: ngc_root.asvHatlat
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "ASV_LON"
                value_text: ngc_root.asvHatlon
            }

            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_x"
            //                value_text: ngc_root.xRef
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_y"
            //                value_text: ngc_root.yRef
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_N"
            //                value_text: ngc_root.nNRef
            //            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight

                value_width: 120
                Layout.topMargin: modes_text_id.implicitHeight + ngc_root.blockSize + 6
                title_text: "EXE_WORK_M"
                value_text: ngc_root.executionWorking_modeRef
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "WORK_M_REF"
                value_text: ngc_root.working_modeRef
            }

            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                Layout.topMargin: modes_text_id.implicitHeight + ngc_root.blockSize + 6
                title_text: "azimuth[FR]"
                value_text: ngc_root.asvRefazimuthFR
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120

                title_text: "azimuth[RR]"
                value_text: ngc_root.asvRefazimuthRR
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                Layout.topMargin: modes_text_id.implicitHeight + ngc_root.blockSize + 6
                value_width: 120
                title_text: "n[FR]"
                value_text: ngc_root.asvRefnFR
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "n[RR]"
                value_text: ngc_root.asvRefnRR
            }

            // SET LINE and POSITION
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_LAT"
            //                value_text: ngc_root.asvReflatRef
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_LON"
            //                value_text: ngc_root.asvReflonLref
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_xL"
            //                value_text: ngc_root.asvRefxLref
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_yL"
            //                value_text: ngc_root.asvRefyLref
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_GammaL"
            //                value_text: ngc_root.asvRefgammaLRef
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_LATL"
            //                value_text: ngc_root.asvReflatLref
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_LONL"
            //                value_text: ngc_root.asvReflonLref
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_LATL"
            //                value_text: ngc_root.asvRefXRef
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "A_R_LONL"
            //                value_text: ngc_root.asvRefYRef
            //            }
        }
    }
}

