#ifndef SINGLEMARKERMODEL_H
#define SINGLEMARKERMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QGeoCoordinate>

class SingleMarkerModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        Coordinates
    };

    explicit SingleMarkerModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex& parent) const override;
    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void insertCoordinate(QGeoCoordinate coordinate);
    Q_INVOKABLE void removeCoordinate(int index);

public slots:
    // this seems to be a QINVOKABLE more then a slot?


private: //members
    QVector<QGeoCoordinate> coords;
};

#endif // SINGLEMARKERMODEL_H
