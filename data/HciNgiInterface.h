#ifndef HCINGIINTERFACE_H
#define HCINGIINTERFACE_H

#include <QObject>

class HciNgiInterface{
    Q_GADGET

public:
    explicit HciNgiInterface();

    enum MinionNgcCmd {
        MINION_NOP=0,
        MINION_SHUTDOWN,
        MINION_REBOOT,
        MINION_SET_TLM_IPADDRESS_PORT, // par: uint8 ipAddr, uint8 UDP port
        MINION_ENABLE_DEBUG_LOG,
        MINION_SET_DIGITAL, // not implemented
        MINION_SET_ANALOG, // not implemented
        MINION_LOG, // start new log file
        MINION_THRUST_POWER, // par: uint8 0/1
        MINION_THRUST_ENABLE, // par uint8 0/1
        MINION_THRUST_REFERENCE, // par: double n [rpm]
        MINION_AZIMUTH_POWER, // par: uint8 0/1
        MINION_AZIMUTH_ENABLE, // par uint8 0/1
        MINION_AZIMUTH_MAX_SPEED, // par: int32 n [rpm]
        MINION_AZIMUTH_SET_HOME,
        MINION_AZIMUTH_GO_HOME,
        MINION_AZIMUTH_SET_ANGLE, // par: double angle [deg]
    };

    enum MapboxStyle {
        MB_STREET=0,
        MB_SATELLITE,
        MB_ALL
    };

    enum NgcCommand {
        HCI_NOP=0,
        NGC_ENABLE,
        SET_GC_WORKING_MODE, // par: GCworkingMode gcWorkingMode
        SET_TM_MANUAL_MODE, // par ThrustMappingManualMode tmManualMode
        SET_TM_AUTO_MODE, // par: ThrustMappingAutoMode tmAutoMode
        SET_RPM_ALPHA, // par: double nRef [rpm], double dnRef [rpm], double alphaRef [deg]
        SET_FORCE_TORQUE, // par: double X [N], Y [N], N [N*m]
        SET_SURGE, // par: double uRef [m/s]
        SET_SWAY, // par: double vRef [m/s]
        SET_YAW, // par: double rRef [deg/s], X [N], Y [N]
        SET_HEADING, // par: double psiRef [deg], X [N], Y [N]
        SET_LAT_LON, // par: double latRef [deg.mmmmmmmm], double lonRef [deg.mmmmmmmm], X [N]
        SET_XY, // par: double xRef [m], double yRef [m], X [N]
        SET_LINE_LAT_LON, // par: double latLref [deg.mmmmmmmm], double lonLRef [deg.mmmmmmmm], double gammaLref [deg]
        SET_LINE_XY, // par: double xLref [m], double yLonLRef [m], double gammaLref [deg]
        // the following commands MUST be used only when TM_DISABLE_MODE
        MINION_CMD, // par: uint8 minionId, <MinionNgcCmd> as specified in "MinionNgcInterface.h"
        LOG_RESTART,
        // commands to set NGC parameters
        SET_YAW_GS_PAR, // par: double sigma, omega, maxNoise [deg/s], satTorque [N]
        SET_HEADING_PI_PAR, // par: double g, kI, ySat [deg/s], eISat [deg], eIon [deg], eIoff [deg]
        SET_HOME, // par: none, the command set as home location the current location of the robot
        STOP_FILE_CMD, // used to go back to remote control from command file execution or emergency go home
        START_FILE_CMD, // used to start the execution of a preloaded file of commands
        RESUME_FILE_CMD, // used to recover the execution of a preloaded file of commands
        CMD_NUMBER
    };

    enum NgcTelemetryPacket {
        MINION_FL_TLM=0,
        MINION_FR_TLM,
        MINION_RR_TLM,
        MINION_RL_TLM,
        NGC_TLM,
        TLM_NUMBER
    };

    enum GCworkingMode {
        GC_RAW=0, // set (n,azimuth) & mappingMode
        GC_THRUST, // set X,Y,N & mappingMode
        GC_MANUAL, // set X,Y,psi
        GC_MANUAL_SPEED, // set u,v,psi
        GC_GOTO_AUTO, // set (x,y),X
        GC_GOTO_AUTO_SPEED, // set (x,y),u
        GC_X_Y_PSI, // set x,y,psi
        GC_LF, // set (xL,yL,gammaL),X
        GC_LF_SPEED, // set (xL,yL,gammaL),u
        GC_YAW_TEST, // set r
        GC_NUMBER
    };

    enum ThrustMappingManualMode {
        TMMM_FRWD_ALL=0, // dnRef>0 --> steer right; alphaRef>0 --> steer right
        TMMM_FRWD_BOW, // stern dn=0 & stern azimuth=0
        TMMM_FRWD_STERN, // bow dn=0 & bow azimuth=0
        TMMM_BCKWD_ALL, // dnRef>0 --> steer right; alphaRef>0 --> steer right, i.e. alpha=alphaRef+180
        TMMM_BCKWD_BOW,  // stern dn=0 & stern azimuth=0, alpha=alphaRef+180
        TMMM_BCKWD_STERN, // bow dn=0 & bow azimuth=0, alpha=alphaRef+180
        TMMM_NUMBER
    };

    enum ThrustMappingAutoMode {
        TMAM_HOV_MODE=0, // ROV-like fixed-azimuth configuration
        TMAM_FRWD_THRUST_ALL, // yaw torque given by differential thrust: azimuth[i]=0
        TMAM_FRWD_AZIMUTH_ALL, // yaw torque given by azimuth angle
        TMAM_NUMBER
    };

    //    enum ThrustMappingAutoMode {
    //        TMAM_HOV_MODE=0, // ROV-like fixed-azimuth configuration
    //        TMAM_FRWD_THRUST_ALL, // yaw torque given by differential thrust: azimuth[i]=0
    //        TMAM_FRWD_AZIMUTH_ALL, // yaw torque given by azimuth angle
    //        TMAM_FRWD_AZIMUTH_BOW,// yaw torque given by bow azimuth angle
    //        TMAM_FRWD_AZIMUTH_STERN, // yaw torque given by stern azimuth angle
    //        TMAM_BCKWD_THRUST_ALL, // yaw torque given by differential thrust: azimuth[i]=180
    //        TMAM_BCKWD_AZIMUTH_ALL, // yaw torque given by azimuth angle
    //        TMAM_BCKWD_AZIMUTH_BOW,// yaw torque given by bow azimuth angle
    //        TMAM_BCKWD_AZIMUTH_STERN, // yaw torque given by stern azimuth angle
    //        TMAM_NUMBER
    //    };
    Q_ENUM(MinionNgcCmd)
    Q_ENUM(NgcCommand)
    Q_ENUM(NgcTelemetryPacket)
    Q_ENUM(GCworkingMode)
    Q_ENUM(ThrustMappingManualMode)
    Q_ENUM(ThrustMappingAutoMode)
    Q_ENUM(MapboxStyle)
};
#endif // HCINGIINTERFACE_H
