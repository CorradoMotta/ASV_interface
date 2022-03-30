#ifndef INTVARIABLE_H
#define INTVARIABLE_H

#include <QObject>
#include <data/variable.h>

class IntVariable : public Variable
{
    Q_OBJECT
    Q_PROPERTY(int value READ value WRITE setValue NOTIFY valueChanged)

public:
    explicit IntVariable(QObject *parent = nullptr);

    int value() const;
    void setValue(int newValue);

signals:

    void valueChanged();

private:

    int m_value;
};

#endif // INTVARIABLE_H
