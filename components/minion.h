/*************************************************************************
 *
 * Class containing minion commands and minion status.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

#ifndef MINION_H
#define MINION_H

#include <QObject>
#include <components/minion_command.h>
#include <components/minion_status.h>

class Minion : public QObject
{

    Q_OBJECT
    Q_PROPERTY(MinionCommand* minionCmd READ minionCmd NOTIFY minionCmdChanged)
    Q_PROPERTY(MinionStatus* minionState READ minionState NOTIFY minionStateChanged)

public:
    explicit Minion(QObject *parent = nullptr);

    MinionCommand *minionCmd();
    MinionStatus *minionState();

signals:

    void minionCmdChanged();
    void minionStateChanged();

private:

    MinionCommand m_minionCmd;
    MinionStatus m_minionState;
};

#endif // MINION_H
