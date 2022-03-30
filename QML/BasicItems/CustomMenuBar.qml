import QtQuick 2.0
import QtQuick.Controls 2.15

MenuBar {

    Menu {
        title: qsTr("&File")
        Action {
            text: qsTr("&Quit")
            onTriggered: Qt.quit()
        }
    }

    Menu {
        id: mapTypeMenu
        title: qsTr("MapType")
        // to add elements to my menu from a list i use the repeater element
        Repeater {
            model: navigation_map.supportedMapTypes
            MenuItem {
                text: navigation_map.plugin.name === "mapboxgl" ? model.description: model.name
                onTriggered: navigation_map.setActiveMap(model.index)
            }
        }
    }
}
