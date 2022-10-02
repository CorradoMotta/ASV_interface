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
                BasicMenuButton{
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: _marker_model.insertSingleMarker(QtPositioning.coordinate(text1.new_text_value, texty.new_text_value))
                    row_title: "SET POINT"
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
                BasicMenuButton{
                    id: control_line
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: publish_topic(setXYLine_tn, textxline.new_text_value + " " + textliney.new_text_value + " " + textlinegamma.new_text_value + " " + textlinespinta.new_text_value )
                    row_title: "SET LINE X Y"
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop
                    BasicTextInputInverted {
                        id: textxline
                        title_text:  qsTr("SET LINE X  ")
                        titleSize: 10
                        value_width: 100
                    }
                }
                RowLayout{
                    Layout.alignment: Qt.AlignTop
                    BasicTextInputInverted {
                        id: textliney
                        title_text:  qsTr("SET LINE Y  ")
                        titleSize: 10
                        value_width: 100
                    }
                }
                // set line
                BasicMenuButton{
                    id: control_line_2
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
                    onClicked: publish_topic(setLineLatLon_tn, textlinelat.new_text_value + " " + textlinelon.new_text_value + " " + textlinegamma.new_text_value + " " + textlinespinta.new_text_value )
                    row_title: "SET LINE LAT LON"
                }
                BasicTextInputInverted {
                    id: textlinelat

                    Layout.alignment: Qt.AlignTop
                    title_text:  qsTr("SET LAT  ")
                    titleSize: 10
                    value_width: 120
                }

                BasicTextInputInverted {
                    id: textlinelon

                    Layout.alignment: Qt.AlignTop
                    title_text:  qsTr("SET LON  ")
                    titleSize: 10
                    value_width: 120
                }

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
            ColumnLayout{
                id: position_column_3
                anchors.fill: parent
                anchors.leftMargin: 6
                BasicMenuButton{
                    id: control2
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
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
                    text_input: qsTr("SIGMA        ")
                    text_value: "0.5"
                }
                // TODO remove space in title and set a fix length
                BasicTextInputInvertedWithRef{
                    id: omega
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    text_input: qsTr("OMEGA       ")
                    text_value: "0.05"
                }
                BasicTextInputInvertedWithRef{
                    id: textmaxNoise
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    text_input: qsTr("MAX NOISE  ")
                    text_value: "5"
                }
                BasicTextInputInvertedWithRef{
                    id: textsatTorque
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    text_input: qsTr("SAT TORQUE")
                    text_value: "10"
                }
                // set line
                BasicMenuButton{
                    id: control_line2
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 6
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
                    text_input: qsTr("SET G     ")
                    text_value: "0"
                }
                BasicTextInputInvertedWithRef{
                    id: setKi
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    text_input: qsTr("SET kI     ")
                    text_value: "0"
                }
                BasicTextInputInvertedWithRef{
                    id: setYSat
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true
                    text_input: qsTr("SET ySat ")
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
                    text_input: qsTr("SET eIon ")
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
