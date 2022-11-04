# User Interface for the Remote Control of Unmanned Marine Vehicles

|Description	| Repository to store progress about the development of a user interface to remotely view and operate marine vehicles. |
| :-------------| :----------------------------------------------------------- |
|Author		| Corrado Motta |
|Mail		| corradomotta92@gmail.com |
|Date		| 08/2022 |
|Credits    | This interface is developed for the CNR-INM istitute in Genoa. Check the [technical report](https://intranet.cnr.it/servizi/people/prodotto/scheda/i/469797) for more information. |

_Table of contents_

1. [ Info on IDE and installation](#ide)
    * [ Repository](#github)
    * [ OpenSSL](#openssl)
    * [ Controller](#controller)
    * [ QtMqtt](#qtmqtt)
2. [ Info on implementation and technical notes](#implementation)
    * [ Network Binding](#network)    
3. [ Info on usage](#usage)
    * [ Configuration file](#configuration) 
    * [ Initial set up](#setup)
    * [ Marker and transepts](#markers) 
    * [ Points of interest](#points)
    * [ Bathymetry](#bathymetry)
    * [ Offline maps](#maps) 

<a name="ide"></a>
## Info on IDE and installation

**NOTE**: The following instructions are valid for Windows. However, the installation process should be similar on Linux and Mac systems as well.

Qt Creator 5.15.2 should be installed with full package and MingW as compiler. You can use the online installer, by visiting the Qt [website](https://www.qt.io/download), which is available in the open source section. After log in with your credentials, go to custom installation. Expand Qt menu, select Qt 5.15.2. There, the minimum set of modules that should be checked in the tree list are:

1. MinGW 64bit.
2. Sources[^1]
3. Qt Network Authorization for the use of plugins such as map
4. Qt Charts
6. Qt Debug information files
7. In developer and Designer tools > OpenSSL (the whole package)

[^1]: The sources package is not mandatory, but very useful if you want to access the source code.

<a name="github"></a>
### GitHub and the repository

The easiest way to install this interface on your local computer is by using `git` commands.
Git bash for windows is available at their [website](https://gitforwindows.org/) and can be used to interact with the remote repository, here on GitHub.
Once installed, open the Git bash terminal, navigate to the location where you want to install the interface and simply run:

`$ git clone <link_to_repo>`

The updated "link_to_repo" can be found on the "Code" green box on the top right of the main GitHub page of this repository. Click on the down arrow, select the method for cloning (HTTPS is enough in this case) and copy the link. After the command is executed, the entire code is cloned in your local machine. By using `$ git status` you can check if your version is up to date or not. Check the git page for more information and commands.

The development of this interface is managed by using the __GitHub issues__. Go to the `Issues` section to see all open issues. You can also visualize all closed issues, where there are information on each of the added feature as well as all the related commits. For each issue, a new branch is opened, which will be merged to master when the issue is completed. The branch is always named with prefix "Feature" or "Bugfix" followed by a slash and then the issue name. For example, <__Feature/integrate controller__>. To see all merged branches, go to `Pull request - Closed` section.

Note that also the commit message follows a template containing a title, a list of changes and the issue number to be correctly linked to the issue.

<a name="openssl"></a>
### OpenSSL

To be able to use the maps OpenSSL needs to be installed as well on the local machine and not only in Qt. You can go to the [OpenSSL](https://slproweb.com/products/Win32OpenSSL.html) website and download it using the installer. The file name should be something similar to
`Win64 OpenSSL v1.1.1s`.

If you do not know whether OpenSSL is already installed or which version should be installed, you can use the C ++ code below, using the following steps:
1. Create a new Qt project (type: Application (Qt) > Qt Quick Application). Leave default options until `Kit Selection`, there you can chose the MinGW compiler.
2. Expand Sources folder and open `main.cpp`.
3. Replace the code there with the one below.
4. Run it in debug mode.
5. Check what is getting printed in the console.

If the second line is false and the third is an empty string, go to OpenSSL website and download the most similar release to the first printed line in the console.

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
<a name="controller"></a>
### Controller

Another way to control the vehicle in RAW mode is by using a game controller. At the
time of writing the supported controller is the Thrustmaster USB Joystick for PC. 
The module to control the joystick is build-in, taken from a [GitHub project](https://github.com/alex-spataru/QJoysticks), but you need to manually add the dll library. To do so, follow the following steps:

1. Download the appropriate dll from the SDL release [website](https://github.com/libsdl-org/SDL/releases/tag/release-2.24.2), in my case `SDL2-2.24.2-win32-x64.zip
`.
2. Add it to the directory with path `ASV_interface\3rd_parties\QJoysticks\lib\SDL\bin\windows\mingw`.
3. Restart the app.

This controller has 3 available axis and 4 buttons. Three of the four buttons are used to switch between the
views and the tabs and a fourth button is used to turn on RAW mode immediately. The two axes are mapped to the RPM control slider of the NGC 
and allow the user to control both the speed and the direction.
They also allow driving backward in any direction. To enable the controller simply plug the joystick into the PC. If the interface correctly recognizes the
controller, a small icon will appear on the top left of the navigation map.

![Controller - Copy](https://user-images.githubusercontent.com/12608893/199959009-918d9b53-6f39-4809-8a5d-406d63f5aef1.PNG)

<a name="qtmqtt"></a>
### QtMqtt

**NOTE**: The following installation steps are NOT needed if the interface is used with UDP binding only. Also, the mqtt binding is currently disabled to avoid installing further components.

The following steps are required for windows[^2] in order to build QtMqtt from source as the package is not included in the open source release:

* Installing [Perl 5.8](https://www.activestate.com/products/perl/).
* Installing [cmake](https://cmake.org/download/).
* Installing [git bash](https://gitforwindows.org/), if not done already.
*  Open Git bash and go to the folder where you want to download the source code (e.g., on your user root folder or in C folder). Then, run:

   `$ git clone https://code.qt.io/qt/qtmqtt.git`[^3].

   `$ git checkout 5.15.2` (or the version of Qt Creator you have installed).

* Open a cmd terminal and digit: `$ C:\Qt\5.15.2\mingw<yourVersion>\bin\qtenv2.bat` (will prompt "Setting up environment for Qt Usage..").
* Move into the dir where you run git clone, using `cd` command. Then, run:

   `$ C:\Qt\5.15.2\mingw<yourVersion>\bin\qmake.exe -r`[^4]
   
   `$ C:\Qt\Tools\mingw<yourVersion>\bin\mingw32-make.exe install`.

__Source:__ https://forum.qt.io/topic/91877/where-do-i-find-qt-for-automation/7
[^2]: Mqtt installation is tested only with mingw compilers.
[^3]: Check on [release page](https://code.qt.io/cgit/qt/qtmqtt.git/) if the link is still valid.
[^4]: If it prompt an error related to the example folder, just run it again. Alternatively cut and paste the example folder somewhere else.

<a name="implementation"></a>
## Info on implementation and technical notes

The HCI interface is developed using QML for the "front end" and C++ for the "back end". Communication between C++ and QML is implemented in the standard QT way, using `setContextProperty` method and `Q_OBJECT`. For interaction with the navigation map, the [model-view-delegate](https://doc.qt.io/qt-5/model-view-programming.html) architecture is used, where the model part is coded in C++. Such classes are contained in the folder map_models.

<a name="network"></a>
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
 
 <a name="usage"></a>
 ## Info on usage
 
<a name="configuration"></a>
 ### Configuration file

In the "conf" folder several files for configuration are available. The only one used at the moment is `conf.ini`. There, all configuration parameters are listed and described. When you change any of these parameters, you need to restart the application in order to make them effective. The .ini file has 6 sections:

* __udp_addresses__: here you set all IP addresses and ports. Note that the first parameter, `Set_local` should be set to false when working with the vehicle. A `true` value is set to connect to the local network, for testing purposes only.
* __minion_configuration__: here you can set the initial offset for the initial angle of each minion' azimuth motor.
* __mapbox_settings__: These are used for offline maps. Check the section below for details.
* __RPM_Settings__: here you can set the RPM values both for the slider dimensions and for the maximum possible value of the game controller.
* __coordinate_seetings__: here you can specify a path and a filename for the points of interest. See section below for details.
* __metadata_settings__: here you specify the path to the metadata database and where to store the generated metadata
 
<a name="setup"></a>
 ### Initial set up
 
As soon as the vehicle is booted, it is possible to proceed with the inital set up. Namely, enabling and powering the pump and the azimuth thrusters as well as set the azimuth "home" angles. Such operations can be done from the top right panels in the main windows as shown in the image. Note that NGC_ENABLE **shall** be switched off during such operations, because we need to send information directly to the minions/engines, without the NGC acting as a filter.

To turn on the thrusters click on the propeller icons, first with the left click (to __enable__, it turns yellow) and then the right click (to __power__, it turns green). Note that the color will change immediately on the click but that does not necessarily mean that the command was correctly received by the vehicle. The leds on the top of the navigation map helps to understand the status of the engines. Hover with the mouse on top of them to see what they represent. In case a command was not received, simply repeat the procedure until all the status leds are correctly activated.

Just below it, in the next panel, you can set the __angle__ of the azimuth thrusters. Follow the top-down order. _Go home_ will send the azimuth to the original 0. _Set angle_ will set all angles to the value given in the configuration file. Finally, _set home_ will set the new home to be that one. You can follow the azimuth moves in the Swamp image next to it by looking at the colored value.

Now, you can enable the NGC with the switch button and start moving the vehicle in the modality `RPM_ALPHA`. The `NEW_LOG` button cna be used to trigger the creation of a new log file.
 
 ![image](https://user-images.githubusercontent.com/12608893/199756452-797640c0-5f38-478a-9b4a-f64729b6a10d.png)

<a name="markers"></a>
 ### Adding markers and transepts

It is possible to add markers and lines to the map or to upload them from file[^5].

To enable drawing markers or lines click on the correspondent icon in the bottom right of the navigation map as shown in the below picture. 
When clicked, other boxes will appear with a white color. Then it is possible to add markers (or lines) by clicking on the map. You can **remove** a single marker with a right click on the marker or **drag** it in another position on the map. You can **remove all** markers (or line points) by clicking the remove icon in the correspondent button on the bottom right. Finally you can **send** the coordinates to the vehicle by clicking on the send icon. 

![image](https://user-images.githubusercontent.com/12608893/195368568-9aa324f5-8155-4d28-a8d7-a96b867ed1dd.png)

It is also possible to **upload** points or transepts from a file. The only supported format is **gpx** which is the [standard XML format](https://www.topografix.com/gpx.asp) for exchanging GPS data between applications. It is available as an export option from QGIS. Click on the upload icon on the bottom right. You will be able to select the file from the file system and the points will be imported.

[^5]: At the moment the insertion of markers is limited to one marker at a time. Therefore adding a new marker will replace the previous one. Such limitation is not added to lines.

**LINE FOLLOWING AND LINE OF SIGHT**

After a marker is added on the map, you can either send the vehicle to that point so that the vehicle always keeps its bow in the direction of the point (Line of Sight, _LoS_) or you can make the vehicle to stay on a line that pass through that point (Line Following, _LF_). In order to do that, you can control the force (therefore, the speed of the vehicle) with `X` in the panel control and, in case of _LF_, the orientation of the line in degrees by setting `G`.

![image](https://user-images.githubusercontent.com/12608893/199966282-2576e6d7-7fa3-4efd-b352-bf199b638d11.png)

Once you have done it, you can click on the normal **send** icon (or the send icon with the little line on the bottom left for _LF_) go to the GWorkingMode in the menu bar and choose `GO_TO_AUTO` or `LF`, depending on what you want to do. After that, the marker should turn in green color. That shows the vehicle correctly received the information and will start moving.

<a name="points"></a>
### Adding points of interest
 
Points of interest that come from e.g. sampling spots, can be saved on the map and exported to a file. The filename and path can be set in the conf.ini file. If already existing, the interface will simply append the new data. Otherwise, it will create the file. The data stored in the file are the following:

1. Timestamp, received by the vehicle.
2. Name, given by the user or UNNAMED as default.
3. Latitude of the point.
4. Longitude of the point

![samplingPoints](https://user-images.githubusercontent.com/12608893/184177663-d2349523-337f-4739-913d-2407877af43f.PNG)

The figure shows the points in purple. In the bottom right, a new point is being added with the name _svalbard_first_sampling_. By clicking the plus button the marker will be added to the map, at the vehicle’s current position. By clicking on the download button, all points will be saved to a file. The red button can be used to remove all points. Points interaction on the map works in the exact same way as the marker and lines explained previously.

<a name="bathymetry"></a>
### Bathymetry

An extra view is added in order to visualize depth data both as a chart, which is dynamically filled with the incoming depth data, and on the top of the navigation
map, with colored depth points to generate real-time bathymetries. The figure shows its usage during a field trip. On the right panel, under the `OTHER` tab a dedicated element is available to adapt the depth range, which in turn changes the color of the points, and to save the depth data, the position, and the timestamp to a log file.

![batimetria](https://user-images.githubusercontent.com/12608893/199969129-0db752f0-23f2-498e-bde8-7de0e55cd678.png)


<a name="maps"></a>
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
conf.ini file, you can set the path to the database you are interested in for that specific area. Note that if you are connected to internet, mapbox will start to save the new tiles and replace the one in your database. So always keep a safe copy of your offline databases!

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
