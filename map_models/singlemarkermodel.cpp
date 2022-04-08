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

    if ( role == Coordinates){
        return QVariant::fromValue(coordinate);
    }
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

void SingleMarkerModel::insertCoordinate(QGeoCoordinate coordinate){
    const int index = coords.size();
    beginInsertRows(QModelIndex(), index, index);
    coords.insert(index, coordinate);
    endInsertRows();
}

void SingleMarkerModel::removeCoordinate(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    coords.removeAt(index);
    endRemoveRows();
}
