#ifndef SWAMP_MOTOR_STATUS_H
#define SWAMP_MOTOR_STATUS_H

#include <QObject>
#include <motor_status.h>

class Swamp_motor_status : public QObject
{
    Q_OBJECT
    Q_PROPERTY(Motor_status* f1 READ f1 NOTIFY f1Changed)
    Q_PROPERTY(Motor_status* f2 READ f2 NOTIFY f2Changed)
    Q_PROPERTY(Motor_status* f3 READ f3 NOTIFY f3Changed)
    Q_PROPERTY(Motor_status* f4 READ f4 NOTIFY f4Changed)

public:
    explicit Swamp_motor_status(QObject *parent = nullptr);

    Motor_status *f1();
    Motor_status *f2();
    Motor_status *f3();
    Motor_status *f4();

signals:

    void f1Changed();
    void f2Changed();
    void f3Changed();
    void f4Changed();


private:
    Motor_status m_f1;
    Motor_status m_f2;
    Motor_status m_f3;
    Motor_status m_f4;

};

#endif // SWAMP_MOTOR_STATUS_H
