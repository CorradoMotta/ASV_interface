/*************************************************************************
 *
 * Plugin element to use MapBox tiles.
 * The cache directory can be set on the configuration file.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtPositioning 5.15
import QtLocation 5.15

Plugin {
    id: mapbox_plugin
    name: "mapboxgl"
    PluginParameter { name: "mapboxgl.access_token"; value: "pk.eyJ1IjoibWFzc2ltb2NhY2NpYSIsImEiOiJjbDF5c2w2cDQwZndqM2RucnZ3Y3NjMDdjIn0.qBzdHy57FexjF3Aj-qps4g" }
    PluginParameter { name: "mapboxgl.mapping.cache.directory" ; value: data_model.data_source.swamp_status.conf.mb_offline_db}
}
