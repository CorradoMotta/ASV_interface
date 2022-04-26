import QtQuick 2.0
import QtCharts 2.3

Rectangle {
    anchors.fill: parent
    anchors.margins: 100
    //anchors.margins: 200
    property var new_point : Qt.point(0,0)
    property real newx : 0
    property real newy : 0
    property real yMAX : 0.6
    property real xMAX : 500.0

    onNew_pointChanged: {
        if(new_point.y > yMAX) yMAX = new_point.y + 0.3
        if(new_point.x > xMAX) xMAX = new_point.x + 100
        lineSeries.append(new_point.x, new_point.y);
    }

    onNewyChanged:{

        newx += 10
        if(newy > yMAX) yMAX = newy + 0.3
        if(newx > xMAX) xMAX = newx + 100
        lineSeries.append(newx, newy);
        //othersSlice = lineSeries.append(newx, newy);
    }

    ChartView {
        title: "Bathymetry"
        //titleFont: "helvetics"
        theme: ChartView.ChartThemeBlueIcy
        titleFont.family: "Helvetica"; titleFont.pointSize: 13; titleFont.bold: true
        anchors.fill: parent
        antialiasing: true

        axes: [
            ValueAxis{
                id: xAxis
                min: 0.0
                max:  xMAX
            },
            ValueAxis{
                id: yAxis
                min: 0.4
                max: yMAX
            }
        ]
        LineSeries {
            id: lineSeries
            name: "Depth"
            axisX: xAxis
            axisY: yAxis
        }
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            newx += 30
            newy = Math.random() * 10
            if(newy > yMAX) yMAX = newy + 30
            if(newx > xMAX) xMAX = newx + 40
            //othersSlice = lineSeries.append(newx, newy);
        }
    }
}
