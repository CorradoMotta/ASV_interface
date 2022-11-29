/*************************************************************************
 *
 * Menu bar customized with the possibility to set vehicle modes and all
 * different algorithm parameters.
 *
 * Author: Corrado Motta
 * Date: 06/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.15
import QtPositioning 5.15
import QtLocation 5.15
import com.cnr.property 1.0
import QtQuick.Layouts 1.15
import QtQml 2.15
import "../BasicItems"

MenuBar {
    id: custom_menu_bar

    signal setPoint(real lat, real lon)
    property alias isPeriodic : periodic.checked
    readonly property string gc_working_mode_tn: data_model.data_source.swamp_status.ngc.ngcCmd.gcWorkingMode.topic_name
    readonly property string thrust_mapping_manual_mode: data_model.data_source.swamp_status.ngc.ngcCmd.thrustMappingManualMode.topic_name
    readonly property string thrust_mapping_auto_mode: data_model.data_source.swamp_status.ngc.ngcCmd.thrustMappingAutoMode.topic_name
    readonly property string setXY_tn : data_model.data_source.swamp_status.ngc.ngcCmd.setXY.topic_name
    readonly property string setXYLine_tn :  data_model.data_source.swamp_status.ngc.ngcCmd.setXYLine.topic_name
    readonly property string setLineLatLon_tn :  data_model.data_source.swamp_status.ngc.ngcCmd.setLineLatLon.topic_name
    readonly property string setYawGSPar_tn :  data_model.data_source.swamp_status.ngc.ngcCmd.setYawGSPar.topic_name
    readonly property string setHeadingPiPar_tn :  data_model.data_source.swamp_status.ngc.ngcCmd.setHeadingPiPar.topic_name
    readonly property string setLFPar_tn :  data_model.data_source.swamp_status.ngc.ngcCmd.setLFPar.topic_name
    readonly property real xRef : data_model.data_source.swamp_status.ngc.ngc_status.asvRefxRef.value
    readonly property real yRef : data_model.data_source.swamp_status.ngc.ngc_status.asvRefyRef.value
    readonly property var publish_topic: data_model.data_source.publishMessage
    readonly property int working_modeRef : data_model.data_source.swamp_status.ngc.ngc_status.refWorking_mode.value
    readonly property int manual_modeRef : data_model.data_source.swamp_status.ngc.ngc_status.refManual_mode.value
    readonly property int autoModeRef    : data_model.data_source.swamp_status.ngc.ngc_status.refAutoMode.value
    readonly property int exeWorkModeRef : data_model.data_source.swamp_status.ngc.ngc_status.refExecutionWorking_mode.value
    readonly property string setPFPar_tn : data_model.data_source.swamp_status.ngc.ngcCmd.setPFPar.topic_name

    // button used to go back to RAW value
    Connections {
        target: QJoysticks
        enabled: data_model.data_source.is_connected
        function onButtonChanged(js, button, pressed) {
            if (button === 1 && pressed === true){
                working_modes.checkedAction = raw_action
            }
        }
    }

    ActionGroup {
        id: working_modes
    }
    ActionGroup {
        id: tm_manual_mode
    }
    ActionGroup {
        id: tm_auto_mode
    }

    Menu {
        title: qsTr("&File")
        Action {
            text: qsTr("&Metadata")
            enabled: ! data_model.data_source.is_connected
            onTriggered:{
                mainLoader.source = "../Views/Metadata.qml"
            }
        }
        Action {
            text: qsTr("&Quit")
            onTriggered: Qt.quit()
        }
    }

    Menu{
        id: gcWorkingMode
        title: qsTr("GcWorkingMode")
        BasicMenuAction {id: raw_action;  checked: true; enum_ref: working_modeRef ; enum_value: HciNgiInterface.GC_RAW; topic_id: custom_menu_bar.gc_working_mode_tn; text: qsTr("Raw"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_THRUST ; topic_id: custom_menu_bar.gc_working_mode_tn; text: qsTr("Thrust"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_MANUAL_SPEED ; topic_id: custom_menu_bar.gc_working_mode_tn; text: qsTr("Manual Speed"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_MANUAL ; topic_id: custom_menu_bar.gc_working_mode_tn; text: qsTr("Manual"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_GOTO_AUTO ; topic_id: custom_menu_bar.gc_working_mode_tn; text: qsTr("Go to Auto"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_GOTO_AUTO_SPEED ; topic_id: custom_menu_bar.gc_working_mode_tn; text: qsTr("Go to Auto Speed"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_X_Y_PSI ; topic_id: custom_menu_bar.gc_working_mode_tn;  text: qsTr("X Y PSI"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_LF ; topic_id: custom_menu_bar.gc_working_mode_tn; text: qsTr("Line Following"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_LF_SPEED ; topic_id: custom_menu_bar.gc_working_mode_tn; text: qsTr("Line Following Speed"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_YAW_TEST ; topic_id: custom_menu_bar.gc_working_mode_tn;text: qsTr("Yaw Test"); ActionGroup.group: working_modes}
        BasicMenuAction {enum_ref: custom_menu_bar.exeWorkModeRef; enum_value: HciNgiInterface.GC_PF ; topic_id: custom_menu_bar.gc_working_mode_tn;text: qsTr("Path Following"); ActionGroup.group: working_modes}
    }
    Menu{
        id: thrustMappingManualMode
        title: qsTr("TM_ManualMode")
        BasicMenuAction {enum_ref: custom_menu_bar.manual_modeRef;  checked: true;  topic_id: custom_menu_bar.thrust_mapping_manual_mode; enum_value: HciNgiInterface.TMMM_FRWD_ALL;   text: qsTr("FRWD_ALL"); ActionGroup.group: tm_manual_mode}
        BasicMenuAction {enum_ref: custom_menu_bar.manual_modeRef; topic_id: custom_menu_bar.thrust_mapping_manual_mode; enum_value: HciNgiInterface.TMMM_FRWD_BOW;   text: qsTr("FRWD_BOW"); ActionGroup.group: tm_manual_mode}
        BasicMenuAction {enum_ref: custom_menu_bar.manual_modeRef; topic_id: custom_menu_bar.thrust_mapping_manual_mode; enum_value: HciNgiInterface.TMMM_FRWD_STERN; text: qsTr("FRWD_STERN"); ActionGroup.group: tm_manual_mode}
        BasicMenuAction {enum_ref: custom_menu_bar.manual_modeRef; topic_id: custom_menu_bar.thrust_mapping_manual_mode; enum_value: HciNgiInterface.TMMM_BCKWD_ALL;  text: qsTr("BCKWD_ALL"); ActionGroup.group: tm_manual_mode}
        BasicMenuAction {enum_ref: custom_menu_bar.manual_modeRef; topic_id: custom_menu_bar.thrust_mapping_manual_mode; enum_value: HciNgiInterface.TMMM_BCKWD_BOW;  text: qsTr("BCKWD_BOW"); ActionGroup.group: tm_manual_mode}
        BasicMenuAction {enum_ref: custom_menu_bar.manual_modeRef; topic_id: custom_menu_bar.thrust_mapping_manual_mode; enum_value: HciNgiInterface.TMMM_BCKWD_STERN;text: qsTr("BCKWD_STERN"); ActionGroup.group: tm_manual_mode}
    }
    Menu{
        id: thrustMappingAutoMode
        title: qsTr("TN_AutoMode")
        BasicMenuAction {enum_ref: custom_menu_bar.autoModeRef; checked: true;  topic_id: custom_menu_bar.thrust_mapping_auto_mode; enum_value: HciNgiInterface.TMAM_HOV_MODE;          text: qsTr("HOV_MODE"); ActionGroup.group: tm_auto_mode          }
        BasicMenuAction {enum_ref: custom_menu_bar.autoModeRef; topic_id: custom_menu_bar.thrust_mapping_auto_mode; enum_value: HciNgiInterface.TMAM_FRWD_THRUST_ALL;   text: qsTr("FRWD_THRUST_ALL"); ActionGroup.group: tm_auto_mode   }
        BasicMenuAction {enum_ref: custom_menu_bar.autoModeRef; topic_id: custom_menu_bar.thrust_mapping_auto_mode; enum_value: HciNgiInterface.TMAM_FRWD_AZIMUTH_ALL;  text: qsTr("FRWD_AZIMUTH_ALL"); ActionGroup.group: tm_auto_mode  }
        BasicMenuAction {enum_ref: custom_menu_bar.autoModeRef; topic_id: custom_menu_bar.thrust_mapping_auto_mode; enum_value: HciNgiInterface.TMAM_FRWD_AZIMUTH_STERN;text: qsTr("FRWD_AZIMUTH_STERN"); ActionGroup.group: tm_auto_mode}
    }

    Menu {
        id: setPosition
        title: qsTr("&SetPosition")
        Rectangle{
            enabled: data_model.data_source.is_connected
            opacity: data_model.data_source.is_connected ? 1 : 0.4
            width: 200
            height: position_column.implicitHeight + 40
            color: "white"
            border.color: "black"
            ColumnLayout{
                id: position_column
                anchors.fill: parent
                anchors.leftMargin: 6
                anchors.rightMargin: 6
                BasicMenuButton{
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: _marker_model.insertSingleMarker(QtPositioning.coordinate(text1.new_text_value, texty.new_text_value))
                    row_title: "SET POINT"
                }

                BasicTextInputInverted {
                    id: text1
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    title_text:  qsTr("SET LAT")
                    titleSize: 13
                    value_width: 120
                }

                BasicTextInputInverted {
                    id: texty
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    title_text:  qsTr("SET LON")
                    titleSize: 13
                    value_width: 120
                }

            }
        }
    }

    Menu {
        id: setLine
        title: qsTr("&SetLine")
        Rectangle{
            enabled: data_model.data_source.is_connected
            opacity: data_model.data_source.is_connected ? 1 : 0.4
            width: 200
            height: position_column_2.implicitHeight + 40
            color: "white"
            border.color: "black"
            ColumnLayout{
                id: position_column_2
                anchors.fill: parent
                anchors.leftMargin: 6
                anchors.rightMargin: 6
                anchors.topMargin: 20

                BasicTextInputInverted {
                    id: textlinespinta
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    title_text:  qsTr("SET X")
                    titleSize: 13
                    value_width: 100
                }
                BasicTextInputInverted {
                    id: textlinegamma
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    title_text:  qsTr("SET GAMMA")
                    titleSize: 13
                    value_width: 100
                }

                BasicMenuButton{
                    id: control_line
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: publish_topic(setXYLine_tn,
                                             textxline.new_text_value + " " +
                                             textliney.new_text_value + " " +
                                             textlinegamma.new_text_value + " " +
                                             textlinespinta.new_text_value )
                    row_title: "SET LINE X Y"
                }

                BasicTextInputInverted {
                    id: textxline
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    title_text:  qsTr("SET LINE X")
                    titleSize: 13
                    value_width: 100
                }

                BasicTextInputInverted {
                    id: textliney
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    title_text:  qsTr("SET LINE Y")
                    titleSize: 13
                    value_width: 100
                }

                BasicMenuButton{
                    id: control_line_2
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: publish_topic(setLineLatLon_tn,
                                             textlinelat.new_text_value + " " +
                                             textlinelon.new_text_value + " " +
                                             textlinegamma.new_text_value + " " +
                                             textlinespinta.new_text_value )
                    row_title: "SET LINE LAT LON"
                }
                BasicTextInputInverted {
                    id: textlinelat
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    title_text:  qsTr("SET LAT")
                    titleSize: 13
                    value_width: 120
                }

                BasicTextInputInverted {
                    id: textlinelon
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    title_text:  qsTr("SET LON")
                    titleSize: 13
                    value_width: 120
                }
            }
        }
    }

    Menu{
        title: qsTr("&Set Parameters")
        Menu {
            title: qsTr("&YAW")
            Rectangle{
                enabled: data_model.data_source.is_connected
                opacity: data_model.data_source.is_connected ? 1 : 0.4
                width: 200
                height: position_column_3.implicitHeight + 60
                color: "white"
                border.color: "black"
                ColumnLayout{
                    id: position_column_3
                    anchors.fill: parent
                    anchors.leftMargin: 6
                    anchors.rightMargin: 6
                    spacing: 6
                    BasicMenuButton{
                        id: control2
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 15
                        onClicked: publish_topic(setYawGSPar_tn, sigma.text_value + " " +
                                                 omega.text_value + " " +
                                                 textmaxNoise.text_value + " " +
                                                 textsatTorque.text_value)
                        row_title: "SET YAW GS PAR"
                    }
                    BasicTextInputInvertedWithRef{
                        id: sigma
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input: qsTr("SIGMA")
                        text_value: "0.5"
                    }
                    BasicTextInputInvertedWithRef{
                        id: omega
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input: qsTr("OMEGA")
                        text_value: "0.05"
                    }
                    BasicTextInputInvertedWithRef{
                        id: textmaxNoise
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input: qsTr("MAX NOISE")
                        text_value: "5"
                    }
                    BasicTextInputInvertedWithRef{
                        id: textsatTorque
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input: qsTr("SAT TORQUE")
                        text_value: "10"
                    }
                }
            }
        }
        Menu {
            title: qsTr("&HEADING")
            Rectangle{
                enabled: data_model.data_source.is_connected
                opacity: data_model.data_source.is_connected ? 1 : 0.4
                width: 200
                height: position_column_7.implicitHeight + 80
                color: "white"
                border.color: "black"
                ColumnLayout{
                    id: position_column_7
                    anchors.fill: parent
                    anchors.leftMargin: 6
                    anchors.rightMargin: 6
                    spacing: 6
                    BasicMenuButton{
                        id: control_line2
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 15
                        onClicked: publish_topic(setHeadingPiPar_tn, setG.text_value + " " +
                                                 setKi.text_value + " " +
                                                 setYSat.text_value + " " +
                                                 texteisat.text_value + " " +
                                                 texteIon.text_value + " " +
                                                 texteIoff.text_value)
                        row_title: "SET HEADING PI PAR"
                    }
                    BasicTextInputInvertedWithRef{
                        id: setG
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input: qsTr("SET G")
                        text_value: "0"
                    }
                    BasicTextInputInvertedWithRef{
                        id: setKi
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input: qsTr("SET kI")
                        text_value: "0"
                    }
                    BasicTextInputInvertedWithRef{
                        id: setYSat
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input: qsTr("SET ySat")
                        text_value: "0"
                    }
                    BasicTextInputInvertedWithRef{
                        id: texteisat
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input: qsTr("SET eISat")
                        text_value: "0"
                    }
                    BasicTextInputInvertedWithRef{
                        id: texteIon
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input: qsTr("SET eIon")
                        text_value: "0"
                    }
                    BasicTextInputInvertedWithRef{
                        id: texteIoff
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input:  qsTr("SET eIoff")
                        text_value: "0"
                    }
                }
            }
        }

        Menu {
            title: qsTr("&LINE FOLLOWING")
            Rectangle{
                enabled: data_model.data_source.is_connected
                opacity: data_model.data_source.is_connected ? 1 : 0.4
                width: 200
                height: position_column_4.implicitHeight + 30
                color: "white"
                border.color: "black"
                ColumnLayout{
                    id: position_column_4
                    anchors.fill: parent
                    anchors.leftMargin: 6
                    anchors.rightMargin: 6
                    BasicMenuButton{
                        id: control3
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 15
                        onClicked: publish_topic(setLFPar_tn,
                                                 maxAngle.text_value + " " +
                                                 gamma.text_value + " " +
                                                 set_r.text_value)
                        row_title: "SET LF PAR"
                    }
                    BasicTextInputInvertedWithRef{
                        id: maxAngle
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input:  qsTr("MAX ANGLE")
                        text_value: "60"
                    }
                    BasicTextInputInvertedWithRef{
                        id: gamma
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input:  qsTr("KGAMMA")
                        text_value: "0.3"
                    }
                    BasicTextInputInvertedWithRef{
                        id: set_r
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input:  qsTr("K R")
                        text_value: "0.1"
                    }
                }
            }
        }
        Menu {
            title: qsTr("&PATH FOLLOWING")
            Rectangle{
                enabled: data_model.data_source.is_connected
                opacity: data_model.data_source.is_connected ? 1 : 0.4
                width: 200
                height: position_column_5.implicitHeight + 30
                color: "white"
                border.color: "black"
                ColumnLayout{
                    id: position_column_5
                    anchors.fill: parent
                    anchors.leftMargin: 6
                    anchors.rightMargin: 6
                    CheckBox {
                        id: periodic
                        checked: true
                        text: qsTr("PERIODICITY")
                    }
                    BasicMenuButton{
                        id: control4
                        Layout.alignment: Qt.AlignTop
                        Layout.topMargin: 15
                        onClicked: publish_topic(setPFPar_tn,
                                                 k_s.text_value + " " +
                                                 k_gamma.text_value + " "+
                                                 max_angle.text_value + " "+
                                                 k_r.text_value)
                        row_title: "SET PF PAR"
                    }
                    BasicTextInputInvertedWithRef
                    {
                        id: k_s
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input:  qsTr("K_S")
                        text_value: "1.0"
                    }
                    BasicTextInputInvertedWithRef{
                        id: k_gamma
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input:  qsTr("K_GAMMA")
                        text_value: "0.3"
                    }
                    BasicTextInputInvertedWithRef{
                        id: max_angle
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input:  qsTr("MAX ANGLE")
                        text_value: "60"
                    }
                    BasicTextInputInvertedWithRef{
                        id: k_r
                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        text_input:  qsTr("K_R")
                        text_value: "0.1"
                    }
                }
            }
        }
    }
}
