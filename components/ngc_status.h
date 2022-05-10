#ifndef NGC_STATUS_H
#define NGC_STATUS_H

#include <QObject>
#include <data/doublevariable.h>
#include <data/ngc_variable.h>

class NGC_status : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DoubleVariable* psi READ psi NOTIFY psiChanged)
    Q_PROPERTY(NGC_variable* fu READ fu NOTIFY fuChanged)
    Q_PROPERTY(NGC_variable* fv READ fv NOTIFY fvChanged)
    Q_PROPERTY(NGC_variable* fw READ fw NOTIFY fwChanged)
    Q_PROPERTY(NGC_variable* tr READ tr NOTIFY trChanged)
    Q_PROPERTY(DoubleVariable* altitude READ altitude NOTIFY altitudeChanged)

public:
    explicit NGC_status(QObject *parent = nullptr);

    DoubleVariable *psi();
    NGC_variable *fu();
    NGC_variable *fv();
    NGC_variable *fw();
    NGC_variable *tr();
    DoubleVariable *altitude();

signals:

    void psiChanged();
    void fuChanged();
    void fvChanged();
    void fwChanged();
    void trChanged();
    void altitudeChanged();

private:

    DoubleVariable m_psi;
    NGC_variable m_fu;
    NGC_variable m_fv;
    NGC_variable m_fw;
    NGC_variable m_tr;
    DoubleVariable m_altitude;
};

#endif // NGC_STATUS_H
