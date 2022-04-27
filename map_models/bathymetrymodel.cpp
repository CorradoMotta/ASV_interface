#include "bathymetrymodel.h"
#include <qdebug.h>
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

double BathymetryModel::calculateHueValue(const double &depth, const int &maxDepth, const int &minDepth)
{
    // calculate colorHue
    double colorHue;
    if(maxDepth == 0) colorHue = m_hueMax;
    else{
        double tmpHue = (((depth + minDepth)/ (-maxDepth + minDepth)) * (m_hueMax - m_hueMin)) + m_hueMin;
        if(tmpHue > m_hueMax) colorHue = m_hueMax;
        else if(tmpHue < m_hueMin) colorHue = m_hueMin;
        else colorHue = tmpHue;
    }
    return colorHue;
}

void BathymetryModel::addDepthPoint(const QGeoCoordinate &coor, const double &depth, const int &maxDepth, const int &minDepth)
{
    // calculate colorHue
    double colorHue = calculateHueValue(depth, maxDepth, minDepth);
    Depth_point *depthPoint = new Depth_point(coor, colorHue , -depth);
    addDepthPoint(depthPoint);
}

void BathymetryModel::removeDepthPoint(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    m_bathymetry.removeAt(index);
    endRemoveRows();
}

void BathymetryModel::newDepthRange(const int &maxDepth, const int &minDepth)
{

    QList<Depth_point*>::iterator depth_point;
    for (depth_point = m_bathymetry.begin(); depth_point != m_bathymetry.end(); ++depth_point){
        double newColorHue = calculateHueValue(-(*depth_point)->depth(), maxDepth, minDepth);
        (*depth_point)->setColorHue(newColorHue);
        emit dataChanged(QAbstractItemModel::createIndex(depth_point - m_bathymetry.begin(),0),QAbstractItemModel::createIndex(depth_point - m_bathymetry.begin(),0),
                         QVector<int>()<<ColorHueRole);
    }
}


