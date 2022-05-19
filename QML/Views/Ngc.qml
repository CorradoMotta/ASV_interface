import QtQuick 2.0
import com.cnr.property 1.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import "../BasicItems"
import "../Panels"

BasicMinionPanelContainer{
    id : ngc_root
    implicitHeight: Math.max(cmd_row.implicitHeight , cmd_row_2.implicitHeight) + title_height + 20
    implicitWidth: cmd_row.implicitWidth + cmd_row_2.implicitWidth + bar.width + 200 // TODO WHY SO MUCH
    title: "NGC"
    color: "whitesmoke"

    property var prefix: data_model.data_source.swamp_status.ngc_status
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
    readonly property real asvRefXRef   : prefix.asvRefXref.value
    readonly property real asvRefYRef   : prefix.asvRefYref.value
    readonly property real asvRefNref : prefix.asvRefNref.value


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
    readonly property real xRef : prefix.asvRefxRef.value
    readonly property real yRef : prefix.asvRefyRef.value
    readonly property real nNRef : prefix.asvRefNref.value

    // MODES
    readonly property int ngcEnableRef : prefix.ngcEnable.ref.value
    readonly property int executionWorking_modeRef : prefix.refExecutionWorking_mode.value
    readonly property int working_modeRef : prefix.refWorking_mode.value

    //border.color: "transparent"
    RowLayout{
        id: cmd_row
        Layout.alignment: Qt.AlignTop
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
                Button {
                    id: control
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: 10
                    Layout.topMargin: 10
                    width: 200
                    onClicked: publish_topic(setLogTn, 1)
                    contentItem: Text {
                        id: testo
                        text: "NEW LOG"
                        font.family: "Helvetica"
                        font.pointSize: 14
                        anchors.horizontalCenter: background_b.horizontalCenter
                        //verticalAlignment: background_b.AlignVCenter
                    }
                    background: Rectangle{
                        id: background_b
                        height: testo.implicitHeight + 10
                        width: testo.implicitWidth + 10
                        color: control.down? "peachpuff" : "papayawhip"
                        border.width: 1
                        border.color: "black"
                        radius: 6
                    }
                }
            }
            ThrustMappingPanel{
                id: rpm_alpha
                Layout.fillWidth: true
                Layout.rightMargin: 10
                Layout.alignment: Qt.AlignTop
                title: "RPM_ALPHA"
                slider1_text: "N    "; slider1_from: 0; slider1_to: 1800; slider1_mask: "0000";   slider1_ref: ngc_root.nRef
                slider2_text: "DN   "; slider2_from: -900; slider2_to: 900; slider2_mask: "#000"; slider2_ref: ngc_root.dnRef
                slider3_text: "ALPHA"; slider3_from: -180; slider3_to: 180; slider3_mask: "#000"; slider3_ref: ngc_root.alphaRef
                clip: true
                onValueChanged: ngc_root.publish_topic(ngc_root.rpmAlphaTn, value) //console.log(value)
            }
            ThrustMappingPanel{
                id: force_torque
                Layout.fillWidth: true
                Layout.rightMargin: 10
                Layout.alignment: Qt.AlignTop
                title: "FORCE_TORQUE"
                slider1_text: "X"; slider1_from: 0; slider1_to: 1000; slider1_mask: "0000"; slider1_ref: ngc_root.asvRefXRef
                slider2_text: "Y"; slider2_from: 0; slider2_to: 1000; slider2_mask: "0000"; slider2_ref: ngc_root.asvRefYRef
                slider3_text: "N"; slider3_from: 0; slider3_to: 1000; slider3_mask: "0000"; slider3_ref: ngc_root.asvRefNref
                clip: true
                onValueChanged: ngc_root.publish_topic(ngc_root.forceTorqueTn, value)
            }
            ControlPanel{
                id: control_panel
                Layout.fillWidth: true
                Layout.rightMargin: 10
                Layout.alignment: Qt.AlignTop
                clip: true
                //onValueChanged: console.log(value)
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
            topMargin: 20
            leftMargin: 10
            top: parent.top; right: parent.right; bottom: parent.bottom; left: bar.right
            rightMargin: 10
        }

        ColumnLayout{
            Layout.alignment: Qt.AlignLeft
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
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "IMU_R"
                value_text: ngc_root.rIMU
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "IMU_P"
                value_text: ngc_root.pIMU
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "IMU_Q"
                value_text: ngc_root.qIMU
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_X"
                value_text: ngc_root.asvHatX
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_Y"
                value_text: ngc_root.asvHatY
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_PSI"
                value_text: ngc_root.asvHatpsi
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_U"
                value_text: ngc_root.asvHatu
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_V"
                value_text: ngc_root.asvHatv
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_R"
                value_text: ngc_root.asvHatr
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_X_DOT"
                value_text: ngc_root.asvHatxDot
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_Y_DOT"
                value_text: ngc_root.asvHatyDot
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_LAT"
                value_text: ngc_root.asvHatlat
            }
            BasicTextOutputInverted{
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                value_width: 120
                title_text: "A_H_LON"
                value_text: ngc_root.asvHatlon
            }
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignRight
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "A_R_x"
                value_text: ngc_root.xRef
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "A_R_y"
                value_text: ngc_root.yRef
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "A_R_N"
                value_text: ngc_root.nNRef
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
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
                title_text: "A_R_LAT"
                value_text: ngc_root.asvReflatRef
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "A_R_LON"
                value_text: ngc_root.asvReflonLref
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "A_R_xL"
                value_text: ngc_root.asvRefxLref
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "A_R_yL"
                value_text: ngc_root.asvRefyLref
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "A_R_GammaL"
                value_text: ngc_root.asvRefgammaLRef
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "A_R_LATL"
                value_text: ngc_root.asvReflatLref
            }
            BasicTextOutput{
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                value_width: 120
                title_text: "A_R_LONL"
                value_text: ngc_root.asvReflonLref
            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "Y_REF"
            //                value_text: ngc_root.yRef
            //            }
            //            BasicTextOutput{
            //                Layout.alignment: Qt.AlignTop | Qt.AlignRight
            //                value_width: 120
            //                title_text: "N_REF"
            //                value_text: ngc_root.nNRef
            //            }



        }
    }
}
