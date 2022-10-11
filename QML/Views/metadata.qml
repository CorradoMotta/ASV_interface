/*************************************************************************
 *
 * Metadata qml view. This is the global metadata view. It loads all the
 * elements from the cpp model which in turn is generated from JSON
 * database.
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.15
import "../BasicItems"

Rectangle {

    color: "whitesmoke"

    property bool isMainView: false
    property date currentDate: new Date()

    Rectangle {
        id: tabRectangle
        y: 20
        height: tabTitle.height * 2
        color: "#87bfee"
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.left: parent.left
        anchors.right: parent.right

        Label {
            id: tabTitle
            color: "#ffffff"
            text: qsTr("Global Metadata")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: item2
        height: gridLayout3.implicitHeight
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tabRectangle.bottom

        GridLayout {
            id: gridLayout3
            rowSpacing: 10
            columns: 2
            columnSpacing: 10
            anchors.fill: parent

            Repeater {
                model: _metadata
                BasicMetadataInput{
                    Layout.fillWidth: true
                    //Layout.alignment: Qt.AlignRight
                    title_color: isMandatory ? "darkorange" : ""
                    title_text: name
                    value_text: value
                    hovering_text: description
                    onCurrentValueChanged: value = currentValue
                }
            }
        }
    }
    RowLayout {
        id: rowLayout1
        anchors.top: item2.bottom
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.topMargin: 10

        Button {
            id: defaultButton
            text: qsTr("Default")
            onClicked: _metadata.default_values()
        }

        Button {
            id: clearButton
            text: qsTr("Clear")
            onClicked: _metadata.reset()
        }

        Button {
            id: goButton
            text: qsTr("Generate INI")
            onClicked:{
                var message = _metadata.saveToDisk(data_model.data_source.swamp_status.conf.metadataIniPath)
                app_root.messagePrompt(message)
            }
        }

        Button {
            id: cancelButton
            text: qsTr("Cancel")
            onClicked: mainLoader.source = "../Views/MainView.qml"
        }
    }
    Item {
        Layout.fillHeight: true
        Layout.columnSpan: 4
    }
    Layout.fillHeight: true
    Layout.fillWidth: true
}
