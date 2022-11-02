/*************************************************************************
 *
 * Class that contains engines data.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

#ifndef MOTOR_STATUS_H
#define MOTOR_STATUS_H

#include <QObject>
#include <data/intvariable.h>

class Motor_status : public QObject
{
    Q_OBJECT
    Q_PROPERTY(IntVariable* thr_power READ thr_power NOTIFY thr_powerChanged)
    Q_PROPERTY(IntVariable* thr_enable READ thr_enable NOTIFY thr_enableChanged)
    Q_PROPERTY(IntVariable* azm_power READ azm_power NOTIFY azm_powerChanged)
    Q_PROPERTY(IntVariable* azm_enable READ azm_enable NOTIFY azm_enableChanged)

public:
    explicit Motor_status(QObject *parent = nullptr);

    IntVariable *thr_power();
    IntVariable *thr_enable();
    IntVariable *azm_power();
    IntVariable *azm_enable();

signals:

    void thr_powerChanged();
    void thr_enableChanged();
    void azm_powerChanged();
    void azm_enableChanged();

private:

    IntVariable m_thr_power;
    IntVariable m_thr_enable;
    IntVariable m_azm_power;
    IntVariable m_azm_enable;
};

#endif // MOTOR_STATUS_H
