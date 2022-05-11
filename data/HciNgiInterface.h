#ifndef HCINGIINTERFACE_H
#define HCINGIINTERFACE_H

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
enum NgcCommand {
    HCI_NOP=0,
    SET_GC_WORKING_MODE, // par: GCworkingMode gcWorkingMode
    SET_TM_MANUAL_MODE, // par ThrustMappingManualMode tmManualMode
    SET_TM_AUTO_MODE, // par: ThrustMappingAutoMode tmAutoMode
    SET_TM_DISABLE_MODE, // TM does not write n[i],azimuth[i]
    SET_RPM_ALPHA, // par: double nRef [rpm], double dnRef [rpm], double alphaRef [deg]
    SET_FORCE_TORQUE, // par: double X [N], Y [N], N [N*m]
    SET_SURGE, // par: double uRef [m/s]
    SET_SWAY, // par: double vRef [m/s]
    SET_YAW, // par: double rRef [deg/s]
    SET_HEADING, // par: double psiRef [deg]
    SET_LAT_LON, // par: double latRef [deg.mmmmmmmm], double lonRef [deg.mmmmmmmm]
    SET_XY, // par: double xRef [m], double yRef [m]
    SET_LINE_LAT_LON, // par: double latLref [deg.mmmmmmmm], double lonLRef [deg.mmmmmmmm], double gammaLref [deg]
    SET_LINE_XY, // par: double xLref [m], double yLonLRef [m], double gammaLref [deg]
    // the following commands MUST be used only when TM_DISABLE_MODE
    MINION_CMD, // par: uint8 minionId, <MinionNgcCmd> as specified in "MinionNgcInterface.h"
    CMD_NUMBER
};
enum NgcTelemetryPacket {
    NGC_TLM=0,
    MINION_FL_TLM,
    MINION_FR_TLM,
    MINION_RR_TLM,
    MINION_RL_TLM,
    TLM_NUMBER
};

#endif // HCINGIINTERFACE_H