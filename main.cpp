#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>

#include "map_models/singlemarkermodel.h"
#include "map_models/bathymetrymodel.h"
#include "data/variable.h"
#include "data/doublevariable.h"
#include "data/intvariable.h"
#include "data/stringvariable.h"
#include "swamp_models/swampstatus.h"
#include "swamp_models/datasource.h"
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

    qDebug() << "Network binding:" << argv[1];
    QString networkBinding = "empty";
    if(argc == 2) networkBinding = argv[1];
    networkBinding = networkBinding.toLower().trimmed();

    SingleMarkerModel marker_model;
    SingleMarkerModel line_model;
    BathymetryModel bath_model("Bathymetry");
    SwampModel data_model;
    QQmlApplicationEngine engine;

    DataSource *dataSource;
    if(networkBinding =="mqtt")  dataSource= new DataSourceMqtt(&data_model);
    else if(networkBinding =="udp") dataSource = new DataSourceUdp(&data_model);
    else {qDebug() << "Input network binding not recognized or available : " << networkBinding; exit(-1);}

    // to do move in a conf file.
    bool sourceIsValid = dataSource->set_cfg("../ASV_interface/conf/udp_address.cfg");
    if(! sourceIsValid) exit(-1);

    data_model.set_data_source(dataSource);

    // set types to be available in qml
    qmlRegisterUncreatableType<Variable>("com.cnr.property",1,0,"Variable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<DoubleVariable>("com.cnr.property",1,0,"DoubleVariable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<IntVariable>("com.cnr.property",1,0,"IntVariable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<StringVariable>("com.cnr.property",1,0,"StringVariable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<SwampStatus>("com.cnr.property",1,0,"SwampStatus", "Virtual class cannot be instantiated!");

    const QUrl url(QStringLiteral("qrc:/QML/main.qml"));

    // set context properties, one for each model
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
