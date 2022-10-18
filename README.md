# ASV_interface
Repository to store progress on the ASV interface development

## Info on IDE and dependencies
Qt Creator 5.15.2 should be installed with full package and MingW as compiler. You can use the online installer available in https://www.qt.io/download in the open source section. After log in with your credentials, go to custom installation. Expand Qt menu, select Qt 5.15.2, the minimum set of modules that should be selected are:

1. MinGW 64bit.
2. Sources (if you want the source code)
3. Qt Network Authorization for the use of plugins such as map
4. Qt Charts
6. Qt Debug information files
7. In developer and Designer tools > OpenSSL (the whole package)

### OpenSSL

To be able to use the maps, however, OpenSSL needs to be installed as well on the local machine with the following steps:

1. Run the MaintenanceTool and install the OpenSSL package in "Developer and Designer tools >  OpenSSL 1.1.x"
2. Check which version of OpenSSL was used for the Qt build with qDebug using the C ++ code below
3. If the second line is false and the third is an empty string, go to OpenSSL website and download the most similar release and use the installer: https://slproweb.com/products/Win32OpenSSL.html 
4. Reboot Qt Creator to make changes effective

__C++ code to check the OpenSSL version:__

``` cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QSslSocket>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    qDebug() << QSslSocket::sslLibraryBuildVersionString();
    qDebug() << QSslSocket::supportsSsl();
    qDebug() << QSslSocket::sslLibraryVersionString();

    return app.exec();
}
``` 

### Controller
Another way to control the vehicle in RAW mode is by using a game controller. At the
time of writing the supported controller is the Thrustmaster USB Joystick for PC. 
The module to control the joystick is build-in but you need to manually install the dll. To do so, follow these steps:

1. Download SWDL2 mingw x64 library from: https://www.libsdl.org/download-2.0.php
2. Add it to the directory ASV_interface\3rd_parties\QJoysticks\lib\SDL\bin\windows\mingw
3. Restart the app.

This controller has 3 available axis and 4 buttons. Two of the four buttons are used to switch between the
views and the tabs and a third button is used to turn on RAW mode immediately. The two axes are mapped to the RPM control slider of the NGC 
and allow the user to control both the speed and the direction.
They also allow driving backward in any direction. To enable
the controller simply plug the joystick into the PC. If the interface correctly recognizes the
controller, a small icon will appear on the top left of the navigation map,

### QtMqtt

**NOTE**: this is currently not needed as MQTT is disabled.

**NOTE**: this is tested only with mingw compilers!

The following steps are required for windows in order to install qtmqtt which is not included in the download packages:

* Installing Perl 5.8 https://www.activestate.com/products/perl/
* Installing cmake https://cmake.org/download/
* Installing git bash https://gitforwindows.org/
*  Open Git bash and go to the folder where you want to download the source code (e.g. on your user or in C folder)

