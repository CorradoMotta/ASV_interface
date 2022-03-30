import QtQuick 2.0
import QtQuick.Layouts 1.15

Image {
    Layout.alignment: Qt.AlignLeft
    //source: "Images/ArrowUp.png"
    property int size: 25
    property alias action : arrow_ma
    sourceSize.height: size
    sourceSize.width: size
    MouseArea: {
        id: arrow_ma
    }
}
