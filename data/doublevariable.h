#ifndef DOUBLEVARIABLE_H
#define DOUBLEVARIABLE_H

#include <QObject>
#include <data/variable.h>

class DoubleVariable : public Variable
{
    Q_OBJECT
    Q_PROPERTY(double value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(double std READ std WRITE setStd NOTIFY stdChanged)

public:
    explicit DoubleVariable(QObject *parent = nullptr);
    ~DoubleVariable() = default;
    DoubleVariable(const DoubleVariable&) = default;
    DoubleVariable &operator=(const DoubleVariable&) = default;

    double value() const;
    void setValue(double newValue);
    double std() const;
    void setStd(double newStd);
    void fromString(QString s) override;

signals:

    void valueChanged();
    void stdChanged();

private:

    double m_value;
    double m_std;
};

#endif // DOUBLEVARIABLE_H
