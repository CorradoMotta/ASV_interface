#ifndef CONF_H
#define CONF_H

#include <QObject>
#include <data/doublevariable.h>
#include <data/intvariable.h>
#include <data/stringvariable.h>
#include <data/HciNgiInterface.h>

class Conf : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int maxRPMSpeed READ maxRPMSpeed WRITE setMaxRPMSpeed NOTIFY maxRPMSpeedChanged)
    Q_PROPERTY(int maxControllerSpeed READ maxControllerSpeed WRITE setMaxControllerSpeed NOTIFY maxControllerSpeedChanged)
    Q_PROPERTY(QString mb_offline_db READ mb_offline_db WRITE setMb_offline NOTIFY mb_offline_dbChanged)
    Q_PROPERTY(HciNgiInterface::MapboxStyle mb_style READ mb_style WRITE setMb_style NOTIFY mb_styleChanged)
    Q_PROPERTY(QString coordinatePath READ coordinatePath WRITE setCoordinatePath NOTIFY coordinatePathChanged)

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

signals:

    void maxRPMSpeedChanged();
    void maxControllerSpeedChanged();
    void mb_offline_dbChanged();

    void mb_styleChanged();

    void coordinatePathChanged();

private:
    int m_maxRPMSpeed;
    int m_maxControllerSpeed;
    QString m_mb_offline_db;
    HciNgiInterface::MapboxStyle m_mb_style;
    QString m_coordinatePath;
};

#endif // CONF_H
