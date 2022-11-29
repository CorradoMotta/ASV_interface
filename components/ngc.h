#ifndef NGC_H
#define NGC_H

#include <QObject>
#include <components/ngc_command.h>
#include <components/ngc_status.h>
class NGC : public QObject
{
    Q_OBJECT
    Q_PROPERTY(NGC_command* ngcCmd READ ngcCmd NOTIFY ngcCmdChanged)
    Q_PROPERTY(NGC_status* ngc_status READ ngc_status NOTIFY ngc_statusChanged)

public:
    explicit NGC(QObject *parent = nullptr);

    NGC_command *ngcCmd();
    NGC_status *ngc_status();

signals:

    void ngcCmdChanged();
    void ngc_statusChanged();

private:
    NGC_command m_ngcCmd;
    NGC_status m_ngc_status;

};

#endif // NGC_H
