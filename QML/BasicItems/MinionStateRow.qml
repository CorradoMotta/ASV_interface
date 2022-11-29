/*************************************************************************
 *
 * This element contains two fault dots and one status dot.
 * It helps to see the status of a minion and its engines.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.11

Item {
    property int dotSize
    property real oldTimeMs: 0
    required property var prefix
    required property string info_prefix
    required property int pump_jet_status

    implicitWidth: status_row.implicitWidth
    implicitHeight: status_row.implicitHeight

    RowLayout{
        id: status_row
        spacing: 15
        anchors.fill: parent
        FaultDot{
            id: pump_jet_dot
            off_color: "lightgray"
            label_on_side: true
            info_text: info_prefix + "_" + "Pump_jet"
            dot_state: pump_jet_status
            width: dotSize
            height: dotSize
        }
        StatusDot{
            id: power_dot
            info_text: info_prefix + "_" + "Engine"
            dot_state: (prefix.minionState.thrustMotorEnable.value & prefix.minionState.thrustMotorPower.value & prefix.minionState.azimuthMotorEnable.value & prefix.minionState.azimuthMotorPower.value)
            off_color: "lightgray"
            label_on_side: true
            width: dotSize
            height: dotSize
        }
        FaultDot{
            id: fault_dot
            off_color: "lightgray"
            label_on_side: true
            info_text: info_prefix + "_" + "Fault"
            dot_state: (prefix.minionState.thrustMotorFault.value | prefix.minionState.azimuthMotorFault.value)
            width: dotSize
            height: dotSize
        }
        FaultDot{
            id: alive_dot
            info_text: info_prefix + "_" + "Alive"
            off_color: "lightgray"
            label_on_side: true
            dot_state: prefix.minionState.is_alive.value
            width: dotSize
            height: dotSize
        }
    }
}
