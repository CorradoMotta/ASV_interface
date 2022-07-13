#ifndef CONF_H
#define CONF_H

#include <QObject>
#include <data/doublevariable.h>
#include <data/intvariable.h>
#include <data/stringvariable.h>

class Conf : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int maxRPMSpeed READ maxRPMSpeed WRITE setMaxRPMSpeed NOTIFY maxRPMSpeedChanged)
    Q_PROPERTY(int maxControllerSpeed READ maxControllerSpeed WRITE setMaxControllerSpeed NOTIFY maxControllerSpeedChanged)
    Q_PROPERTY(QString mb_offline_db READ mb_offline_db WRITE setMb_offline NOTIFY mb_offline_dbChanged)
    //Q_PROPERTY(StringVariable name READ name WRITE setName NOTIFY nameChanged)

public:
    explicit Conf(QObject *parent = nullptr);

    int maxRPMSpeed() const;
    int maxControllerSpeed() const;
    const QString &mb_offline_db() const;

    void setMaxRPMSpeed(int newMaxRPMSpeed);
    void setMaxControllerSpeed(int newMaxControllerSpeed);
    void setMb_offline(const QString &newMb_offline_db);

signals:

    void maxRPMSpeedChanged();
    void maxControllerSpeedChanged();
    void mb_offline_dbChanged();

private:
    int m_maxRPMSpeed;
    int m_maxControllerSpeed;
    QString m_mb_offline_db;
};

#endif // CONF_H
