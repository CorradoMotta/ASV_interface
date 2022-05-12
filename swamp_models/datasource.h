/*
 * This is the base (virtual) class of dataSource, which enables dynamic network binding.
 */

#ifndef DATASOURCE_H
#define DATASOURCE_H

#include <QObject>
#include <QTimer>

#include <swamp_models/swampstatus.h>
#include "data/stringvariable.h"

class DataSource : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool is_connected READ is_connected WRITE set_is_connected NOTIFY is_connectedChanged)
    Q_PROPERTY(SwampStatus* swamp_status READ swamp_status NOTIFY swamp_statusChanged)

public:
    explicit DataSource(QObject *parent = nullptr) : QObject{parent}, m_is_connected{false}{}

    /**
     * Set a connection on the underlying protocol.
     *
     */
    Q_INVOKABLE virtual void setConnection() = 0;

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

    /**
     * Q_PROPERTY read method. Check if connection is established.
     *
     * @return true if connection is established, false otherwise.
     */
    bool is_connected() const;

    /**
     * Q_PROPERTY write method. Set the status of the connection.
     *
     * @param filename path to the configuration file. Default is empty.
     * @return true if configuration is completed properly, false otherwise.
     */
    void set_is_connected(bool newIs_connected);

    /**
     * Q_PROPERTY read method for swampStatus.
     *
     * @return Pointer to SwampStatus.
     */
    SwampStatus *swamp_status();

signals:

    void is_connectedChanged();
    void swamp_statusChanged();

protected:

    bool m_is_connected;
    SwampStatus m_swamp_status;
};

inline SwampStatus *DataSource::swamp_status()
{
    return &m_swamp_status;
}

inline bool DataSource::is_connected() const
{
    return m_is_connected;
}

inline void DataSource::set_is_connected(bool newIs_connected)
{
    if (m_is_connected == newIs_connected)
        return;
    m_is_connected = newIs_connected;
    emit is_connectedChanged();
}

#endif // DATASOURCE_H
