import QtQuick 2.0
import QtQuick.Layouts 1.15

Item {
    implicitHeight: engine_image.implicitHeight + engine_text.implicitHeight
    implicitWidth: engine_image.implicitWidth
    property alias engineIconText: engine_text.text

    enum EngineStates {
        Engine_off,
        Engine_inter,
        Engine_on
    }

    property int engineState: EngineIcon.EngineStates.Engine_off

    function setSource(state) {
        if (state === EngineIcon.EngineStates.Engine_off)
            return "Images/Engine_off.png"
        else if (state === EngineIcon.EngineStates.Engine_inter)
            return "Images/Engine_inter.png"
        else if (state === EngineIcon.EngineStates.Engine_on)
            return "Images/Engine_on.png"
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

        Image {
            id: engine_image
            visible: true
            source: setSource(engineState)
            sourceSize.width: 50
            sourceSize.height: 50
        }
        Text {
            id: engine_text
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
