QT += quick positioning mqtt

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        components/gps_ahrs_status.cpp \
        components/motor_status.cpp \
        components/ngc_status.cpp \
        components/swamp_motor_status.cpp \
        components/time_status.cpp \
        data/doublevariable.cpp \
        data/intvariable.cpp \
        data/ngc_variable.cpp \
        data/stringvariable.cpp \
        data/variable.cpp \
        main.cpp \
        map_models/geometry.cpp \
        map_models/singlemarkermodel.cpp \
        swamp_models/datasource.cpp \
        swamp_models/swampmodel.cpp \
        swamp_models/swampstatus.cpp

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
    components/gps_ahrs_status.h \
    components/motor_status.h \
    components/ngc_status.h \
    components/swamp_motor_status.h \
    components/time_status.h \
    data/custom_types.h \
    data/define.h \
    data/doublevariable.h \
    data/intvariable.h \
    data/ngc_variable.h \
    data/stringvariable.h \
    data/variable.h \
    map_models/geometry.h \
    map_models/singlemarkermodel.h \
    swamp_models/datasource.h \
    swamp_models/swampmodel.h \
    swamp_models/swampstatus.h

DISTFILES += \
    conf/topics.cfg \
    conf/topics.cfg
