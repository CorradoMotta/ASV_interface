import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

Rectangle {
    id: set_homing

    // alias property
    property alias set_home_is_active : set_home.pressed
    property alias go_home_is_active: go_home.pressed
    property alias set_angle_is_active: set_angle.pressed

    // azimuth and pump ref values
    property var prefix: data_model.data_source.swamp_status.ngc_status
    readonly property real asvRefazimuthFL : prefix.asvRefazimuthFL.value // azimuth[FL]
    readonly property real asvRefazimuthFR : prefix.asvRefazimuthFR.value // azimuth[FR]
    readonly property real asvRefazimuthRR : prefix.asvRefazimuthRR.value // azimuth[RR]
    readonly property real asvRefazimuthRL : prefix.asvRefazimuthRL.value // azimuth[RL]
    readonly property real asvRefnFL : prefix.asvRefnFL.value // n[FL]
    readonly property real asvRefnFR : prefix.asvRefnFR.value // n[FR]
    readonly property real asvRefnRR : prefix.asvRefnRR.value // n[RR]
    readonly property real asvRefnRL : prefix.asvRefnRL.value // n[RL]

    Layout.preferredHeight: row_id.implicitHeight
    radius: 5.0
    border {
        color: "black"
        width: 2
    }

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
