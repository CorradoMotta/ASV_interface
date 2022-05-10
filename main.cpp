#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QSslSocket>
#include "map_models/singlemarkermodel.h"
#include "map_models/bathymetrymodel.h"
#include <QQmlContext>
#include <QtQuick/QQuickView>
#include <QQmlComponent>
#include "data/variable.h"
#include "data/doublevariable.h"
#include "data/intvariable.h"
#include "data/stringvariable.h"
#include "components/gps_ahrs_status.h"
#include "QString"
#include "swamp_models/swampstatus.h"
#include "swamp_models/datasource.h"
#include "components/ngc_status.h"
#include "components/motor_status.h"
#include "components/swamp_motor_status.h"
#include "swamp_models/swampmodel.h"
#include "swamp_models/datasource_udp.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);

#ifdef Q_OS_WIN
    QString extraImportPath(QStringLiteral("%1/../../../../%2"));
#else
    QString extraImportPath(QStringLiteral("%1/../../../%2"));
#endif

    SingleMarkerModel marker_model;
    SingleMarkerModel line_model;
    BathymetryModel bath_model("Bathymetry");
    SwampModel data_model;
    QQmlApplicationEngine engine;


    // change depending on network binding
    DataSource *dataSource = new DataSourceUdp(&data_model);
    //DataSource *dataSource = new DataSourceMqtt(&data_model);

    //qDebug() << QGuiApplication::applicationPid ();
    bool sourceIsValid = dataSource->set_cfg("../ASV_interface/conf/topics.cfg");
    if(! sourceIsValid) exit(-1);

//    sourceIsValid = dataSource->read_cfg_minion("../ASV_interface/conf/topics_minion.cfg");
//    if(! sourceIsValid) exit(-1);

    data_model.set_data_source(dataSource);

    qmlRegisterUncreatableType<Variable>("com.cnr.property",1,0,"Variable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<DoubleVariable>("com.cnr.property",1,0,"DoubleVariable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<IntVariable>("com.cnr.property",1,0,"IntVariable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<StringVariable>("com.cnr.property",1,0,"StringVariable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<SwampStatus>("com.cnr.property",1,0,"SwampStatus", "Virtual class cannot be instantiated!");

    const QUrl url(QStringLiteral("qrc:/QML/main.qml"));
    engine.rootContext()->setContextProperty(QStringLiteral("dataSource"), dataSource);
    engine.rootContext()->setContextProperty(QStringLiteral("_marker_model"), &marker_model);
    engine.rootContext()->setContextProperty(QStringLiteral("_bathymetry_model"), &bath_model);
    engine.rootContext()->setContextProperty(QStringLiteral("_line_model"), &line_model);
    engine.rootContext()->setContextProperty(QStringLiteral("data_model"), &data_model);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);
    return app.exec();

}
