#include <QtWidgets/QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QQmlContext>

#include "map_models/singlemarkermodel.h"
#include "map_models/bathymetrymodel.h"
#include "map_models/coordinate_model.h"
#include "data/HciNgiInterface.h"
#include "generic/robotmath.h"
#include "swamp_models/swampstatus.h"
#include "swamp_models/datasource.h"
#include "swamp_models/swampmodel.h"
#include "swamp_models/datasource_udp.h"
#include "metadata/globalmetadata.h"
#include <QPalette>
#include <QJoysticks.h>
#include <QStyleFactory>
#include <QThread>
#include <QStandardPaths>


#ifdef Q_OS_WIN
#   ifdef main
#      undef main
#   endif
#endif

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QApplication app(argc, argv);
    app.setOrganizationName("CNR");
    app.setOrganizationDomain("CNR_HCI");

#ifdef Q_OS_WIN
    QString extraImportPath(QStringLiteral("%1/../../../../%2"));
#else
    QString extraImportPath(QStringLiteral("%1/../../../%2"));
#endif

    //qDebug() << "Network binding:" << argv[1];
    QString networkBinding = "empty";
    if(argc == 2) networkBinding = argv[1];
    networkBinding = networkBinding.toLower().trimmed();


    BathymetryModel bath_model("Bathymetry");
    Coordinate_model coors_model;
    SwampModel data_model;
    QQmlApplicationEngine engine;

    DataSource *dataSource;
    dataSource = new DataSourceUdp(&data_model);


    bool sourceIsValid = dataSource->set_cfg("../ASV_interface/conf/conf.ini");
    if(! sourceIsValid) exit(-1);

    data_model.set_data_source(dataSource);
    GlobalMetadata metadata(dataSource->swamp_status()->conf()->jsonPath());
    QJoysticks *instance = QJoysticks::getInstance();

    // set types to be available in qml
    qmlRegisterUncreatableType<HciNgiInterface>("com.cnr.property",1,0,"HciNgiInterface", "Not creatable as it is an enum type.");

    const QUrl url(QStringLiteral("qrc:/QML/main.qml"));
    qDebug() << "Mapbox cache file stored in:" << QStandardPaths::writableLocation(QStandardPaths::GenericCacheLocation);


    // models
    SingleMarkerModel marker_model(dataSource->swamp_status()->conf()->origin());
    SingleMarkerModel line_model;
    SingleMarkerModel multiple_marker_model(dataSource->swamp_status()->conf()->origin());

    // set context properties, one for each model
    engine.rootContext()->setContextProperty(QStringLiteral("_metadata"), &metadata);
    engine.rootContext()->setContextProperty(QStringLiteral("_marker_model"), &marker_model);
    engine.rootContext()->setContextProperty(QStringLiteral("_bathymetry_model"), &bath_model);
    engine.rootContext()->setContextProperty(QStringLiteral("_line_model"), &line_model);
    engine.rootContext()->setContextProperty(QStringLiteral("_multiple_marker_model"), &multiple_marker_model);
    engine.rootContext()->setContextProperty(QStringLiteral("data_model"), &data_model);
    engine.rootContext()->setContextProperty(QStringLiteral("_coor_model"), &coors_model);
    engine.rootContext()->setContextProperty("QJoysticks", instance);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}
