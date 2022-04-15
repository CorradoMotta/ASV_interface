import QtQuick 2.0
import QtQuick.Layouts 1.15

Item  {
    id: reboot_icon_root
    implicitHeight: reboot_image.implicitHeight + 5
    implicitWidth: reboot_image.implicitWidth + 5
    property int image_size: 50

    enum RebootStates {
        Shutdown,
        Reboot
    }

    property int rebootState: BasicRebootIcon.RebootStates.Shutdown

    function setSource(state) {
        if (state === BasicRebootIcon.RebootStates.Shutdown)
            return "../../Images/off_button.png"
        else if (state === BasicRebootIcon.RebootStates.Reboot)
            return "../../Images/on_button.png"
    }

    function setRebootState(previousState) {
        if (previousState === BasicRebootIcon.RebootStates.Shutdown)
            return BasicRebootIcon.RebootStates.Reboot
        else if (previousState === BasicRebootIcon.RebootStates.Reboot)
            return BasicRebootIcon.RebootStates.Shutdown
    }

    ColumnLayout {
        id: coln
        anchors.fill: parent
            Image {
                id: reboot_image
                anchors.horizontalCenterOffset: 4
                anchors.verticalCenterOffset: 3
                visible: true
                source: setSource(rebootState)
                sourceSize.width: reboot_icon_root.image_size
                sourceSize.height: reboot_icon_root.image_size
            }
    }
    MouseArea {
        id: ma
        anchors.fill: parent
        onClicked: rebootState = setRebootState(rebootState)
    }
}
