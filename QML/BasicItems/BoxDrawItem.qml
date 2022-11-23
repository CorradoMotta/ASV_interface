/*************************************************************************
 *
 * Row sets of buttons with icon used by the BoxDrawPanel.
 * It contains several boxes, with icons inside, that can be clicked.
 * Any box corresponds to a possible action on the map.
 *
 * Author: Corrado Motta
 * Date: 06/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import "../Panels"
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.0

Item {
    id: boxRectangle

    property bool isActive: false
    property bool isImplemented: false
    property alias pre_width: image_box_rectangle.implicitWidth
    property alias pre_heigth: image_box_rectangle.implicitHeight
    property alias source: image_box_rectangle.source

    RowLayout{
        anchors.fill: parent
        layoutDirection : Qt.RightToLeft
        spacing: -8

        Image {
            id: image_box_rectangle
            visible: true
            sourceSize.width: 70
            sourceSize.height: 70
            scale: mouseArea_rect.containsMouse ? 1.0 : 0.8

            MouseArea {
                id: mouseArea_rect
                anchors.fill: parent
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
        Image {
            id: image_box_remove
            visible: boxRectangle.isActive? true: false
            sourceSize.width: 70
            sourceSize.height: 70
            source: "../../Images/remove_box_on.png"
            scale: mouseArea_rect_remove.containsMouse ? 1.0 : 0.8

            MouseArea {
                id: mouseArea_rect_remove
                anchors.fill: parent
                hoverEnabled: true
                onClicked:navigation_map.resetMarker()
            }
        }
        Image {
            id: image_box_send
            visible: boxRectangle.isActive? true: false
            sourceSize.width: 70
            sourceSize.height: 70
            source: "../../Images/send_box_on.png"
            scale: boxRectangle.isActive? mouseArea_rect_send.containsMouse ? 1.0 : 0.8 : 0.8

            MouseArea {
                id: mouseArea_rect_send
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    var message = navigation_map.send_point()
                    root.messagePrompt(message)
                }
            }
        }
        Image {
            id: image_box_import
            visible: boxRectangle.isActive? true: false
            sourceSize.width: 70
            sourceSize.height: 70
            source: "../../Images/upload_box_on.png"
            scale: mouseArea_rect_import.containsMouse ? 1.0 : 0.8

            MouseArea {
                id: mouseArea_rect_import
                anchors.fill: parent
                hoverEnabled: true
                onClicked: fileDialog.open()
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            var message = navigation_map.uploadFile(fileDialog.fileUrl)
            root.messagePrompt(message)
        }
    }
}
