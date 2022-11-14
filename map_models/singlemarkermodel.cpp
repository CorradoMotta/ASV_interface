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
    if(role == XYRole)
        return marker->xyCoor();
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
    roles[XYRole] ="xy";

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
    int index = m_marker.size();
    beginInsertRows(QModelIndex(),index,index);
    m_marker.append(singleMarker);
    endInsertRows();
}

void SingleMarkerModel::insertSingleMarker(QGeoCoordinate coordinate, int group, int index)
{
    QPoint p( 0, 0);
    SingleMarker *singleMarker = new SingleMarker(coordinate, group,p);
    if (index!=-99 && index < m_marker.size()) {

        //addMarker(singleMarker,index);//QAbstractListModel::setData(index, coordinate, CoordinateRole);
        SingleMarker *marker = m_marker[index];
        marker->setCoordinate(coordinate);
        emit dataChanged(QAbstractItemModel::createIndex(index,0),QAbstractItemModel::createIndex(index,0),
                         QVector<int>()<<CoordinateRole);
    }
    else addMarker(singleMarker);
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

QString SingleMarkerModel::readDataFromFile(QString filename)
{
    if( m_marker.size()!=0) return "Please remove all existing points before uploading";

    QFileInfo info(filename);
    QString ext= info.suffix();
    if(QString::compare(ext, "gpx", Qt::CaseInsensitive)!=0)
        return "File extension should be gpx, not: " + ext;

    QUrl url(filename);

    QFile file(url.toLocalFile());

    if (!file.open(QIODevice::ReadOnly)){
        return "Failed to open file: " + file.fileName() + ". Error: " + file.errorString();
    }

    QXmlStreamReader inputStream(&file);
    while (!inputStream.atEnd() && !inputStream.hasError())
    {
        inputStream.readNext();
        if (inputStream.isStartElement()) {
            QString name = inputStream.name().toString();
            if (name == "trkpt" || name == "wpt")
                insertSingleMarker(QGeoCoordinate(inputStream.attributes().value("lat").toFloat(), inputStream.attributes().value("lon").toFloat()));
        }
    }

    return "All values imported!";
}

QGeoCoordinate SingleMarkerModel::getCoordinate(int index)
{
    return m_marker[index]->coordinate();
}

SingleMarker::SingleMarker(QObject *parent)
    : QObject{parent}
{

}

SingleMarker::SingleMarker(const QGeoCoordinate &coor, const int group, const QPoint xyCorr, QObject *parent):
    QObject{parent},
    m_coordinate(coor),
    m_group(group),
    m_xyCoor(xyCorr)
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

QPoint SingleMarker::xyCoor() const
{
    return m_xyCoor;
}

void SingleMarker::setXyCoor(QPoint newXyCoor)
{
    if (m_xyCoor == newXyCoor)
        return;
    m_xyCoor = newXyCoor;
    emit xyCoorChanged();
}
