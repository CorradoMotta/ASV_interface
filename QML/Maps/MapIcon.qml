/*************************************************************************
 *
 * Display an icon on map.
 *
 * Author: Corrado Motta
 * Date: 11/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0

Rectangle{
    id: set_north_arrow
    implicitWidth: set_image.implicitWidth
    implicitHeight: set_image.implicitHeight
    color: "transparent"

    property int img_size: 60
    property alias img_source: set_image.source
    property alias img_opacity: set_image.opacity

    Image {
        id: set_image
        visible: true
        opacity: 0.8
        sourceSize.width: img_size
        sourceSize.height: img_size
    }
}
