// item that stores the boxes used to draw points, lines etc. on the map.

import QtQuick 2.0

Item {
    id: boxRectangle
    property bool isActive: false
    property alias pre_width: image_box_rectangle.implicitWidth
    property alias pre_heigth: image_box_rectangle.implicitHeight
    property alias source: image_box_rectangle.source

    Image {
        id: image_box_rectangle
        visible: true
        //source:
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
                if (!boxRectangle.isActive) {
                    console.log("isActive")
//                        map.drawRectangle = true
//                        image_box_rectangle.opacity = 1
                    boxRectangle.isActive = true

                } else {
                        console.log("isNotActive")
                    boxRectangle.isActive = false
                }
            }
        }
    }
}
