import QtQuick 2.0
import QtQuick.Layouts 1.15

Rectangle {
    id: swamp_engine
    property double timestamp: 0
    Layout.preferredHeight: engine_icons.implicitHeight + 30
    radius: 5.0

    border {
        color: "black"
        width: 2
    }

    RowLayout {
        id: engine_icons

        anchors.fill: parent
        anchors.leftMargin: 20
        //anchors.topMargin: 15
        spacing: 2

        EngineIcon {
            id: engine_icon_fl
            engineIconText: "FL"
            onEngineStateChanged: publish_engine_data(engineState,
                                                      engineIconText,
                                                      timestamp)
        }
        EngineIcon {
            id: engine_icon_fr
            engineIconText: "FR"
            onEngineStateChanged: publish_engine_data(engineState,
                                                      engineIconText,
                                                      timestamp)
        }
        EngineIcon {
            id: engine_icon_rl
            engineIconText: "RL"
            onEngineStateChanged: publish_engine_data(engineState,
                                                      engineIconText,
                                                      timestamp)
        }
        EngineIcon {
            id: engine_icon_rr
            engineIconText: "RR"
            onEngineStateChanged: publish_engine_data(engineState,
                                                      engineIconText,
                                                      timestamp)
        }
    }

    function publish_engine_data(state, ID, timestamp) {

        var s_id = ""
        var topic = "CNR-INM/swamp/motor/digital/"
        var value = "1 " + timestamp + " 1"

        if (state === EngineIcon.EngineStates.Engine_inter) {
            s_id = ID + "-THR-power"
            topic = "CNR-INM/swamp/motor/digital/" + s_id
            mqtt_client.publishMessage(topic, value)

            s_id = ID + "-AZM-power"
            topic = "CNR-INM/swamp/motor/digital/" + s_id
            mqtt_client.publishMessage(topic, value)
        }
        if (state === EngineIcon.EngineStates.Engine_on) {
            s_id = ID + "-THR-enable"
            topic = "CNR-INM/swamp/motor/digital/" + s_id
            mqtt_client.publishMessage(topic, value)

            s_id = ID + "-AZM-enable"
            topic = "CNR-INM/swamp/motor/digital/" + s_id
            mqtt_client.publishMessage(topic, value)
        }
    }
}
