/*************************************************************************
 *
 * Main application window.
 *
 *************************************************************************/

import QtQuick 2.15
import QtQuick.Window 2.15
import QtPositioning 5.15
import QtLocation 5.15
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import QtQml 2.15

import "BasicItems"
import "Maps"
import "Panels"
import "Views"

ApplicationWindow {
    id: root

    visible: true
    title: qsTr("Swamp interface")

    property double pi_value: 3.1415926535

    // create custom bar
    menuBar: CustomMenuBar {
        id: menu_bar_id
    }

    // Main view is loaded here
    Loader{
        id: mainLoader

        anchors{
            top: menu_bar_id.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        // setting window size automatically
        onLoaded: {
            if(item.isMainView){
                root.minimumWidth = item.myWidth
                root.minimumHeight = item.myHeight + menu_bar_id.implicitHeight
                root.height = minimumHeight
                root.width = minimumWidth
            }
        }

        // set main component
        sourceComponent: MainView{
            id: main_view
        }
    }

    Rectangle{
        id: message_prompt

        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 100
        }

        width: Math.max(1100, text_prompt.implicitWidth + 200)
        height: text_prompt.implicitHeight + 10
        radius: 20
        color: "cornflowerblue"
        opacity: 0

        property alias message : text_prompt.text

        Text{
            id: text_prompt
            anchors.horizontalCenter: message_prompt.horizontalCenter
            anchors.verticalCenter: message_prompt.verticalCenter
            font.family: "Helvetica"
            font.pointSize: 14
        }
    }

    SequentialAnimation{

        id: message_prompt_anim

        NumberAnimation {
            target: message_prompt
            property: "opacity"
            from: 0.0; to: 1.0
            duration: 1000
        }
        PauseAnimation{
            duration: 2000
        }
        NumberAnimation {
            id: message_prompt_anim_disappear
            target: message_prompt
            property: "opacity"
            from: 1.0; to: 0
            duration: 600
        }
    }

    // =========
    // Functions
    // =========

    /*
     * Display the message prompt with the text given in input
     */
    function messagePrompt(prompt_text){

        message_prompt.message = prompt_text
        message_prompt_anim.running = true
    }

    /*
     * Convert measure from degrees to radiant
     */
    function convertToRadiant(value) {
        var value_in_radiant = value * 180 / pi_value
        return value_in_radiant
    }
}
