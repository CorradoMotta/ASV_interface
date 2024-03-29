QT += quick positioning gui widgets

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        components/conf.cpp \
        components/gps_ahrs_status.cpp \
        components/minion.cpp \
        components/minion_command.cpp \
        components/minion_status.cpp \
        components/motor_status.cpp \
        components/ngc.cpp \
        components/ngc_command.cpp \
        components/ngc_status.cpp \
        components/swamp_motor_status.cpp \
        components/time_status.cpp \
        data/coordinatevariable.cpp \
        data/doublevariable.cpp \
        data/intvariable.cpp \
        data/ngc_variable.cpp \
        data/pump_jet_status.cpp \
        data/stringvariable.cpp \
        data/topicvariable.cpp \
        data/variable.cpp \
        generic/matrix.cpp \
        generic/robotmath.cpp \
        generic/vector.cpp \
        main.cpp \
        map_models/bathymetrymodel.cpp \
        map_models/coordinate_model.cpp \
        map_models/depth_point.cpp \
        map_models/singlemarkermodel.cpp \
        metadata/globalmetadata.cpp \
        swamp_models/datasource_udp.cpp \
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
    components/conf.h \
    components/gps_ahrs_status.h \
    components/minion.h \
    components/minion_command.h \
    components/minion_status.h \
    components/motor_status.h \
    components/ngc.h \
    components/ngc_command.h \
    components/ngc_status.h \
    components/swamp_motor_status.h \
    components/time_status.h \
    data/HciNgiInterface.h \
    data/Path_status.h \
    data/coordinatevariable.h \
    data/custom_types.h \
    data/define.h \
    data/doublevariable.h \
    data/intvariable.h \
    data/ngc_variable.h \
    data/pump_jet_status.h \
    data/stringvariable.h \
    data/topicvariable.h \
    data/variable.h \
    generic/Variable_c.h \
    generic/commands_def.h \
    generic/matrix.h \
    generic/robotmath.h \
    generic/vector.h \
    map_models/bathymetrymodel.h \
    map_models/coordinate_model.h \
    map_models/depth_point.h \
    map_models/singlemarkermodel.h \
    metadata/globalmetadata.h \
    swamp_models/datasource.h \
    swamp_models/datasource_udp.h \
    swamp_models/swampmodel.h \
    swamp_models/swampstatus.h

DISTFILES += \
    Images/ArrowDown.png \
    Images/ArrowUp.png \
    Images/Engine_inter.png \
    Images/Engine_off.png \
    Images/Engine_on.png \
    Images/Swamp.png \
    Images/arrow_close.png \
    Images/arrow_open.png \
    Images/circle.png \
    Images/download.png \
    Images/generate_path.png \
    Images/generate_path_on.png \
    Images/line_box.png \
    Images/marker.png \
    Images/marker_box.png \
    Images/off_button.png \
    Images/off_button_new.png \
    Images/on_button.png \
    Images/on_button_new.png \
    Images/pause-button.png \
    Images/pause.png \
    Images/play-button-simple.png \
    Images/play-button.png \
    Images/plus_resized.png \
    Images/rect_box.png \
    Images/stop-button.png \
    Images/stop.png \
    conf/conf.ini \
    conf/topics.cfg \
    conf/topics_minion.cfg \
    conf/topics_proteus.cfg

include (3rd_parties/QJoysticks/QJoysticks.pri)
