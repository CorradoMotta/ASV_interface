#ifndef NGC_STATUS_H
#define NGC_STATUS_H

#include <QObject>
#include <doublevariable.h>

class NGC_status : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DoubleVariable* psi READ psi NOTIFY psiChanged)


public:
    explicit NGC_status(QObject *parent = nullptr);

    DoubleVariable *psi();

signals:

    void psiChanged();

private:

    DoubleVariable m_psi;
};

#endif // NGC_STATUS_H
