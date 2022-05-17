import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

Rectangle {
    id: swamp_engine
    property double timestamp: 0
    property alias engine_state_fl: engine_icon_fl.engineState
    property alias engine_state_fr: engine_icon_fr.engineState
    property alias engine_state_rr: engine_icon_rr.engineState
    property alias engine_state_rl: engine_icon_rl.engineState
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
        spacing: 2

        EngineIcon {
            id: engine_icon_fl
            engineIconText: "FL"
        }
        EngineIcon {
            id: engine_icon_fr
            engineIconText: "FR"
        }
        EngineIcon {
            id: engine_icon_rl
            engineIconText: "RL"
        }
        EngineIcon {
            id: engine_icon_rr
            engineIconText: "RR"
        }
    }

    //    function publish_engine_data(topic, value) {


    //                var s_id = ""
    //                var topic = "CNR-INM/swamp/motor/digital/"
    //                var value = "1 " + timestamp + " 1"

    //                if (state === EngineIcon.EngineStates.Engine_inter) {
    //                    s_id = ID + "-THR-power"
    //                    topic = "CNR-INM/swamp/motor/digital/" + s_id
    //                    data_model.publishMessage(topic, value)

    //                    s_id = ID + "-AZM-power"
    //                    topic = "CNR-INM/swamp/motor/digital/" + s_id
    //                    data_model.publishMessage(topic, value)
    //                }
    //                if (state === EngineIcon.EngineStates.Engine_on) {
    //                    s_id = ID + "-THR-enable"
    //                    topic = "CNR-INM/swamp/motor/digital/" + s_id
    //                    data_model.publishMessage(topic, value)

    //                    s_id = ID + "-AZM-enable"
    //                    topic = "CNR-INM/swamp/motor/digital/" + s_id
    //                    data_model.publishMessage(topic, value)
    //                }
    //    }
}
