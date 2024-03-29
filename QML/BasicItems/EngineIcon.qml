/*************************************************************************
 *
 * Engine icon can be enabled and powered. The states are saved in the
 * EngineStates enum. The functions setSource and setEngineState can be
 * used to set the icon and the correspondent state from the panels where
 * this element is used.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15

Item  {
    id: engine_icon_root
    implicitHeight: engine_text.text === ""? engine_image.implicitHeight +15 :  engine_image.implicitHeight + engine_text.implicitHeight + 15
    implicitWidth: engine_image.implicitWidth + 15
    property alias engineIconText: engine_text.text
    property int image_size: 50
    property bool set_border: false

    enum ButtonClicked{
        Right,
        Left
    }

    enum EngineStates {
        Engine_off,
        Engine_inter,
        Engine_on,
        Engine_backToInter
    }

    property int engineState: EngineIcon.EngineStates.Engine_off

    ColumnLayout {
        id: coln
        anchors.fill: parent
        Rectangle{
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            implicitHeight: engine_image.implicitHeight +18
            implicitWidth: engine_image.implicitWidth + 18
            radius: 80
            color: set_border ? "aliceblue" : "transparent"
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
            font.pixelSize: 22
        }
    }
    MouseArea {
        id: ma
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if(mouse.button === Qt.RightButton)
                engineState = setEngineState(engineState, EngineIcon.ButtonClicked.Right)
            else if(mouse.button === Qt.LeftButton)
                 engineState = setEngineState(engineState, EngineIcon.ButtonClicked.Left)
        }
    }

    function setSource(state) {
        if (state === EngineIcon.EngineStates.Engine_off)
            return "../../Images/Engine_off.png"
        else if (state === EngineIcon.EngineStates.Engine_inter || state === EngineIcon.EngineStates.Engine_backToInter)
            return "../../Images/Engine_inter.png"
        else if (state === EngineIcon.EngineStates.Engine_on)
            return "../../Images/Engine_on.png"
    }

    function setEngineState(previousState, buttonClicked) {
        if (previousState === EngineIcon.EngineStates.Engine_off && buttonClicked === EngineIcon.ButtonClicked.Left)
            return EngineIcon.EngineStates.Engine_inter
        else if((previousState === EngineIcon.EngineStates.Engine_inter || previousState === EngineIcon.EngineStates.Engine_backToInter ) && buttonClicked === EngineIcon.ButtonClicked.Left)
            return EngineIcon.EngineStates.Engine_off
        else if ((previousState === EngineIcon.EngineStates.Engine_inter || previousState === EngineIcon.EngineStates.Engine_backToInter ) && buttonClicked === EngineIcon.ButtonClicked.Right)
            return EngineIcon.EngineStates.Engine_on
        else if (previousState === EngineIcon.EngineStates.Engine_on && buttonClicked === EngineIcon.ButtonClicked.Right)
            return EngineIcon.EngineStates.Engine_backToInter
        else return previousState
    }
}
