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
    virtual int rowCount(const QModelIndex& parent) const override;
    virtual QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    virtual Qt::ItemFlags flags(const QModelIndex &index) const override;
    Q_INVOKABLE void insertCoordinate(QGeoCoordinate coordinate);
    Q_INVOKABLE void removeCoordinate(int index);

public slots:

private: //members
    QVector<QGeoCoordinate> coords;

    // QAbstractItemModel interface
};

#endif // SINGLEMARKERMODEL_H
