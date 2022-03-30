#ifndef NGC_VARIABLE_H
#define NGC_VARIABLE_H

#include <QObject>
#include <doublevariable.h>

class NGC_variable : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DoubleVariable* act READ act NOTIFY actChanged)
    Q_PROPERTY(DoubleVariable* ref READ ref NOTIFY refChanged)

public:
    explicit NGC_variable(QObject *parent = nullptr);

    DoubleVariable *act();
    DoubleVariable *ref();

signals:

    void actChanged();
    void refChanged();

private:

    DoubleVariable m_act;
    DoubleVariable m_ref;
};

#endif // NGC_VARIABLE_H
