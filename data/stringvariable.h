#ifndef STRINGVARIABLE_H
#define STRINGVARIABLE_H

#include <QObject>
#include <data/variable.h>

class StringVariable : public Variable
{
    Q_OBJECT
    Q_PROPERTY(QString value READ value WRITE setValue NOTIFY valueChanged)

public:
    explicit StringVariable(QObject *parent = nullptr);

    ~StringVariable() = default;
    StringVariable(const StringVariable&) = default;
    StringVariable &operator=(const StringVariable&) = default;

    const QString &value() const;
    void setValue(const QString &newValue);
    void fromString(QString s) override;

signals:

    void valueChanged();

private:
    QString m_value;
};

#endif // STRINGVARIABLE_H
