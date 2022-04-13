/*************************************************************************
 *
 * This element is used to open the stack view that contains the minion
 * tab view. It uses the boolean open_minion to control the stacking.
 *  process via pop() and push() methods.
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle {
    property bool open_minion: true
    color: "#100000FF"
    //width: 20
    Image {
        id: image_button
        anchors.centerIn: parent
        opacity: 0.7
        visible: true
        source: open_minion? "../../Images/arrow_open.png" : "../../Images/arrow_close.png"
        scale: 0.05
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(open_minion){
                    stack.push(minion_view)
                    open_minion = false
                }else{
                    stack.pop()
                    open_minion = true
                }
            }
        }
    }
}
