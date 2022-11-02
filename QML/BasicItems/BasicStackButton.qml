/*************************************************************************
 *
 * This element is used to open the stack view that contains the minion
 * tab view. It uses the boolean open_minion to control the stacking.
 *  process via pop() and push() methods.
 *
 * Author: Corrado Motta
 * Date: 06/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle {
    color: "aliceblue"
    property bool open_minion: true

    Image {
        id: image_button
        anchors.centerIn: parent
        opacity: 0.7
        visible: true
        source: open_minion? "../../Images/arrow_open.png" : "../../Images/arrow_close.png"
        scale: 0.07
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(open_minion){
                    push_view()
                }else{
                    pop_view()
                }
            }
        }
    }

    function push_view(){
        if(data_model.data_source.is_connected){
            stack.push(minion_view)
            open_minion = false
        }else messagePrompt("Connection is not established. Please connect first.")
    }

    function pop_view(){
        stack.pop()
        open_minion = true
    }
}
