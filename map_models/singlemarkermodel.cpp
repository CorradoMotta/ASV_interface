#include "singlemarkermodel.h"
#include "generic/Variable_c.h"
#include "generic/robotmath.h"

#include <QDebug>

SingleMarkerModel::SingleMarkerModel(QObject *parent) :
    QAbstractListModel(parent)
{}

SingleMarkerModel::SingleMarkerModel(const QGeoCoordinate &origin, QObject *parent):
    QAbstractListModel(parent)
{
    m_origin.geoCorr = origin;
    compute_xy_from_lat_lon(m_origin.geoCorr.latitude(),m_origin.geoCorr.longitude(), m_origin.xyCorr.x, m_origin.xyCorr.y,m_origin.utmzone, m_origin.utmzone_char);
}

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
    roles[XYRole] ="xy";

    return roles;

}

bool SingleMarkerModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    SingleMarker *marker = m_marker[index.row()];
    bool somethingChanged = false;

    switch(role){
    case CoordinateRole:{
        if(marker->coordinate()!= value.value<QGeoCoordinate>()){
            QGeoCoordinate geo_coor = value.value<QGeoCoordinate>();
            // TODO fix it better!
            double coor_x;
            double coor_y;
            double utmzone;
            char utmzone_char;
            compute_xy_from_lat_lon(geo_coor.latitude(), geo_coor.longitude(), coor_x, coor_y, utmzone, utmzone_char);
            marker->setXyCorr(xyVariable(coor_x - m_origin.xyCorr.x, coor_y - m_origin.xyCorr.y));
            marker->setCoordinate(geo_coor);
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
    QPoint p(0,0);
    xyVariable xy(0.0,0.0);
    double coor_x;
    double coor_y;
    double utmzone;
    char utmzone_char;
    compute_xy_from_lat_lon(coordinate.latitude(), coordinate.longitude(), coor_x, coor_y, utmzone, utmzone_char);

    SingleMarker *singleMarker = new SingleMarker(coordinate, group, xyVariable(coor_x - m_origin.xyCorr.x, coor_y - m_origin.xyCorr.y));
    if (index!=-99 && index < m_marker.size()) {
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

QGeoCoordinate SingleMarkerModel::getCoordinate(int index, int model)
{
    return m_marker[index]->coordinate();
}

QGeoPath SingleMarkerModel::generatePath()
{
    // THIS IS A QUICK WAY TO COMPUTE THE PATH, USING ALREADY EXISTING CODE FROM ROBOWORLD
    // IT SHOULD BE REMADE TO BE ALIGNED WITH QT CODE.

    m_line.clearPath();
    QString completeString = "4 3 ";
    QList<SingleMarker*>::iterator single_marker;
    for (single_marker = m_marker.begin(); single_marker != m_marker.end(); ++single_marker){
        completeString = completeString + QString::number((*single_marker)->xyCorr().getX()) + " " + QString::number((*single_marker)->xyCorr().getY()) + " ";

    }
    completeString = completeString + "1 0 1";

    path.command.value = completeString.toStdString();
    path.command.valid = 1;
    path.command.updated = 0;
    path.parse_command();
    if (path.path_cmd_struct.cmd_type == PATH_PLANNER_COMPUTE_SPLINE) compute_spline(path);

    for (auto i: path.path_standby.points){
        double newLat;
        double newLon;
        compute_lat_lon_from_xy( i.x.value + m_origin.xyCorr.x, i.y.value +  m_origin.xyCorr.y, m_origin.utmzone, m_origin.utmzone_char,newLat,newLon);
        m_line.addCoordinate(QGeoCoordinate(newLat,newLon));
    }
    return m_line;
}

SingleMarker::SingleMarker(const QGeoCoordinate &coor, const int group, const xyVariable xyCorr, QObject *parent):
    QObject{parent},
    m_coordinate(coor),
    m_group(group),
    m_xyCorr(xyCorr)
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

const xyVariable &SingleMarker::xyCorr() const
{
    return m_xyCorr;
}

void SingleMarker::setXyCorr(const xyVariable &newXyCorr)
{
    m_xyCorr = newXyCorr;
    emit xyCorrChanged();
}
