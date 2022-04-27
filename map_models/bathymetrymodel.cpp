#include "bathymetrymodel.h"

BathymetryModel::BathymetryModel(QObject *parent)
    : QAbstractListModel{parent}
{

}

int BathymetryModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_bathymetry.size();
}

QVariant BathymetryModel::data(const QModelIndex &index, int role) const
{
    if(index.row() <0 || index.row() >= m_bathymetry.count())
        return QVariant();
    Depth_point *depth_point = m_bathymetry[index.row()];
    if(role == CoordinateRole)
        return QVariant::fromValue(depth_point->coordinate());
    if(role == ColorHueRole)
        return depth_point->colorHue();
    if(role == DepthRole)
        return depth_point->depth();
    return QVariant();
}

bool BathymetryModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Depth_point *depth_point = m_bathymetry[index.row()];
    bool somethingChanged = false;

    switch(role){
    case ColorHueRole:
    {
        if(depth_point->colorHue()!= value.toDouble()){
            depth_point->setColorHue(value.toDouble());
            somethingChanged = true;
        }
    }
        break;
    case DepthRole:
    {
        if(depth_point->depth()!= value.toDouble()){
            depth_point->setDepth(value.toDouble());
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
Qt::ItemFlags BathymetryModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> BathymetryModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[CoordinateRole] = "coordinate";
    roles[ColorHueRole] = "colorHue";
    roles[DepthRole] = "depth";

    return roles;
}

void BathymetryModel::addDepthPoint(Depth_point *depthPoint)
{
    const int index = m_bathymetry.size();
    beginInsertRows(QModelIndex(),index,index);
    m_bathymetry.append(depthPoint);
    endInsertRows();
}

void BathymetryModel::addDepthPoint(const QGeoCoordinate &coor, const double &colorHue, const double &depth)
{
    Depth_point *depthPoint = new Depth_point(coor,colorHue,depth);
    addDepthPoint(depthPoint);
}

void BathymetryModel::removeDepthPoint(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    m_bathymetry.removeAt(index);
    endRemoveRows();
}
