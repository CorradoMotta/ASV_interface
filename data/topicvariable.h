#ifndef TOPICVARIABLE_H
#define TOPICVARIABLE_H

#include <QObject>
#include <data/variable.h>

class TopicVariable : public Variable
{
    Q_OBJECT
public:
    explicit TopicVariable(QObject *parent = nullptr);
    void fromString(QString s) override;
};

#endif // TOPICVARIABLE_H
