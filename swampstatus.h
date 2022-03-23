#ifndef SWAMPSTATUS_H
#define SWAMPSTATUS_H

#include <QObject>
#include <gps_ahrs_status.h>

class SwampStatus : public QObject
{
    Q_OBJECT

    Q_PROPERTY(GPS_AHRS_status* gps_ahrs_status READ gps_ahrs_status NOTIFY gps_ahrs_statusChanged)

public:
    explicit SwampStatus(QObject *parent = nullptr);

    GPS_AHRS_status *gps_ahrs_status() ; //const

signals:

    void gps_ahrs_statusChanged();

private:
    GPS_AHRS_status m_gps_ahrs_status;
};

#endif // SWAMPSTATUS_H
