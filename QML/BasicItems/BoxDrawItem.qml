// item that stores the boxes used to draw points, lines etc. on the map.

import QtQuick 2.0
import "../Panels"
Item {
    id: boxRectangle
    property bool isActive: false
    property bool isImplemented: false
    property alias pre_width: image_box_rectangle.implicitWidth
    property alias pre_heigth: image_box_rectangle.implicitHeight
    property alias source: image_box_rectangle.source

    Image {
        id: image_box_rectangle
        visible: true
        sourceSize.width: 70
        sourceSize.height: 70
        opacity: boxRectangle.isActive?  1 : 0.65
        scale: mouseArea_rect.containsMouse ? 1.0 : 0.8

        MouseArea {
            id: mouseArea_rect
            anchors.fill: parent
            //anchors.margins: parent
            hoverEnabled: true

            onClicked: {
                if(!boxRectangle.isImplemented) messagePrompt("This functionality is not implemented yet.")
                else{
                    if (!boxRectangle.isActive) {
                        if(box_draw_panel.draw_item_is_active === BoxDrawPanel.ActiveBox.None)
                            boxRectangle.isActive = true
                    } else
                        boxRectangle.isActive = false
                }
            }
        }
    }
}

