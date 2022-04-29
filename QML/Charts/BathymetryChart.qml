import QtQuick 2.0
import QtCharts 2.3

Rectangle {
    readonly property real initialyMax : -10.0
    readonly property real initialxMax : 500.0
    property point newPoint : Qt.point(0,0)
    property bool reset: false
    property real yMIN : 0
    property real xMIN : 0
    property real yMAX : initialyMax // TODO should be a cost value
    property real xMAX : initialxMax

    anchors.fill: parent
    anchors.margins: 100

    onNewPointChanged: {
        if(newPoint.x > xMAX) xMAX = newPoint.x + 100
        if(newPoint.y < yMAX) yMAX = newPoint.y - 5
        lineSeries.append(newPoint.x, newPoint.y);
    }

    onResetChanged: {
        reset = false
        yMAX = initialyMax
        xMAX = initialxMax
        lineSeries.clear()
    }

    ChartView {
        title: "Bathymetry"
        theme: ChartView.ChartThemeBlueIcy
        titleFont{
            family: "Helvetica"
            pointSize: 13
            bold: true
        }
        anchors.fill: parent
        antialiasing: true

        axes: [
            ValueAxis{
                id: xAxis
                min: xMIN
                max: xMAX
            },
            ValueAxis{
                id: yAxis
                min: yMAX
                max: yMIN
            }
        ]
        LineSeries {
            id: lineSeries
            name: "Depth"
            axisX: xAxis
            axisY: yAxis
        }
    }
}
