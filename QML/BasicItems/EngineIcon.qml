import QtQuick 2.0
import QtQuick.Layouts 1.15

Item  {
    id: engine_icon_root
    implicitHeight: engine_text.text === ""? engine_image.implicitHeight +15 :  engine_image.implicitHeight + engine_text.implicitHeight + 15
    implicitWidth: engine_image.implicitWidth + 15
    property alias engineIconText: engine_text.text
    property int image_size: 50
    property bool set_border: false

    enum EngineStates {
        Engine_off,
        Engine_inter,
        Engine_on
    }

    property int engineState: EngineIcon.EngineStates.Engine_off

    function setSource(state) {
        if (state === EngineIcon.EngineStates.Engine_off)
            return "../../Images/Engine_off.png"
        else if (state === EngineIcon.EngineStates.Engine_inter)
            return "../../Images/Engine_inter.png"
        else if (state === EngineIcon.EngineStates.Engine_on)
            return "../../Images/Engine_on.png"
    }

    function setEngineState(previousState) {
        if (previousState === EngineIcon.EngineStates.Engine_off)
            return EngineIcon.EngineStates.Engine_inter
        else if (previousState === EngineIcon.EngineStates.Engine_inter)
            return EngineIcon.EngineStates.Engine_on
        else if (previousState === EngineIcon.EngineStates.Engine_on)
            return EngineIcon.EngineStates.Engine_off
    }


    ColumnLayout {
        id: coln
        anchors.fill: parent
        Rectangle{
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            implicitHeight: engine_image.implicitHeight +18
            implicitWidth: engine_image.implicitWidth + 18
            radius: 80
            color: set_border ? "white" : "transparent"
            border.color: set_border ? "black" : "transparent"
            Image {
                id: engine_image
                anchors.horizontalCenterOffset: 4
                anchors.verticalCenterOffset: 3
                anchors.centerIn: parent
                visible: true
                source: setSource(engineState)
                sourceSize.width: engine_icon_root.image_size
                sourceSize.height: engine_icon_root.image_size
            }
        }
        Text {
            id: engine_text
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.family: "Helvetica"
            font.pointSize: 18
        }
    }
    MouseArea {
        id: ma
        anchors.fill: parent
        onClicked: engineState = setEngineState(engineState)
    }
}
