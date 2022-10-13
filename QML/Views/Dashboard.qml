/*************************************************************************
 *
 * This element contains the Dashboard view. The vehicle
 * telemetry is showed in this panel.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
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

    // properties
    implicitHeight: ngc_telemetry.implicitHeight + title_height
    implicitWidth: ngc_telemetry.implicitWidth + 40
    title: "DASHBOARD"
    color: "whitesmoke"

    // custom properties
    property int blockSize: 12
    property int minimumXDim : implicitWidth
    property int minimumYDim: implicitHeight
    property var prefix: data_model.data_source.swamp_status.ngc_status

    // alias
    property alias newPoint : btChr.newPoint
    property alias reset: btChr.reset
    property alias yMAX: btChr.yMAX

    // Cpp model
    // gps
    readonly property real gps_date : data_model.data_source.swamp_status.gps_ahrs_status.date.value
    readonly property real gps_time : data_model.data_source.swamp_status.gps_ahrs_status.time.value
    readonly property real gps_latitude : data_model.data_source.swamp_status.gps_ahrs_status.latitude.value
    readonly property real gps_longitude: data_model.data_source.swamp_status.gps_ahrs_status.longitude.value
    // imu
    readonly property real psi :     prefix.psi.value
    readonly property real phiIMU :  prefix.phiIMU.value
    readonly property real thetaIMU :prefix.thetaIMU.value
    readonly property real rIMU :    prefix.rIMU.value
    readonly property real pIMU :    prefix.pIMU.value
    readonly property real qIMU :    prefix.qIMU.value
    // asvhat
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
    // modes
    readonly property int executionWorking_modeRef : prefix.refExecutionWorking_mode.value
    readonly property int working_modeRef : prefix.refWorking_mode.value
    readonly property int manual_modeRef : prefix.refManual_mode.value
    readonly property int autoModeRef    : prefix.refAutoMode.value

    BathymetryChart{
        id: btChr
        anchors{
            top: parent.top
            right: parent.right
            left: parent.left
            margins: 50
        }
        height: 340
        width: 500
        color: "whitesmoke"
    }

    RowLayout{
        id: ngc_telemetry
        anchors{
            top: btChr.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
            topMargin: 10
            rightMargin: 50
            leftMargin: 50
        }


        ColumnLayout{
            id: asv_modes
            Layout.alignment: Qt.AlignLeft
            RowLayout{
                id: cmd_row_2
                spacing: 30
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
            Layout.fillWidth: true
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

