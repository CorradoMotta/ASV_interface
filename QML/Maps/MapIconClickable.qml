/*************************************************************************
 *
 * Display an icon on map. The icon is clickable. A signal named click is
 * emitted when the icon is clicked.
 *
 * Author: Corrado Motta
 * Date: 11/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle{
    id: root
    implicitWidth: set_image.implicitWidth
    implicitHeight: set_image.implicitHeight
    color: "transparent"
    signal click
    property alias img_source: set_image.source
    property alias img_opacity: set_image.opacity
    property alias ma_enabled: mouseArea_rect.enabled
    property bool enable_scale: true
    property int img_size: 60

    Image {
        id: set_image
        enabled: data_model.data_source.is_connected
        opacity: data_model.data_source.is_connected? 1: 0.3
        visible: true
        sourceSize.width: img_size
        sourceSize.height: img_size
        scale: enable_scale? mouseArea_rect.containsMouse ? 1.0 : 0.8 : ""

        MouseArea {
            id: mouseArea_rect
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.click()
        }
    }
}
