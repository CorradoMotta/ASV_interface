/*************************************************************************
 *
 * This is the class that will be directly exposed to QML. It does not
 * hold the data itself, instead it simply contains a pointer to the
 * DataSource class. In that way it is possible to dinamically set a
 * different DataSource class in case is needed.
 *
 * Each DataSource class shall contain an instance of the underlying data,
 * (such as SwampStatus). Such data are accessible through the Q_INVOKABLE
 * method getData()
 *
 *************************************************************************/

#ifndef SWAMPMODEL_H
#define SWAMPMODEL_H

#include <QObject>
#include <datasource.h>

class SwampModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(DataSource* data_source READ data_source WRITE set_data_source NOTIFY data_sourceChanged)


public:
    explicit SwampModel(QObject *parent = nullptr);

    DataSource *data_source() const;
    void set_data_source(DataSource *newData_source);

signals:

    void data_sourceChanged();

private:

    DataSource *m_data_source;
};

#endif // SWAMPMODEL_H
