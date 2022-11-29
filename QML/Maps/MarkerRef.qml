/*************************************************************************
 *
 * Marker model for placing a reference marker. I.e., a marker on the
 * point where the vehicle is going next. The marker is colored green.
 *
 * Author: Corrado Motta
 * Date: 11/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtPositioning 5.15
import QtLocation 5.15

MapQuickItem {
    id: marker_ref

    property alias label_text: info_label_coor_text.text
    anchorPoint.x: image_coor_ref.width / 2
    anchorPoint.y: image_coor_ref.height

    sourceItem: Image {
        id: image_coor_ref
        source: "../../Images/marker_ref.png"
        sourceSize.width: 40
        sourceSize.height: 40

        Rectangle{
            id: info_label_coor_ref
            z: 3
            anchors.bottom: image_coor_ref.top
            anchors.bottomMargin: - (info_label_coor_text.height/3)
            anchors.horizontalCenter: image_coor_ref.horizontalCenter
            width: info_label_coor_text.implicitWidth + 6
            height: info_label_coor_text.implicitHeight + 6
            color: "white"
            border.color: "black"
            visible: false

            Text{
                id: info_label_coor_text
                anchors.horizontalCenter: info_label_coor_ref.horizontalCenter
                anchors.verticalCenter: info_label_coor_ref.verticalCenter
                font.family: "helvetica"
                font.pixelSize: 14
            }
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled : true
            onEntered: info_label_coor_ref.visible = true
            onExited: info_label_coor_ref.visible = false
        }
    }
}
