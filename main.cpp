#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QSslSocket>
#include "singlemarkermodel.h"
#include <QQmlContext>
#include <QQmlComponent>
#include "qmlmqttclient.h"
#include "variable.h"
#include "doublevariable.h"
#include "intvariable.h"
#include "stringvariable.h"
#include "gps_ahrs_status.h"
#include "QString"
#include "swampstatus.h"
#include "datasource.h"
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    SingleMarkerModel model;
    QmlMqttClient client;
    //GPS_AHRS_status gps_status;
    QQmlApplicationEngine engine;
    DataSource dataSource;
    //SwampStatus swamp_status;

    qmlRegisterUncreatableType<Variable>("com.cnr.property",1,0,"Variable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<DoubleVariable>("com.cnr.property",1,0,"DoubleVariable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<IntVariable>("com.cnr.property",1,0,"IntVariable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<StringVariable>("com.cnr.property",1,0,"StringVariable", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<GPS_AHRS_status>("com.cnr.property",1,0,"GPS_AHRS_status", "Virtual class cannot be instantiated!");
    qmlRegisterUncreatableType<SwampStatus>("com.cnr.property",1,0,"SwampStatus", "Virtual class cannot be instantiated!");

    //engine.rootContext()->setContextProperty("swamp_status", &swamp_status);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.rootContext()->setContextProperty(QStringLiteral("dataSource"), &dataSource);
    engine.rootContext()->setContextProperty(QStringLiteral("_marker_model"), &model);
    engine.rootContext()->setContextProperty(QStringLiteral("mqtt_client"), &client);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);
    return app.exec();
}
