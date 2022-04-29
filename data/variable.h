/*************************************************************************
 *
 * This class defines the base class for our custom variable data types.
 *
 *************************************************************************/

#ifndef VARIABLE_H
#define VARIABLE_H

#include <QObject>
#include "custom_types.h"
#include "define.h"
#include <QString>

class Variable : public QObject
{

    Q_OBJECT
    Q_PROPERTY(QString topic_name READ topic_name WRITE setTopic_name NOTIFY topic_nameChanged)
    Q_PROPERTY(int updated READ updated WRITE setUpdated NOTIFY updatedChanged)
    Q_PROPERTY(int valid READ valid WRITE setValid NOTIFY validChanged)
    Q_PROPERTY(bool subscribe READ subscribe WRITE setSubscribe NOTIFY subscribeChanged)
    Q_PROPERTY(double timeStamp READ timeStamp WRITE setTimeStamp NOTIFY timeStampChanged)


public:

    explicit Variable(QObject *parent = nullptr);
    ~Variable();

    const QString &topic_name() const;
    void setTopic_name(const QString &newTopic_name);
    int updated() const;
    void setUpdated(int newUpdated);
    int valid() const;
    void setValid(int newValid);
    void setTimeStamp(double newTimeStamp);
    double timeStamp() const;
    bool subscribe() const;
    void setSubscribe(bool newSubscribe);
    virtual void fromString(QString s) = 0;

signals:

    void topic_nameChanged();
    void updatedChanged();
    void validChanged();
    void subscribeChanged();
    void timeStampChanged();

private:

    QString m_topic_name;
    int m_updated;
    int m_valid;
    double m_timeStamp;
    bool m_subscribe;
};

#endif // VARIABLE_H
