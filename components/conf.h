/*************************************************************************
 *
 * Class that contains the configuration parameters that needs to be
 * displayed or read in the QML side.
 *
 * Author: Corrado Motta
 * Date: 07/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

#ifndef CONF_H
#define CONF_H

#include <QObject>
#include <data/doublevariable.h>
#include <data/intvariable.h>
#include <data/stringvariable.h>
#include <data/HciNgiInterface.h>
#include <QGeoCoordinate>

class Conf : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int maxRPMSpeed READ maxRPMSpeed WRITE setMaxRPMSpeed NOTIFY maxRPMSpeedChanged)
    Q_PROPERTY(int maxControllerSpeed READ maxControllerSpeed WRITE setMaxControllerSpeed NOTIFY maxControllerSpeedChanged)
    Q_PROPERTY(QString mb_offline_db READ mb_offline_db WRITE setMb_offline NOTIFY mb_offline_dbChanged)
    Q_PROPERTY(HciNgiInterface::MapboxStyle mb_style READ mb_style WRITE setMb_style NOTIFY mb_styleChanged)
    Q_PROPERTY(QString coordinatePath READ coordinatePath WRITE setCoordinatePath NOTIFY coordinatePathChanged)
    Q_PROPERTY(QString jsonPath READ jsonPath WRITE setJsonPath NOTIFY jsonPathChanged)
    Q_PROPERTY(QString metadataIniPath READ metadataIniPath WRITE setMetadataIniPath NOTIFY metadataIniPathChanged)
    Q_PROPERTY(QGeoCoordinate origin READ origin WRITE setOrigin NOTIFY originChanged)

public:
    explicit Conf(QObject *parent = nullptr);

    int maxRPMSpeed() const;
    int maxControllerSpeed() const;
    const QString &mb_offline_db() const;

    void setMaxRPMSpeed(int newMaxRPMSpeed);
    void setMaxControllerSpeed(int newMaxControllerSpeed);
    void setMb_offline(const QString &newMb_offline_db);

    HciNgiInterface::MapboxStyle mb_style() const;
    void setMb_style(HciNgiInterface::MapboxStyle newMb_style);

    const QString &coordinatePath() const;
    void setCoordinatePath(const QString &newCoordinatePath);

    const QString &jsonPath() const;
    void setJsonPath(const QString &newJsonPath);

    const QString &metadataIniPath() const;
    void setMetadataIniPath(const QString &newMetadataIniPath);

    const QGeoCoordinate &origin() const;
    void setOrigin(const QGeoCoordinate &newOrigin);

signals:

    void maxRPMSpeedChanged();
    void maxControllerSpeedChanged();
    void mb_offline_dbChanged();
    void mb_styleChanged();
    void coordinatePathChanged();
    void jsonPathChanged();
    void metadataIniPathChanged();

    void originChanged();

private:
    int m_maxRPMSpeed;
    int m_maxControllerSpeed;
    QString m_mb_offline_db;
    HciNgiInterface::MapboxStyle m_mb_style;
    QString m_coordinatePath;
    QString m_jsonPath;
    QString m_metadataIniPath;
    QGeoCoordinate m_origin;
};

#endif // CONF_H
