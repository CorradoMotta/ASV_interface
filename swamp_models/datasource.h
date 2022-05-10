/*
 * This is the base (virtual) class of dataSource, which enables dynamic network binding.
 */

#ifndef DATASOURCE_H
#define DATASOURCE_H

#include <QObject>

class DataSource : public QObject
{
    Q_OBJECT
public:
    explicit DataSource(QObject *parent = nullptr) : QObject{parent}{}

    /**
     * Send a message out. It is made Q_invokable to be used directly in QML code.
     *
     * @param identifier of the packet that is going to be sent.
     * @param message to be sent.
     *
     */
    Q_INVOKABLE virtual void publishMessage(const QString &identifier, const QString &message) = 0;

    /**
     * Set initial configuration parameters, such as the identifier for each variable.
     * As configuration can also be stored on a file, it is possible to add a parameter with the filename.
     *
     * @param filename path to the configuration file. Default is empty.
     * @return true if configuration is completed properly, false otherwise.
     */
    virtual bool set_cfg(QString filename = "") = 0;

};

#endif // DATASOURCE_H
