#include "singlemarkermodel.h"
#include <QDebug>

SingleMarkerModel::SingleMarkerModel(QObject *parent) :
    QAbstractListModel(parent)
{}

int SingleMarkerModel::rowCount( const QModelIndex& parent) const
{
    Q_UNUSED(parent)
    return m_marker.size();
}

QVariant SingleMarkerModel::data(const QModelIndex &index, int role) const
{    
    if ( !index.isValid() )
        return QVariant();
    SingleMarker *marker = m_marker[index.row()];

    if ( role == CoordinateRole)
        return QVariant::fromValue(marker->coordinate());
    if(role == GroupRole)
        return marker->group();
    else
        return QVariant();
}

QHash<int, QByteArray> SingleMarkerModel::roleNames() const
{

    QHash<int, QByteArray> roles;
    roles[CoordinateRole] = "coordinate";
    roles[GroupRole] = "group";

    return roles;

}

bool SingleMarkerModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    //const QGeoCoordinate &coordinate = value.value<QGeoCoordinate>();
    SingleMarker *marker = m_marker[index.row()];
    bool somethingChanged = false;

    switch(role){
    case CoordinateRole:{
        if(marker->coordinate()!= value.value<QGeoCoordinate>()){
            marker->setCoordinate(value.value<QGeoCoordinate>());
            somethingChanged = true;
        }
    }
        break;
    case GroupRole:{
        if(marker->group()!= value.toInt()){
            marker->setGroup(value.toDouble());
            somethingChanged = true;
        }
    }
        break;
    }

    if(somethingChanged){
        emit dataChanged(index,index,QVector<int>()<<role);
        return true;
    }
    return false;

}

Qt::ItemFlags SingleMarkerModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEditable;
}

void SingleMarkerModel::addMarker(SingleMarker *singleMarker)
{
    const int index = m_marker.size();
    beginInsertRows(QModelIndex(),index,index);
    m_marker.append(singleMarker);
    endInsertRows();
//    for (int var = 0; var < m_marker.size(); ++var) {
//        qDebug() << m_marker[var]->coordinate();
//    }
}

void SingleMarkerModel::insertSingleMarker(QGeoCoordinate coordinate, int group)
{
    // TODO group is not used yet.
    SingleMarker *singleMarker = new SingleMarker(coordinate, group);
    addMarker(singleMarker);
}

void SingleMarkerModel::removeSingleMarker(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    m_marker.removeAt(index);
    endRemoveRows();
}

void SingleMarkerModel::reset()
{
    beginRemoveRows(QModelIndex(), 0 , m_marker.size()-1);
    m_marker.clear();
    endRemoveRows();
}

SingleMarker::SingleMarker(QObject *parent)
    : QObject{parent}
{

}

SingleMarker::SingleMarker(const QGeoCoordinate &coor, const int group, QObject *parent):
    QObject{parent},
    m_coordinate(coor),
    m_group(group)
{

}

const QGeoCoordinate &SingleMarker::coordinate() const
{
    return m_coordinate;
}

void SingleMarker::setCoordinate(const QGeoCoordinate &newCoordinate)
{
    if (m_coordinate == newCoordinate)
        return;
    m_coordinate = newCoordinate;
    emit coordinateChanged();
}

int SingleMarker::group() const
{
    return m_group;
}

void SingleMarker::setGroup(int newGroup)
{
    if (m_group == newGroup)
        return;
    m_group = newGroup;
    emit groupChanged();
}
