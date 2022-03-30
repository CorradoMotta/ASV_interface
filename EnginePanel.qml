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
            onEngineStateChanged: {
                if (engineState === EngineIcon.EngineStates.Engine_inter) {

                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f1.thr_power.topic_name,1)
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f1.azm_power.topic_name,1)
                }
                if (engineState === EngineIcon.EngineStates.Engine_on) {
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f1.thr_enable.topic_name,1)
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f1.azm_enable.topic_name,1)
                }
            }
        }
        EngineIcon {
            id: engine_icon_fr
            engineIconText: "FR"
            onEngineStateChanged: {
                if (engineState === EngineIcon.EngineStates.Engine_inter) {
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f2.thr_power.topic_name,1)
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f2.azm_power.topic_name,1)
                }
                if (engineState === EngineIcon.EngineStates.Engine_on) {
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f2.thr_enable.topic_name,1)
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f2.azm_enable.topic_name,1)
                }
            }
        }
        EngineIcon {
            id: engine_icon_rl
            engineIconText: "RL"
            onEngineStateChanged: {
                if (engineState === EngineIcon.EngineStates.Engine_inter) {
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f3.thr_power.topic_name,1)
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f3.azm_power.topic_name,1)
                }
                if (engineState === EngineIcon.EngineStates.Engine_on) {
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f3.thr_enable.topic_name,1)
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f3.azm_enable.topic_name,1)
                }
            }
        }
        EngineIcon {
            id: engine_icon_rr
            engineIconText: "RR"
            onEngineStateChanged: {
                if (engineState === EngineIcon.EngineStates.Engine_inter) {
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f4.thr_power.topic_name,1)
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f4.azm_power.topic_name,1)
                }
                if (engineState === EngineIcon.EngineStates.Engine_on) {
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f4.thr_enable.topic_name,1)
                    data_model.data_source.publishMessage(data_model.data_source.swamp_status.motor_status.f4.azm_enable.topic_name,1)
                }
            }
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
