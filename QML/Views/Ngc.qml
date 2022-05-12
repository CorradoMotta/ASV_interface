import QtQuick 2.0
import com.cnr.property 1.0
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.15
import "../BasicItems"
import "../Panels"

BasicMinionPanelContainer{
    id : root
    implicitHeight: Math.max(cmd_row.implicitHeight , cmd_row_2.implicitHeight) + title_height + 20
    implicitWidth: cmd_row.implicitWidth + cmd_row_2.implicitWidth + bar.width + 200 // TODO WHY SO MUCH
    title: "NGC"
    color: "whitesmoke"
    //border.color: "transparent"
    RowLayout{
        id: cmd_row
        spacing: 2
        //width: parent.width/2
        anchors{
            topMargin: 5
            //fill: parent
            top: parent.top; left: parent.left; bottom: parent.bottom; right: bar.right
            rightMargin: 10
            leftMargin: 10
        }
        ColumnLayout{
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: 10
        BasicSwitch{
            switch_text: "NGC_ENABLE"
            // TODO
//            onSwitch_is_activeChanged: switch_is_active? minion_view.publish_topic(minion_view.log_tn, 1)
//                                                       : minion_view.publish_topic(minion_view.log_tn, 0)
        }
        RpmPanel{
            Layout.fillWidth: true
            Layout.rightMargin: 10
            Layout.alignment: Qt.AlignTop
            clip: true
        }
        }

    }
    Rectangle {
        id: bar
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: title_height + 20
            bottomMargin: 30
            bottom: parent.bottom
        }
        width: 2
        color: "gray"
    }
    RowLayout{
        id: cmd_row_2
        spacing: 2
        //width: parent.width/2
        anchors{
            topMargin: 20
            leftMargin: 10
            top: parent.top; right: parent.right; bottom: parent.bottom; left: bar.right
            rightMargin: 10
        }
    }
}