`$ git clone https://code.qt.io/qt/qtmqtt.git` (check on release page if the link is still valid: https://code.qt.io/cgit/qt/qtmqtt.git/)

`$ git checkout 5.15.2` (or the version of Qt Creator you have installed)
* Open terminal and digit: `$ C:\Qt\5.15.2\mingw<yourVersion>\bin\qtenv2.bat` (will prompt "Setting up environment for Qt Usage..")
* Cd into the dir where you run git clone: `$ C:\Qt\5.15.2\mingw<yourVersion>\bin\qmake.exe -r` (If it prompt an error related to the example folder, just run it again. Alternatively cut and paste the example folder somewhere else.)
* Then run: `$ C:\Qt\Tools\mingw<yourVersion>\bin\mingw32-make.exe install`

__Source:__ https://forum.qt.io/topic/91877/where-do-i-find-qt-for-automation/7

## Info on implementation

__Note:__ For more info regarding the technical details refer to: https://intranet.cnr.it/servizi/people/prodotto/scheda/i/469797

The HCI interface is developed using QML for the "front end" and C++ for the "back end". Communication between C++ and QML is implemented in the standard QT way, using `setContextProperty` method and `Q_OBJECT`. For interaction with the navigation map, the model-view-delegate architecture is used (https://doc.qt.io/qt-5/model-view-programming.html), where the model part is coded in C++. Such classes are contained in the folder map_models.

### Configuration file

In the "conf" folder several files for configuration are available. The only one used at the moment is `conf.ini`. There all configuration parameters are listed and described. When you change any of these parameters, you need to restart the application in order to make them effective. The .ini file has 6 sections:

* __udp_addresses__: here you set all IP addresses and ports. Note that the first parameter, `Set_local` should be set to false when working with the vehicle. A `true` value is set to connect to the local network, for testing purposes only.
* __minion_configuration__: here you can set the initial offset for the initial angle of each minion' azimuth motor.
* __mapbox_settings__: These are used for offline maps. Check the section below for details.
* __RPM_Settings__: here you can set the RPM values both for the slider dimensions and for the maximum possible value of the game controller.
* __coordinate_seetings__: here you can specify a path and a filename for the points of interest. See section below for details.
* __metadata_settings__: here you specify the path to the metadata database and where to store the generated metadata

### Network Binding

The front-end of the application is fully detached from the underlying communication protocol. In the backend, the class `swampmodel` contains a pointer to a `dataSource` object. `dataSource` is a virtual class which offers a basic set of methods that can be implemented by different communication protocol:

``` cpp
class DataSource : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool is_connected READ is_connected WRITE set_is_connected NOTIFY is_connectedChanged)
    Q_PROPERTY(SwampStatus* swamp_status READ swamp_status NOTIFY swamp_statusChanged)

public:
    explicit DataSource(QObject *parent = nullptr) : QObject{parent}, m_is_connected{false}{}

    /**
     * Set a connection on the underlying protocol.
     *
     */
    Q_INVOKABLE virtual void setConnection() = 0;

    /**
     * Send a message out. It is made Q_invokable to be used directly in QML code.
     *
     * @param identifier of the packet that is going to be sent.
     * @param message to be sent.
     *
     */
    Q_INVOKABLE virtual void publishMessage(const QString &identifier, const QString &message) = 0;

    /**
     * Set initial configuration parameters, such as the identifier for each variable.
     * As configuration can also be stored on a file, it is possible to add a parameter with the filename.
     *
     * @param filename path to the configuration file. Default is empty.
     * @return true if configuration is completed properly, false otherwise.
     */
    virtual bool set_cfg(QString filename = "") = 0;

    /**
     * Q_PROPERTY read method. Check if connection is established.
     *
     * @return true if connection is established, false otherwise.
     */
    bool is_connected() const;

    /**
     * Q_PROPERTY write method. Set the status of the connection.
     *
     * @param filename path to the configuration file. Default is empty.
     * @return true if configuration is completed properly, false otherwise.
     */
    void set_is_connected(bool newIs_connected);

    /**
     * Q_PROPERTY read method for swampStatus.
     *
     * @return Pointer to SwampStatus.
     */
    SwampStatus *swamp_status();

signals:

    void is_connectedChanged();
    void swamp_statusChanged();

protected:

    bool m_is_connected;
    SwampStatus m_swamp_status;
};
```

QML reacts to new commands on the interface and publish data by calling the virtual Q_INVOKABLE method `publishMessage`. From QML, it is also possible to explicitly request a connection (or to disconnect) to the vehicle.

Right now, two bindings are available: mqtt and UDP. In order to activate one or the other, simply set the corresponding argument on the command line when running the application ("mqtt" or "udp"). In QT Creator this is simply done in Projects>Run Settings> Command line arguments. Then the main.cpp will create the corresponding object using C++ polymorphism:

``` cpp
SwampModel data_model;
DataSource *dataSource;
if(networkBinding =="mqtt")  dataSource= new DataSourceMqtt(&data_model);
else if(networkBinding =="udp") dataSource = new DataSourceUdp(&data_model);
else { qDebug() << "Input network binding not recognized or available : " << networkBinding; exit(-1); }

bool sourceIsValid = dataSource->set_cfg("../ASV_interface/conf/topics.cfg");
if(! sourceIsValid) exit(-1);
// here i set the dataSource
data_model.set_data_source(dataSource);
```

Fully dynamic network binding is not made available right now, but it could be simply implemented, as the dataSource object is dynamically set in the `swampmodel` class:


``` cpp
class SwampModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DataSource* data_source READ data_source WRITE set_data_source NOTIFY data_sourceChanged)

public:
    explicit SwampModel(QObject *parent = nullptr);

    DataSource *data_source() const;
    void set_data_source(DataSource *newData_source);

signals:

    void data_sourceChanged();

private:

    DataSource *m_data_source;
};
``` 
 As it is possible to see, the method `set_data_source` is generated by the above Q_PROPERTY. Therefore, theoretically (not tested), it should be possible to switch between communication protocol also directly from the QML view.
 
 ### Adding markers and transepts

It is possible to add markers and lines to the map or to upload them from file.

To enable drawing markers or lines click on the correspondent icon in the bottom right of the navigation map as shown in the below picture. 
When clicked, other boxes will appear with a white color. Then it is possible to add markers (or lines) by clicking on the map. You can **remove** a single marker with a right click on the marker or **drag** it in another position on the map. You can **remove all** markers (or line points) by clicking the remove icon in the correspondent button on the bottom right. Finally you can **send** the coordinates to the vehicle by clicking on the send icon. You can also set a line to follow for the vehicle by clicking on the send button with the little line on the bottom left.

![image](https://user-images.githubusercontent.com/12608893/195368568-9aa324f5-8155-4d28-a8d7-a96b867ed1dd.png)


It is also possible to **upload** points or transepts from a file. The only supported format is **gpx** which is the [standard XML format](https://www.topografix.com/gpx.asp) for exchanging GPS data between applications. It is available as an export option from QGIS. Click on the upload icon on the bottom right. You will be able to select the file from the file system and the points will be imported.

**Note:** At the moment the insertion of markers is limited to one marker at a time. Therefore adding a new marker will replace the previous one. Such limitation is not added to lines.

### Adding points of interest
 
Points of interest that come from e.g. sampling spots, can be saved on the map and
exported to a file. The filename and path can be set in the conf.ini file. If already existing,
the interface will simply append the new data. Otherwise, it will create the file. The data
stored in the file are the following:

1. Timestamp, received by the vehicle.
2. Name, given by the user or UNNAMED as default.
3. Latitude of the point.
4. Longitude of the point

![samplingPoints](https://user-images.githubusercontent.com/12608893/184177663-d2349523-337f-4739-913d-2407877af43f.PNG)

The figure shows the points in purple. In the bottom right, a new point is being added with
the name svalbard_first_sampling. By clicking the plus button the marker will be added to
the map, at the vehicle’s current position. By clicking on the download button, all points
will be saved to a file. The red button can be used to remove all points. Points interaction
on the map works in the exact same way as the marker and lines explained previously.

### Offline maps

Mapbox was selected as the map provider. Mapbox allows accessing vector and satellite
maps, with several zoom levels and good resolution. Furthermore, it provides the possibility
to manually download and store map tiles in a custom cache directory with database format
(.db). This is very useful as the interface can be also used when an online connection is
not available. To download the tiles, a C++ tool is available __only for linux OS__. At the
moment, the maximum amount of tiles that can be downloaded offline is set to 6000 and 50
MB as cache size. Mapbox term of service should be consulted to check if the size can be
incremented. As a workaround, it is possible to create multiple databases (all of them shall
have the name mapboxgl.db to work) and store them in different directories. Then, in the
conf.ini file, you can set the path to the database you are interested in for that specific area.

The following steps are required to download offline maps:

1. Download the [offline](https://github.com/mapbox/mapbox-gl-native/blob/master/bin/offline.cpp) tool from [mapbox ](https://doc.qt.io/qt-5/location-plugin-mapboxgl.html) plug in. The offline tool is not targeting the windows platform and therefore you need a Linux system.
2. Open a cmd line and move to the offline tool build folder: `$ cd Documents/mapbox/mapbox-gl-native/build/bin`
3. The program is called mbgl-offline. It takes several input parameters. Down here is a summary of the main args, taken from the parser in their code:

``` cpp
// LatLngBounds
args::ValueFlag<std::string> styleValue(argumentParser, "URL", "Map stylesheet", {'s', "style"});
args::ValueFlag<std::string> outputValue(argumentParser, "file", "Output database file name", {'o', "output"});
args::ValueFlag<std::string> apiBaseValue(argumentParser, "URL", "API Base URL", {'a', "apiBaseURL"});

args::Group latLngBoundsGroup(argumentParser, "LatLng bounds:", args::Group::Validators::AllOrNone);
args::ValueFlag<double> northValue(latLngBoundsGroup, "degrees", "North latitude", {"north"});
args::ValueFlag<double> westValue(latLngBoundsGroup, "degrees", "West longitude", {"west"});
args::ValueFlag<double> southValue(latLngBoundsGroup, "degrees", "South latitude", {"south"});
args::ValueFlag<double> eastValue(latLngBoundsGroup, "degrees", "East longitude", {"east"});

args::ValueFlag<double> minZoomValue(argumentParser, "number", "Min zoom level", {"minZoom"});
args::ValueFlag<double> maxZoomValue(argumentParser, "number", "Max zoom level", {"maxZoom"});
args::ValueFlag<double> pixelRatioValue(argumentParser, "number", "Pixel ratio", {"pixelRatio"});
args::ValueFlag<bool> includeIdeographsValue(argumentParser, "boolean", "Include CJK glyphs", {"includeIdeographs"});
```

4. Besides these parameters, you also need to set the access token. The access token is retrieved from the [mapbox ](https://www.mapbox.com/) account. The access token is set before calling the script.
5. Finally, you can set your Area Of Interest, using e.g., QGIS, decide which style you are aiming for, which max zoom, and download the tiles. Following is an example to download tiles for Venice:

`$ MAPBOX_ACCESS_TOKEN=pk.eyJ1IjoibWFzc2ltb2NhY2NpYSIsImEiOiJjbDF5c2w2cDQwZndqM2RucnZ3Y3NjMDdjIn0.qBzdHy57FexjF3Aj-qps4g ./mbgl-offline --north 45.4522 --west 12.3209 --south 45.3853 --east 12.3785 --maxZoom 17 --output mapboxgl.db --style mapbox://styles/mapbox/satellite-v9`

This will create a database file named mapboxgl.db. **Note** that this shall always be the name used. Copy the file and move to windows or where the app is installed.

6. As sometimes the file might be corrupted, you might check that the DB file is working properly using SQL libraries or browsers app such as [sqllitebrowser](https://sqlitebrowser.org/dl/)
7. You should now paste the file into the correct directory where Mapbox stores by default the cached tiles. Such location can be found by adding the following line to your main.cpp in the Qt app, which will print in the console the path:

`qDebug() << "Mapbox cache file stored in:" << QStandardPaths::writableLocation(QStandardPaths::GenericCacheLocation);`

From there go to QtLocation/mapboxgl and replace the DB file with your customized one.

**Further options:** 
* You do not have to save the dB file in the default location. You can create your own directory and save the file there. Then go to the .ini file and add the absolute path in the `cache_dir` parameter.
* You also need to update the `map_style` parameter according to the type of tiles you downloaded ("street", "satellite", "all")
