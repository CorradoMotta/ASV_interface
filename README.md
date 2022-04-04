# ASV_interface
Repository to store progress on the ASV interface development

## Info on IDE
Qt Creator 5.15.2 should be installed with full package and MingW as compiler. You can use the installer available in https://www.qt.io/download. The minimum set of modules that should be selected are:

1. MinGW 64bit.
2. Sources (if you want the source code)
3. Qt Network Authorization for the use of plugins such as map
4. In developer and Designer tools > OpenSSL

### OpenSSL
To be able to use the maps, however, OpenSSL needs to be installed as well on the local machine with the following steps:

1. Run the MaintenanceTool and install the OpenSSL package in "Developer and Designer tools >  OpenSSL 1.1.x"
2. Check which version of OpenSSL was used for the Qt build with qDebug using the C ++ code below
3. If the second line is false and the third is an empty string, goes to OpenSSL website and download the most similar release and use the installer: https://slproweb.com/products/Win32OpenSSL.html 
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
### QtMqtt
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
