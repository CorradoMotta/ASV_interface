#include "singlemarkermodel.h"
#include <QDebug>

SingleMarkerModel::SingleMarkerModel(QObject *parent) :
    QAbstractListModel(parent)
{}

int SingleMarkerModel::rowCount( const QModelIndex& parent) const
{
    if (parent.isValid())
        return 0;

    return coords.count();
}

QVariant SingleMarkerModel::data(const QModelIndex &index, int role) const
{
    if ( !index.isValid() )
        return QVariant();

    const QGeoCoordinate &coordinate = coords.at(index.row());

    if ( role == Coordinates)
        return QVariant::fromValue(coordinate);
    else
        return QVariant();
}

QHash<int, QByteArray> SingleMarkerModel::roleNames() const
{
    static QHash<int, QByteArray> mapping {
        {Coordinates, "coordinate"}
    };
    return mapping;
}

void SingleMarkerModel::insertCoordinate(int row, QGeoCoordinate coordinate){
    if (row < 0 || row > coords.count())
        return;

    beginInsertRows(QModelIndex(), row, row);
    coords.insert(row, coordinate);
    endInsertRows();
}
