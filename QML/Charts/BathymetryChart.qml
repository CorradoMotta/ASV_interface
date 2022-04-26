import QtQuick 2.0
import QtCharts 2.3

Rectangle {

    property point newPoint : Qt.point(0,0)
    property real yMIN : 0
    property real xMIN : 0
    property real yMAX
    property real xMAX : 500.0

    anchors.fill: parent
    anchors.margins: 100

    onNewPointChanged: {
        if(newPoint.x > xMAX) xMAX = newPoint.x + 100
        lineSeries.append(newPoint.x, newPoint.y);
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
                min: yMAX
                max: xMAX
            },
            ValueAxis{
                id: yAxis
                min: yMIN
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
}
