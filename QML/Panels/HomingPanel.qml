/*************************************************************************
 *
 * Panel that allows to make all azimuth to go home, set angle and set new
 * home. Besides that, it shows the vehicle with the actual azimuth and
 * thrust values for each engine, next to them.
 *
 * Author: Corrado Motta
 * Date: 07/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

Rectangle {
    id: set_homing

    // properties
    Layout.preferredHeight: row_id.implicitHeight
    radius: 5.0
    border {
        color: "black"
        width: 2
    }

    // custom properties
    property var prefix: data_model.data_source.swamp_status.ngc.ngc_status

    // alias property
    property alias set_home_is_active : set_home.pressed
    property alias go_home_is_active: go_home.pressed
    property alias set_angle_is_active: set_angle.pressed

    // Cpp members
    readonly property real asvRefazimuthFL : data_model.data_source.swamp_status.minion_fl.minionState.azimuthMotorAngle.value //prefix.asvRefazimuthFL.value // azimuth[FL]
    readonly property real asvRefazimuthFR : data_model.data_source.swamp_status.minion_fr.minionState.azimuthMotorAngle.value //prefix.asvRefazimuthFR.value // azimuth[FR]
    readonly property real asvRefazimuthRR : data_model.data_source.swamp_status.minion_rr.minionState.azimuthMotorAngle.value //prefix.asvRefazimuthRR.value // azimuth[RR]
    readonly property real asvRefazimuthRL : data_model.data_source.swamp_status.minion_rl.minionState.azimuthMotorAngle.value //prefix.asvRefazimuthRL.value // azimuth[RL]
    readonly property real asvRefnFL :data_model.data_source.swamp_status.minion_fl.minionState.thrustMotorSpeed.value // prefix.asvRefnFL.value // n[FL]
    readonly property real asvRefnFR :data_model.data_source.swamp_status.minion_fr.minionState.thrustMotorSpeed.value // prefix.asvRefnFR.value // n[FR]
    readonly property real asvRefnRR :data_model.data_source.swamp_status.minion_rr.minionState.thrustMotorSpeed.value // prefix.asvRefnRR.value // n[RR]
    readonly property real asvRefnRL :data_model.data_source.swamp_status.minion_rl.minionState.thrustMotorSpeed.value // prefix.asvRefnRL.value // n[RL]

    RowLayout{
        id: row_id
        anchors.fill: parent
        Layout.topMargin: 10
        ColumnLayout{
            id: cmd_column_id
            Layout.leftMargin: 10
            spacing: 7

            BasicButton{
                id: go_home
                Layout.topMargin: 7
                text_on_button: "GO HOME"
                button_width: 200
            }
            BasicButton{
                id: set_angle
                text_on_button: "SET ANGLE"
                button_width: 200
            }
            BasicButton{
                id: set_home
                Layout.bottomMargin: 7
                text_on_button: "SET HOME"
                button_width: 200
            }
        }
        Rectangle{
            implicitWidth: image.width + fl_angle.implicitWidth *2
            implicitHeight: image.height
            Layout.alignment: Qt.AlignHCenter
            color: "transparent"

            BasicRectangleOutput{
                id: fl_angle
                anchors.top: image.top
                anchors.right: image.left
                angle_text: asvRefazimuthFL
                align_right: true
                rpm_text: asvRefnFL
            }
            BasicRectangleOutput{
                id: fr_angle
                anchors.top: image.top
                anchors.left: image.right
                align_right: false
                angle_text: asvRefazimuthFR
                rpm_text: asvRefnFR
            }
            BasicRectangleOutput{
                id: rr_angle
                anchors.bottom: image.bottom
                anchors.left: image.right
                align_right: false
                angle_text: asvRefazimuthRR
                rpm_text: asvRefnRR
            }
            BasicRectangleOutput{
                id: rl_angle
                anchors.bottom: image.bottom
                anchors.right: image.left
                align_right: true
                angle_text: asvRefazimuthRL
                rpm_text: asvRefnRL
            }
            Image {
                id: image
                anchors.centerIn: parent
                source: "../../Images/Swamp.png"
                sourceSize.width: 100
                sourceSize.height: 100
                horizontalAlignment: Image.AlignHCenter
            }
        }
    }
}
