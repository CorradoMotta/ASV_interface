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
            model: navigation_map.mapTypes
            MenuItem {
                text: navigation_map.mapName === "mapboxgl" ? model.description: model.name
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
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_AZIMUTH_BOW"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_FRWD_AZIMUTH_BOW): ""}
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_AZIMUTH_STERN"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_FRWD_AZIMUTH_STERN): ""}
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_THRUST_ALL"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_THRUST_ALL): ""}
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_AZIMUTH_ALL"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_AZIMUTH_ALL): ""}
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_AZIMUTH_BOW"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_AZIMUTH_BOW): ""}
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_AZIMUTH_STERN"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_AZIMUTH_STERN): ""}
    }
    // TODO MAKE ELEMENTS
    Menu {
        title: qsTr("&SetPosition")
        Rectangle{
            width: 200
            height: position_column.implicitHeight + 40
            color: "white"
            border.color: "black"
            //border.width:
            ColumnLayout{
                id: position_column
                anchors.fill: parent
                anchors.leftMargin: 6
                Button {
                    id: control
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: console.log("todo")//publish_topic(setLogTn, 1)
                    contentItem: Text {
                        id: testo
                        text: "SET POINT"
                        font.family: "Helvetica"
                        font.pointSize: 10
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
                        radius: 3
                    }
                }
//                Text {
//                    id: set_point
//                    Layout.alignment: Qt.AlignTop
//                    text: qsTr("SET POINT")
//                    font.family: "Helvetica"
//                    font.pointSize: 10
//                    font.bold: true
//                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: text1
                        title_text:  qsTr("SET X")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_text_output
                        Layout.preferredWidth: text1.value_width
                        Layout.preferredHeight: text1.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_out_value_id
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: texty
                        title_text:  qsTr("SET Y")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_text_output_y
                        Layout.preferredWidth: texty.value_width
                        Layout.preferredHeight: texty.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_out_value_id_y
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }

                // set line
                Button {
                    id: control_line
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: console.log("todo")//publish_topic(setLogTn, 1)
                    contentItem: Text {
                        id: testo_line
                        text: "SET LINE"
                        font.family: "Helvetica"
                        font.pointSize: 10
                        anchors.horizontalCenter: background_line.horizontalCenter
                        //verticalAlignment: background_b.AlignVCenter
                    }
                    background: Rectangle{
                        id: background_line
                        height: testo_line.implicitHeight + 10
                        width: testo_line.implicitWidth + 10
                        color: control_line.down? "peachpuff" : "papayawhip"
                        border.width: 1
                        border.color: "black"
                        radius: 3
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: textxline
                        title_text:  qsTr("SET LINE X  ")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_xline_output
                        Layout.preferredWidth: textxline.value_width
                        Layout.preferredHeight: textxline.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_xline_value_id
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: textliney
                        title_text:  qsTr("SET LINE Y  ")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_textline_output_y
                        Layout.preferredWidth: textliney.value_width
                        Layout.preferredHeight: textliney.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_outline_value_id_y
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: textlinegamma
                        title_text:  qsTr("SET GAMMA")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_textline_output_gamma
                        Layout.preferredWidth: textlinegamma.value_width
                        Layout.preferredHeight: textlinegamma.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_outline_value_id_gamma
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }
            }
        }
    }
}
