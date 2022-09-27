/*************************************************************************
 *
 * Panel to enable and disable thrust and azimuth simultaneously for each
 * engine. Each engine is of EngineIcon type.
 * The panel is delimited by a rectangle with black border.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

Rectangle {
    id: swamp_engine

    // properties
    Layout.preferredHeight: engine_icons.implicitHeight + 30
    radius: 5.0

    border {
        color: "black"
        width: 2
    }

    // custom properties
    property double timestamp: 0

    // alias
    property alias engine_state_fl: engine_icon_fl.engineState
    property alias engine_state_fr: engine_icon_fr.engineState
    property alias engine_state_rr: engine_icon_rr.engineState
    property alias engine_state_rl: engine_icon_rl.engineState

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
}
