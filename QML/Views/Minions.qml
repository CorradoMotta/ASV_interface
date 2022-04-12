import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    Rectangle {
        id: buttonRect

        color: "#100000FF"
        //opacity: 0.2
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        width: 20
        Image {
            id: image_swamp
            //anchors.horizontalCenter: buttonRect.horizontalCenter
            anchors.centerIn: buttonRect
            opacity: 0.7
            visible: true
            source: "../../Images/arrow_close.png"
            scale: 0.05
            //sourceSize.width: 40
            //sourceSize.height: 40
            MouseArea {
                anchors.fill: parent
                onClicked: stack.pop()
            }
        }
    }
    Page{
        anchors.fill: parent
        anchors.rightMargin: 30
        header: TabBar {
            id: bar
            TabButton {
                text: qsTr("general")
                onClicked:{
                    console.log("general")
                }
            }
            TabButton {
                text: qsTr("Minion 1")
            }
            TabButton {
                text: qsTr("Minion 2")
            }
            TabButton {
                text: qsTr("Minion 3")
            }
            TabButton {
                text: qsTr("Minion 4")
            }
        }

        StackLayout {
            id: view
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            currentIndex: bar.currentIndex

            Item {
                id: general
                Rectangle{
                    id: generic
                    height: 200
                    width: parent.width
                    border.color: "gray"
                    border.width: 3
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Generic";
                        font.pixelSize: 20
                    }
                }
                GridLayout{
                    id: gl
                    columns: 2
                    rows:2
                    property int margin: 10
                    anchors.top:  generic.bottom
                    anchors.topMargin: rowSpacing
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    Rectangle{
                        id: pump_rect
                        implicitWidth: text1.implicitWidth
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        border.color: "gray"
                        border.width: 3
                        Text {id: text1; anchors.horizontalCenter: parent.horizontalCenter; text: "Pump"; font.pixelSize: 20 }
                        RowLayout{
                            anchors.top: text1.bottom
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right
                            Rectangle{
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                border.color: "gray"
                                Text {id: text6; anchors.horizontalCenter: parent.horizontalCenter; text: "Cmd"; font.pixelSize: 20 }
                            }
                            Rectangle{
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                border.color: "gray"
                                Text {id: text7; anchors.horizontalCenter: parent.horizontalCenter; text: "State"; font.pixelSize: 20 }
                            }
                        }
                    }
                    Rectangle{
                        implicitWidth: text2.implicitWidth
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        border.color: "gray"
                        border.width: 3
                        Text {id: text2; anchors.horizontalCenter: parent.horizontalCenter; text: "Azimut"; font.pixelSize: 20 }}
                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        border.color: "gray"
                        border.width: 3
                        Text {id: text3;  anchors.horizontalCenter: parent.horizontalCenter; text: "IMU"; font.pixelSize: 20 }}
                    Rectangle{
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        border.color: "gray"
                        border.width: 3
                        Text {id: text4;  anchors.horizontalCenter: parent.horizontalCenter; text: "GPS"; font.pixelSize: 20 }}
                }
            }
            Item {
                id: minion1
            }
            Item {
                id: minion2
            }
            Item {
                id: minion3
            }
            Item {
                id: minion4
            }
        }
    }
}
