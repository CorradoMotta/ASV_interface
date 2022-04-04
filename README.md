# ASV_interface
Repository to store progress on the ASV interface development

## Info on installation
Qt Creator should be installed with full package and MingW as compiler.

The following steps are required for windows in order to install qtmqtt which is not included in the download packages:

* Installing Perl 5.8 https://www.activestate.com/products/perl/
* Installing cmake 
* Installing git bash
*  Open Git bash and go to the folder where you want to download the source code (e.g. on your user or in C folder)

`$ git clone https://code.qt.io/qt/qtmqtt.git` (check on release page if the link is still valid: https://code.qt.io/cgit/qt/qtmqtt.git/)

`$ git checkout 5.15.2` (or the version of Qt Creator you have installed)
* Open terminal and digit: `$ C:\Qt\5.15.2\mingw<yourVersion>\bin\qtenv2.bat` (will prompt "Setting up environment for Qt Usage..")
* Cd into the dir where you run git clone: `$ C:\Qt\5.15.2\mingw<yourVersion>\bin\qmake.exe -r` (If it prompt an error related to the example folder, just run it again. Alternatively cut and paste the example folder somewhere else.)
* Then run: `$ C:\Qt\Tools\mingw<yourVersion>\bin\mingw32-make.exe install`

__Source:__ https://forum.qt.io/topic/91877/where-do-i-find-qt-for-automation/7
