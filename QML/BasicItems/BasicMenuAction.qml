/*************************************************************************
 *
 * It represents an action on a Menu. The action refers to the possible
 * modes that can be selected on different Menu items.
 * When the mode is clicked, this action will publish the change. An icon
 * is displayed next to the current mode (reference value)
 * as reported from the vehicle.
 *
 * Author: Corrado Motta
 * Date: 10/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Controls 2.15

Action {

    required property int enum_value
    required property int topic_id
    required property var enum_ref
    readonly property var publish_topic: data_model.data_source.publishMessage

    checkable: true
    enabled: data_model.data_source.is_connected
    icon.source: enum_ref === enum_value? "../../Images/selection_2.png": ""; //../../Images/selection_empty.png
    onCheckedChanged: checked? data_model.data_source.is_connected? publish_topic(topic_id, enum_value): "" : ""
}
