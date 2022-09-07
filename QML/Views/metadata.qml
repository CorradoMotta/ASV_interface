import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.15

Rectangle {

    property bool isMainView: false

    Button{
        id: button_back
        width: 100
        height: 30
        anchors.centerIn: parent
        text: "home"
        onClicked: mainLoader.source = "../Views/MainView.qml"
    }

    //    Rectangle{
    //        id: button_back
    //        width: 100
    //        height: 30
    //        anchors.centerIn: parent
    //        Text {
    //            id: name
    //            anchors.centerIn: parent
    //            text: qsTr("click")
    //        }
    //        MouseArea{
    //            anchors.fill: parent
    //            onClicked: mainLoader.source = "../Views/MainView.qml"
    //        }
    //    }

    Layout.fillHeight: true
    Layout.fillWidth: true
}
