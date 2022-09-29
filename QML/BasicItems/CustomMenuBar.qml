import QtQuick 2.0
import QtQuick.Controls 2.15
import QtPositioning 5.15
import QtLocation 5.15
import com.cnr.property 1.0
import QtQuick.Layouts 1.15
import QtQml 2.15
import "../BasicItems"
// TODO FIX FOR CONNECT
MenuBar {
    id: custom_menu_bar
    signal setPoint(real lat, real lon)
    property alias latValue : textlinelat.new_text_value
    property alias lonValue : textlinelon.new_text_value
    readonly property string gc_working_mode_tn: data_model.data_source.swamp_status.ngc_status.gcWorkingMode.topic_name
    readonly property string thrust_mapping_manual_mode: data_model.data_source.swamp_status.ngc_status.thrustMappingManualMode.topic_name
    readonly property string thrust_mapping_auto_mode: data_model.data_source.swamp_status.ngc_status.thrustMappingAutoMode.topic_name
    readonly property string setXY_tn : data_model.data_source.swamp_status.ngc_status.setXY.topic_name
    readonly property string setXYLine_tn :  data_model.data_source.swamp_status.ngc_status.setXYLine.topic_name
    readonly property string setLineLatLon_tn :  data_model.data_source.swamp_status.ngc_status.setLineLatLon.topic_name
    readonly property string setYawGSPar_tn :  data_model.data_source.swamp_status.ngc_status.setYawGSPar.topic_name
    readonly property string setHeadingPiPar_tn :  data_model.data_source.swamp_status.ngc_status.setHeadingPiPar.topic_name
    readonly property real xRef : data_model.data_source.swamp_status.ngc_status.asvRefxRef.value
    readonly property real yRef : data_model.data_source.swamp_status.ngc_status.asvRefyRef.value
    readonly property var publish_topic: data_model.data_source.publishMessage

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

    // disabled for the moment
    //    Menu {
    //        id: mapTypeMenu
    //        title: qsTr("MapType")
    //        // to add elements to my menu from a list i use the repeater element
    //        Repeater {
    //            model: navigation_map.mapTypes
    //            MenuItem {
    //                text: navigation_map.mapName === "mapboxgl" ? model.description: model.name
    //                onTriggered: navigation_map.setActiveMap(model.index)
    //            }
    //        }
    //    }
    Menu{
        id: gcWorkingMode
        title: qsTr("GcWorkingMode")
        Action {id: raw_action; checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("RAW"); ActionGroup.group: working_modes; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.gc_working_mode_tn,HciNgiInterface.GC_RAW): ""}
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
        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("FRWD_AZIMUTH_STERN"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_FRWD_AZIMUTH_STERN): ""}
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_THRUST_ALL"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_THRUST_ALL): ""}
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_AZIMUTH_ALL"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_AZIMUTH_ALL): ""}
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_AZIMUTH_BOW"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_AZIMUTH_BOW): ""}
        //        Action {checkable: true; enabled: data_model.data_source.is_connected; text: qsTr("BCKWD_AZIMUTH_STERN"); ActionGroup.group: tm_auto_mode; onCheckedChanged: checked? custom_menu_bar.publish_topic(custom_menu_bar.thrust_mapping_auto_mode,HciNgiInterface.TMAM_BCKWD_AZIMUTH_STERN): ""}
    }
    // TODO MAKE ELEMENTS
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
            //border.width:
            ColumnLayout{
                id: position_column
                anchors.fill: parent
                anchors.leftMargin: 6
                Button {
                    id: control
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: _marker_model.insertSingleMarker(QtPositioning.coordinate(text1.new_text_value, texty.new_text_value))
                    //setPoint(text1.new_text_value, texty.new_text_value)
                    //root.add_point(text1.new_text_value, texty.new_text_value)
                    //publish_topic(setXY_tn, text1.new_text_value + " " + texty.new_text_value + " " + minion_view.xValue )
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
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: text1
                        title_text:  qsTr("SET LAT")
                        titleSize: 10
                        value_width: 100
                    }
                    //                    Rectangle{
                    //                        id: slider_text_output
                    //                        Layout.preferredWidth: text1.value_width
                    //                        Layout.preferredHeight: text1.implicitHeight
                    //                        Layout.alignment: Qt.AlignRight
                    //                        Layout.rightMargin: 10
                    //                        clip: true
                    //                        color: "whitesmoke"
                    //                        border.color: "black"
                    //                        Text{
                    //                            id: slider_out_value_id
                    //                            anchors.fill: parent
                    //                            anchors.margins: 4
                    //                            text: xRef
                    //                            font.family: "Helvetica"
                    //                            font.pointSize: 16
                    //                        }
                    //                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: texty
                        title_text:  qsTr("SET LON")
                        titleSize: 10
                        value_width: 100
                    }
                    //                    Rectangle{
                    //                        id: slider_text_output_y
                    //                        Layout.preferredWidth: texty.value_width
                    //                        Layout.preferredHeight: texty.implicitHeight
                    //                        Layout.alignment: Qt.AlignRight
                    //                        Layout.rightMargin: 10
                    //                        clip: true
                    //                        color: "whitesmoke"
                    //                        border.color: "black"
                    //                        Text{
                    //                            id: slider_out_value_id_y
                    //                            anchors.fill: parent
                    //                            anchors.margins: 4
                    //                            text: yRef
                    //                            font.family: "Helvetica"
                    //                            font.pointSize: 16
                    //                        }
                    //                    }
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
            //border.width:
            ColumnLayout{
                id: position_column_2
                anchors.fill: parent
                anchors.leftMargin: 6
                RowLayout{
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 15
                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: textlinespinta
                        title_text:  qsTr("SET X         ")
                        //make_bold: true
                        titleSize: 10
                        value_width: 100
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: textlinegamma
                        title_text:  qsTr("SET GAMMA")
                        //make_bold: true
                        titleSize: 10
                        value_width: 100
                    }
                }
                // set line
                Button {
                    id: control_line
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: publish_topic(setXYLine_tn, textxline.new_text_value + " " + textliney.new_text_value + " " + textlinegamma.new_text_value + " " + textlinespinta.new_text_value )
                    contentItem: Text {
                        id: testo_line
                        text: "SET LINE X Y"
                        font.family: "Helvetica"
                        font.pointSize: 10
                        anchors.horizontalCenter: background_line.horizontalCenter
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
                    BasicTextInputInverted {
                        id: textxline
                        title_text:  qsTr("SET LINE X  ")
                        titleSize: 10
                        value_width: 100
                        //new_text_value: main_view.pi_value
                    }
                    //                    Rectangle{
                    //                        id: slider_xline_output
                    //                        Layout.preferredWidth: textxline.value_width
                    //                        Layout.preferredHeight: textxline.implicitHeight
                    //                        Layout.alignment: Qt.AlignRight
                    //                        Layout.rightMargin: 10
                    //                        clip: true
                    //                        color: "whitesmoke"
                    //                        border.color: "black"
                    //                        Text{
                    //                            id: slider_xline_value_id
                    //                            anchors.fill: parent
                    //                            anchors.margins: 4
                    //                            font.family: "Helvetica"
                    //                            font.pointSize: 16
                    //                        }
                    //                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: textliney
                        title_text:  qsTr("SET LINE Y  ")
                        titleSize: 10
                        value_width: 100
                    }
                    //                    Rectangle{
                    //                        id: slider_textline_output_y
                    //                        Layout.preferredWidth: textliney.value_width
                    //                        Layout.preferredHeight: textliney.implicitHeight
                    //                        Layout.alignment: Qt.AlignRight
                    //                        Layout.rightMargin: 10
                    //                        clip: true
                    //                        color: "whitesmoke"
                    //                        border.color: "black"
                    //                        Text{
                    //                            id: slider_outline_value_id_y
                    //                            anchors.fill: parent
                    //                            anchors.margins: 4
                    //                            font.family: "Helvetica"
                    //                            font.pointSize: 16
                    //                        }
                    //                    }
                }
                //                RowLayout{
                //                    Layout.alignment: Qt.AlignTop

                //                    // Layout.fillWidth: true
                //                    BasicTextInputInverted {
                //                        //anchors.centerIn: parent
                //                        id: textlinegamma
                //                        title_text:  qsTr("SET GAMMA")
                //                        titleSize: 10
                //                        value_width: 100
                //                    }
                //                    Rectangle{
                //                        id: slider_textline_output_gamma
                //                        Layout.preferredWidth: textlinegamma.value_width
                //                        Layout.preferredHeight: textlinegamma.implicitHeight
                //                        Layout.alignment: Qt.AlignRight
                //                        Layout.rightMargin: 10
                //                        clip: true
                //                        color: "whitesmoke"
                //                        border.color: "black"
                //                        Text{
                //                            id: slider_outline_value_id_gamma
                //                            anchors.fill: parent
                //                            anchors.margins: 4
                //                            font.family: "Helvetica"
                //                            font.pointSize: 16
                //                        }
                //                    }
                //                }

                // set line
                Button {
                    id: control_line_2
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: publish_topic(setLineLatLon_tn, textlinelat.new_text_value + " " + textlinelon.new_text_value + " " + textlinegamma.new_text_value + " " + textlinespinta.new_text_value )
                    contentItem: Text {
                        id: testo_line_2
                        text: "SET LINE LAT LON"
                        font.family: "Helvetica"
                        font.pointSize: 10
                        anchors.horizontalCenter: background_line_2.horizontalCenter
                        //verticalAlignment: background_b.AlignVCenter
                    }
                    background: Rectangle{
                        id: background_line_2
                        height: testo_line_2.implicitHeight + 10
                        width: testo_line_2.implicitWidth + 10
                        color: control_line_2.down? "peachpuff" : "papayawhip"
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
                        id: textlinelat
                        title_text:  qsTr("SET LAT  ")
                        titleSize: 10
                        value_width: 120
                    }
                    //                    Rectangle{
                    //                        id: slider_xline_output_2
                    //                        Layout.preferredWidth: textlinegamma_2.value_width
                    //                        Layout.preferredHeight: textxline_2.implicitHeight
                    //                        Layout.alignment: Qt.AlignRight
                    //                        Layout.rightMargin: 10
                    //                        clip: true
                    //                        color: "whitesmoke"
                    //                        border.color: "black"
                    //                        Text{
                    //                            id: slider_xline_value_id_2
                    //                            anchors.fill: parent
                    //                            anchors.margins: 4
                    //                            font.family: "Helvetica"
                    //                            font.pointSize: 16
                    //                        }
                    //                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: textlinelon
                        title_text:  qsTr("SET LON  ")
                        titleSize: 10
                        value_width: 120
                    }
                    //                    Rectangle{
                    //                        id: slider_textline_output_y_2
                    //                        Layout.preferredWidth: textlinegamma_2.value_width
                    //                        Layout.preferredHeight: textliney_2.implicitHeight
                    //                        Layout.alignment: Qt.AlignRight
                    //                        Layout.rightMargin: 10
                    //                        clip: true
                    //                        color: "whitesmoke"
                    //                        border.color: "black"
                    //                        Text{
                    //                            id: slider_outline_value_id_y_2
                    //                            anchors.fill: parent
                    //                            anchors.margins: 4
                    //                            font.family: "Helvetica"
                    //                            font.pointSize: 16
                    //                        }
                    //                    }
                }
                //                RowLayout{
                //                    Layout.alignment: Qt.AlignTop

                // Layout.fillWidth: true
                //                    BasicTextInputInverted {
                //                        //anchors.centerIn: parent
                //                        id: textlinegamma_2
                //                        title_text:  qsTr("SET GAMMA")
                //                        titleSize: 10
                //                        value_width: 100
                //                    }
                //                    Rectangle{
                //                        id: slider_textline_output_gamma_2
                //                        Layout.preferredWidth: textlinegamma_2.value_width
                //                        Layout.preferredHeight: textlinegamma_2.implicitHeight
                //                        Layout.alignment: Qt.AlignRight
                //                        Layout.rightMargin: 10
                //                        clip: true
                //                        color: "whitesmoke"
                //                        border.color: "black"
                //                        Text{
                //                            id: slider_outline_value_id_gamma_2
                //                            anchors.fill: parent
                //                            anchors.margins: 4
                //                            font.family: "Helvetica"
                //                            font.pointSize: 16
                //                        }
                //                    }
                //                }
            }
        }
    }


    Menu {
        title: qsTr("&SetPar")
        Rectangle{
            enabled: data_model.data_source.is_connected
            opacity: data_model.data_source.is_connected ? 1 : 0.4
            width: 200
            height: position_column_3.implicitHeight + 200
            color: "white"
            border.color: "black"
            //border.width:
            ColumnLayout{
                id: position_column_3
                anchors.fill: parent
                anchors.leftMargin: 6
                Button {
                    id: control2
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: publish_topic(setYawGSPar_tn, sigma.new_text_value + " " +
                                             omega.new_text_value + " " +
                                             textmaxNoise.new_text_value + " " +
                                             textsatTorque.new_text_value)

                    contentItem: Text {
                        id: testo2
                        text: "SET YAW GS PAR"
                        font.family: "Helvetica"
                        font.pointSize: 10
                        anchors.horizontalCenter: background_b2.horizontalCenter
                        //verticalAlignment: background_b.AlignVCenter
                    }
                    background: Rectangle{
                        id: background_b2
                        height: testo2.implicitHeight + 10
                        width: testo2.implicitWidth + 10
                        color: control2.down? "peachpuff" : "papayawhip"
                        border.width: 1
                        border.color: "black"
                        radius: 3
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: sigma
                        title_text:  qsTr("SIGMA        ")
                        titleSize: 10
                        new_text_value: "0.5"
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_text_output2
                        Layout.preferredWidth: sigma.value_width
                        Layout.preferredHeight: sigma.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_out_value_id2
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }
                // TODO remove space in title and set a fix length
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: omega
                        title_text:  qsTr("OMEGA       ")
                        new_text_value: "0.05"
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_text_output_y2
                        Layout.preferredWidth: omega.value_width
                        Layout.preferredHeight: omega.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_out_value_id_y2
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
                        id: textmaxNoise
                        title_text:  qsTr("MAX NOISE  ")
                        new_text_value: "5"
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_textmaxNoise
                        Layout.preferredWidth: textmaxNoise.value_width
                        Layout.preferredHeight: textmaxNoise.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_out_maxNoise
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: textsatTorque
                        title_text:  qsTr("SAT TORQUE")
                        new_text_value: "10"
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_textsatTorque
                        Layout.preferredWidth: textsatTorque.value_width
                        Layout.preferredHeight: textsatTorque.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_out_satTorque
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }

                // set line
                Button {
                    id: control_line2
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: publish_topic(setHeadingPiPar_tn, setG.new_text_value + " " +
                                             setKi.new_text_value + " " +
                                             setYSat.new_text_value + " " +
                                             texteisat.new_text_value + " " +
                                             texteIon.new_text_value + " " +
                                             texteIoff.new_text_value)
                    contentItem: Text {
                        id: testo_line2
                        text: "SET HEADING PI PAR"
                        font.family: "Helvetica"
                        font.pointSize: 10
                        anchors.horizontalCenter: background_line2.horizontalCenter
                        //verticalAlignment: background_b.AlignVCenter
                    }
                    background: Rectangle{
                        id: background_line2
                        height: testo_line2.implicitHeight + 10
                        width: testo_line2.implicitWidth + 10
                        color: control_line2.down? "peachpuff" : "papayawhip"
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
                        id: setG
                        title_text:  qsTr("SET G     ")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_xline_output2
                        Layout.preferredWidth: setG.value_width
                        Layout.preferredHeight: setG.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_xline_value_id2
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
                        id: setKi
                        title_text:  qsTr("SET kI     ")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_textline_output_y2
                        Layout.preferredWidth: setKi.value_width
                        Layout.preferredHeight: setKi.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_outline_value_id_y2
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
                        id: setYSat
                        title_text:  qsTr("SET ySat ")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_textline_output_gamma2
                        Layout.preferredWidth: setYSat.value_width
                        Layout.preferredHeight: setYSat.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_outline_value_id_gamma2
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
                        id: texteisat
                        title_text:  qsTr("SET eISat")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_texteisat
                        Layout.preferredWidth: texteisat.value_width
                        Layout.preferredHeight: texteisat.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_outline_texteisat
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
                        id: texteIon
                        title_text:  qsTr("SET eIon ")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_texteIon
                        Layout.preferredWidth: texteIon.value_width
                        Layout.preferredHeight: texteIon.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_outline_texteIon
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
                        id: texteIoff
                        title_text:  qsTr("SET eIoff")
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_texteIoff
                        Layout.preferredWidth: texteIoff.value_width
                        Layout.preferredHeight: texteIoff.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_outline_texeIoff
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

    Menu {
        title: qsTr("&SetLFPar")
        Rectangle{
            enabled: data_model.data_source.is_connected
            opacity: data_model.data_source.is_connected ? 1 : 0.4
            width: 200
            height: position_column_4.implicitHeight + 200
            color: "white"
            border.color: "black"
            //border.width:
            ColumnLayout{
                id: position_column_4
                anchors.fill: parent
                anchors.leftMargin: 6
                Button {
                    id: control3
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: publish_topic(23, maxAngle.new_text_value + " " +
                                             gamma.new_text_value + " " +
                                             r.new_text_value)

                    contentItem: Text {
                        id: testo3
                        text: "LF PAR"
                        font.family: "Helvetica"
                        font.pointSize: 10
                        anchors.horizontalCenter: background_b3.horizontalCenter
                        //verticalAlignment: background_b.AlignVCenter
                    }
                    background: Rectangle{
                        id: background_b3
                        height: testo3.implicitHeight + 10
                        width: testo3.implicitWidth + 10
                        color: control3.down? "peachpuff" : "papayawhip"
                        border.width: 1
                        border.color: "black"
                        radius: 3
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: maxAngle
                        title_text:  qsTr("MAX ANGLE")
                        titleSize: 10
                        new_text_value: "60"
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_text_output3
                        Layout.preferredWidth: maxAngle.value_width
                        Layout.preferredHeight: maxAngle.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_out_value_id3
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: gamma
                        title_text:  qsTr("KGAMMA   ")
                        titleSize: 10
                        new_text_value: "0.3"
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_text_output4
                        Layout.preferredWidth: gamma.value_width
                        Layout.preferredHeight: gamma.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_out_value_id4
                            anchors.fill: parent
                            anchors.margins: 4
                            font.family: "Helvetica"
                            font.pointSize: 16
                        }
                    }
                }
                // TODO remove space in title and set a fix length
                RowLayout{
                    Layout.alignment: Qt.AlignTop

                    // Layout.fillWidth: true
                    BasicTextInputInverted {
                        //anchors.centerIn: parent
                        id: r
                        title_text:  qsTr("K R         ")
                        new_text_value: "0.1"
                        titleSize: 10
                        value_width: 50
                    }
                    Rectangle{
                        id: slider_text_output_y3
                        Layout.preferredWidth: r.value_width
                        Layout.preferredHeight: r.implicitHeight
                        Layout.alignment: Qt.AlignRight
                        Layout.rightMargin: 10
                        clip: true
                        color: "whitesmoke"
                        border.color: "black"
                        Text{
                            id: slider_out_value_id_y3
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

// LOG  20220927 16:50:21
