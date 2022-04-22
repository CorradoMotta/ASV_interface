import QtQuick 2.0
import QtCharts 2.3

Rectangle {
    anchors.fill: parent
    anchors.margins: 100
    //anchors.margins: 200
    property real newx : 1.1
    property real newy : 1.0
    property real yMAX : 12.0
    property real xMAX : 500.0
    property variant othersSlice: 0

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
                min: 0.0
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
