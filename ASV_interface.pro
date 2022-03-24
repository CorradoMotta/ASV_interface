QT += quick positioning mqtt

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        datasource.cpp \
        doublevariable.cpp \
        geometry.cpp \
        gps_ahrs_status.cpp \
        intvariable.cpp \
        main.cpp \
        qmlmqttclient.cpp \
        singlemarkermodel.cpp \
        stringvariable.cpp \
        swampmodel.cpp \
        swampstatus.cpp \
        variable.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    custom_types.h \
    datasource.h \
    define.h \
    doublevariable.h \
    geometry.h \
    gps_ahrs_status.h \
    intvariable.h \
    qmlmqttclient.h \
    singlemarkermodel.h \
    stringvariable.h \
    swampmodel.h \
    swampstatus.h \
    variable.h
