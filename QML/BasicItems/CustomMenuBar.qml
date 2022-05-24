import QtQuick 2.0
import QtQuick.Controls 2.15
import com.cnr.property 1.0
import QtQuick.Layouts 1.15
import "../BasicItems"

MenuBar {
    id: custom_menu_bar
    readonly property string gc_working_mode_tn: data_model.data_source.swamp_status.ngc_status.gcWorkingMode.topic_name
    readonly property string thrust_mapping_manual_mode: data_model.data_source.swamp_status.ngc_status.thrustMappingManualMode.topic_name
    readonly property string thrust_mapping_auto_mode: data_model.data_source.swamp_status.ngc_status.thrustMappingAutoMode.topic_name
    readonly property var publish_topic: data_model.data_source.publishMessage

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
            text: qsTr("&Quit")
            onTriggered: Qt.quit()
        }
    }

    Menu {
        id: mapTypeMenu
        title: qsTr("MapType")
        // to add elements to my menu from a list i use the repeater element
        Repeater {
            model: navigation_map.supportedMapTypes
            MenuItem {
                text: navigation_map.plugin.name === "mapboxgl" ? model.description: model.name
                onTriggered: navigation_map.setActiveMap(model.index)
            }
        }
    }
    Menu{
        id: gcWorkingMode
        title: qsTr("GcWorkingMode")
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("RAW"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_RAW): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("THRUST"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_THRUST): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("MANUAL"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_MANUAL): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("MANUAL_SPEED"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_MANUAL_SPEED): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("GOTO_AUTO"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_GOTO_AUTO): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("GOTO_AUTO_SPEED"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_GOTO_AUTO_SPEED): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("X_Y_PSI"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_X_Y_PSI): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("LF"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_LF): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("LF_SPEED"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_LF_SPEED): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("YAW_TEST"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_YAW_TEST): ""}
    }
    Menu{
        id: thrustMappingManualMode
        title: qsTr("TM_ManualMode")
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_ALL"); ActionGroup.group: tm_manual_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_manual_mode,HciNgiInterface.TMMM_FRWD_ALL): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_BOW"); ActionGroup.group: tm_manual_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_manual_mode,HciNgiInterface.TMMM_FRWD_BOW): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_STERN"); ActionGroup.group: tm_manual_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_manual_mode,HciNgiInterface.TMMM_FRWD_STERN): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_ALL"); ActionGroup.group: tm_manual_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_manual_mode,HciNgiInterface.TMMM_BCKWD_ALL): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_BOW"); ActionGroup.group: tm_manual_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_manual_mode,HciNgiInterface.TMMM_BCKWD_BOW): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_STERN"); ActionGroup.group: tm_manual_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_manual_mode,HciNgiInterface.TMMM_BCKWD_STERN): ""}
    }
    Menu{
        id: thrustMappingAutoMode
        title: qsTr("TN_AutoMode")
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("HOV_MODE"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_HOV_MODE): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_THRUST_ALL"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_FRWD_THRUST_ALL): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_AZIMUTH_ALL"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_FRWD_AZIMUTH_ALL): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_AZIMUTH_BOW"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_FRWD_AZIMUTH_BOW): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_AZIMUTH_STERN"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_FRWD_AZIMUTH_STERN): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_THRUST_ALL"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_THRUST_ALL): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_AZIMUTH_ALL"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_AZIMUTH_ALL): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_AZIMUTH_BOW"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_AZIMUTH_BOW): ""}
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_AZIMUTH_STERN"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_AZIMUTH_STERN): ""}
    }
    Menu {
        title: qsTr("&SetPosition")
        Rectangle{
            width: 200
            height: 300
            color: "white"
            border.color: "black"
            border.width: 1
            GridLayout{
                columns: 2
                id: grid
                //spacing: 2
                //width: parent.width/2
                anchors.fill: parent
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    BasicTextInputInverted {
                        anchors.centerIn: parent
                        id: text1
                        title_text:  qsTr("SET X")
                        titleSize: 10
                        value_width: 50
                    }
                }
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    BasicTextOutputInverted {
                        id: text2
                        anchors.centerIn: parent
                        title_text: qsTr("REF X")
                        titleSize: 10
                        value_width: 50
                    }
                }
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    BasicTextInputInverted {
                        id: text3
                        anchors.centerIn: parent
                        title_text: qsTr("REF X")
                        titleSize: 10
                        value_width: 50
                    }
                }
                Rectangle{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    BasicTextOutputInverted {
                        id: text4
                        anchors.centerIn: parent
                        title_text: qsTr("REF Y")
                        titleSize: 10
                        value_width: 50
                    }
                }
            }
        }
    }
}
