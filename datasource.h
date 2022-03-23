#ifndef DATASOURCE_H
#define DATASOURCE_H

#include <QObject>
#include <swampstatus.h>

class DataSource : public QObject
{
    Q_OBJECT
public:
    explicit DataSource(QObject *parent = nullptr);

signals:

private:
    SwampStatus* m_SwampStatus;
};

#endif // DATASOURCE_H
