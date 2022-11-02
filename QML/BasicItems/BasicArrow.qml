/*************************************************************************
 *
 * Simple arrow used to increment or decrement a slider.
 *
 * Author: Corrado Motta
 * Date: 06/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15

Image {

    sourceSize.height: size
    sourceSize.width: size

    property int size: 25
    property alias action : arrow_ma

    MouseArea: {
        id: arrow_ma
    }
}
