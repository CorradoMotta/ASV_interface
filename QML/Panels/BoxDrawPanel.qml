import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../BasicItems"

Item {
    id : box_draw_panel
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.rightMargin: 20
    anchors.bottomMargin: 20
    implicitHeight: cl.implicitHeight
    implicitWidth: cl.implicitWidth
    property int draw_item_is_active : BoxDrawPanel.ActiveBox.None

    enum ActiveBox {
        None,
        Rectangle,
        Marker,
        Line
    }

    ColumnLayout{
        id: cl
        anchors.fill: parent

        BoxDrawItem{
            id: rectangle_box_item
            Layout.preferredHeight: pre_heigth
            Layout.preferredWidth: pre_width
            source: isActive? "../../Images/Rectangle_box_on.png" : "../../Images/rect_box.png"
            isImplemented: false
            onIsActiveChanged: isActive? draw_item_is_active = BoxDrawPanel.ActiveBox.Rectangle : draw_item_is_active = BoxDrawPanel.ActiveBox.None
        }
        BoxDrawItem{
            id: rectangle_marker_item
            Layout.preferredHeight: pre_heigth
            Layout.preferredWidth: pre_width
            source: isActive? "../../Images/marker_box_on.png" : "../../Images/marker_box.png"
            isImplemented: true
            onIsActiveChanged: isActive? draw_item_is_active = BoxDrawPanel.ActiveBox.Marker : draw_item_is_active = BoxDrawPanel.ActiveBox.None
        }
        BoxDrawItem{
            id: rectangle_list_item
            Layout.preferredHeight: pre_heigth
            Layout.preferredWidth: pre_width
            source: isActive? "../../Images/line_box_on.png" : "../../Images/line_box.png"
            isImplemented: true
            onIsActiveChanged: isActive? draw_item_is_active = BoxDrawPanel.ActiveBox.Line : draw_item_is_active = BoxDrawPanel.ActiveBox.None
        }
    }
}
