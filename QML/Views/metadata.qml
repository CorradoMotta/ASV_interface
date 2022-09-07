import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.15

Rectangle {

    color: "whitesmoke"

    property bool isMainView: false
    property date currentDate: new Date()
    property alias goButton: goButton
    property alias cancelButton: cancelButton

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
            text: qsTr("Mandatory Metadata")
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
        //anchors.bottom: tabRectangle2.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tabRectangle.bottom

        GridLayout {
            id: gridLayout3
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            rowSpacing: 10
            rows: 1
            columns: 4
            anchors.fill: parent

            Label {
                id: label2
                text: qsTr("Title")
            }

            TextField {
                id: title
                Layout.fillWidth: true
            }

            Label {
                id: label3
                text: qsTr("Abstract")
            }

            TextField {
                id: summary
                Layout.fillWidth: true
            }

            Label {
                id: label4
                text: qsTr("keywords")
            }

            TextField {
                id: keywords
                Layout.fillWidth: true
            }

            Label {
                id: label5
                text: qsTr("Conventions")
            }

            TextField {
                id: conventions
                Layout.fillWidth: true
            }

            Label {
                id: label6
                text: qsTr("PI name")
            }

            TextField {
                id: pi_name
                Layout.fillWidth: true
            }

            Label {
                id: label7
                text: qsTr("PI email")
            }

            TextField {
                id: pi_email
                Layout.fillWidth: true
            }

            Label {
                id: label8
                text: qsTr("PI institution")
            }

            TextField {
                id: pi_institution
                Layout.fillWidth: true
            }

            Label {
                id: label9
                text: qsTr("Date created")
            }

            TextField {
                id: date_created
                Layout.fillWidth: true
            }

            Label {
                id: label10
                text: qsTr("Platform")
            }

            TextField {
                id: platform
                Layout.fillWidth: true
            }

            Label {
                id: label11
                text: qsTr("License")
            }

            TextField {
                id: license
                Layout.fillWidth: true
            }

            Label {
                id: label12
                text: qsTr("Dataset version")
            }

            TextField {
                id: dataset_version
                Layout.fillWidth: true
            }
            //            Item {
            //                Layout.fillHeight: true
            //                Layout.columnSpan: 2
            //            }
        }
    }


    Rectangle {
        id: tabRectangle2
        y: 20
        height: tabTitle.height * 2
        color: "#87bfee"
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 60
        anchors.top: item2.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Label {
            id: tabTitle2
            color: "#ffffff"
            text: qsTr("Optional Metadata")
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Item {
        id: item3
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.bottomMargin: 20
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tabRectangle2.bottom

        GridLayout {
            id: gridLayout4
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            rowSpacing: 10
            rows: 1
            columns: 4
            anchors.fill: parent

            Label {
                id: labelb1
                text: qsTr("ID")
            }

            TextField {
                id: id
                Layout.fillWidth: true
            }

            Label {
                id: labelb2
                text: qsTr("Processing level")
            }

            TextField {
                id: processing_level
                Layout.fillWidth: true
            }

            Label {
                id: labelb3
                text: qsTr("Vertical max")
            }

            TextField {
                id: geospatial_vertical_max
                Layout.fillWidth: true
            }

            Label {
                id: labelb4
                text: qsTr("Vertical min")
            }

            TextField {
                id: geospatial_vertical_min
                Layout.fillWidth: true
            }

            RowLayout {
                id: rowLayout1
                Layout.columnSpan: 4
                Layout.topMargin: 30
                Layout.alignment: Qt.AlignRight

                Button {
                    id: goButton
                    text: qsTr("Proceed")
                    onClicked: console.log("TO DO")
                }

                Button {
                    id: defaultButton
                    text: qsTr("Default")
                    onClicked: defaultValues()
                }

                Button {
                    id: clearButton
                    text: qsTr("Clear")
                    onClicked: resetValues()
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
        }
    }

    Layout.fillHeight: true
    Layout.fillWidth: true

    function defaultValues(){
        title.text = ""
        summary.text = ""
        keywords.text = "unmanned marine vehicles,marine robotics,autonomous systems"
        conventions.text = "ACDD-1.3,CF-1.6"
        pi_name.text = ""
        pi_email.text = ""
        pi_institution.text = "CNR-INM"
        date_created.text = currentDate.toISOString()
        platform.text = ""
        license.text = "Creative Commons"
        dataset_version.text = "1.0"
    }

    function resetValues(){
        title.text = ""
        summary.text = ""
        keywords.text = ""
        conventions.text = ""
        pi_name.text = ""
        pi_email.text = ""
        pi_institution.text = ""
        date_created.text = ""
        platform.text = ""
        license.text = ""
        dataset_version.text = ""
    }
}
