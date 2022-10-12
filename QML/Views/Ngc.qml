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
import "../Charts"

BasicMinionPanelContainer{
    id : ngc_root

    implicitHeight: ngc_telemetry.implicitHeight + title_height
    implicitWidth: ngc_telemetry.implicitWidth + bar.width + 80 //todo fix
    property int minimumXDim : implicitWidth
    property int minimumYDim: implicitHeight
    title: "DASHBOARD"
    color: "whitesmoke"
    property int blockSize: 12
    property var prefix: data_model.data_source.swamp_status.ngc_status
    // TODO CHECK if this xvalue is used by someone
    //property alias xValue : control_panel.xValue
    readonly property string ngcEnableTn: prefix.ngcEnable.act.topic_name
    readonly property string rpmAlphaTn: prefix.rpmAlpha.topic_name
    readonly property string forceTorqueTn: prefix.forceTorque.topic_name
    readonly property string setLogTn: prefix.setLog.topic_name
    readonly property var publish_topic: data_model.data_source.publishMessage

    // STATUS
    // GPS
    //    in >> doubleContainer; m_swamp_status.gps_ahrs_status()->date()->setValue(doubleContainer);//qDebug() << "GPS date" << intContainer;//gpsdate   singleMinion->minionState()->thrustMotorFault()->setValue(intContainer);
    //    in >> doubleContainer; m_swamp_status.gps_ahrs_status()->time()->setValue(doubleContainer);//qDebug() << "GPS time" << doubleContainer; //gpstime   singleMinion->minionState()->thrustMotorPower()->setValue(intContainer);
    //    in >> doubleContainer; m_swamp_status.gps_ahrs_status()->latitude()->setValue(doubleContainer);  //lat
    //    in >> doubleContainer; m_swamp_status.gps_ahrs_status()->longitude()->setValue(doubleContainer);
    readonly property real gps_date : data_model.data_source.swamp_status.gps_ahrs_status.date.value
    readonly property real gps_time : data_model.data_source.swamp_status.gps_ahrs_status.time.value
    readonly property real gps_latitude : data_model.data_source.swamp_status.gps_ahrs_status.latitude.value
    readonly property real gps_longitude: data_model.data_source.swamp_status.gps_ahrs_status.longitude.value

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

    BathymetryChart{
        id: btChr
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.margins: 50
        height: 340
        width: 500
        color: "whitesmoke"
    }

    RowLayout{
        id: ngc_telemetry
        anchors{
            leftMargin: 20
            right: parent.right
            top: btChr.bottom
            topMargin: 20
            left: parent.left
            //rightMargin: 10
            verticalCenter: parent.verticalCenter
        }
        ColumnLayout{
            id: asv_modes
            Layout.alignment: Qt.AlignLeft
            RowLayout{
                id: cmd_row_2
                spacing: 20

                ColumnLayout{
                    Layout.alignment: Qt.AlignLeft
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

                }
                ColumnLayout{
                    Layout.alignment: Qt.AlignRight
                    BasicTextOutput{
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        Layout.topMargin: modes_text_id.implicitHeight + ngc_root.blockSize
                        value_width: 120
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
                }
            }
        }

        ColumnLayout{
            id: gps_imu
            Layout.alignment: Qt.AlignLeft
            RowLayout{
                id: tel_row_1
                spacing: 2
                ColumnLayout{
                    Layout.alignment: Qt.AlignLeft
                    Text {
                        id: gps_text_id
                        Layout.alignment: Qt.AlignTop |Qt.AlignLeft
                        Layout.leftMargin: 4
                        text: "GPS"
                        font.family: "Helvetica"
                        font.pointSize: 14
                        font.bold: true

                    }
                    BasicTextOutputInverted{
                        Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                        value_width: 120
                        title_text: "GPS_DATE"
                        value_text: ngc_root.gps_date

                    }
                    BasicTextOutputInverted{
                        Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                        value_width: 120
                        title_text: "GPS_TIME"
                        value_text: ngc_root.gps_time

                    }
                    Text {
                        id: imu_text_id
                        Layout.alignment: Qt.AlignTop |Qt.AlignLeft
                        Layout.leftMargin: 4
                        Layout.topMargin: ngc_root.blockSize
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
                }
                ColumnLayout{
                    Layout.alignment: Qt.AlignRight
                    BasicTextOutput{
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        Layout.topMargin: gps_text_id.implicitHeight
                        value_width: 120
                        title_text: "GPS_LAT"
                        value_text: ngc_root.gps_latitude
                    }
                    BasicTextOutput{
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        value_width: 120
                        title_text: "GPS_LON"
                        value_text: ngc_root.gps_longitude
                    }
                    BasicTextOutput{
                        Layout.alignment: Qt.AlignTop | Qt.AlignRight
                        Layout.topMargin: imu_text_id.implicitHeight + ngc_root.blockSize
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

                }
            }
        }
   }


}

