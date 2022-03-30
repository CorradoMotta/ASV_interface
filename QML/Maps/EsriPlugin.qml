import QtQuick 2.0
import QtPositioning 5.15
import QtLocation 5.15

Plugin {
    id: esri_plugin
    name: "mapboxgl"

    enum Esri_maps {
        Vector,
        Satellite
    }
}
