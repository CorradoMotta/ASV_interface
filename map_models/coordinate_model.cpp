#include "coordinate_model.h"
#include <QDir>
#include <qdebug.h>

Coordinate_model::Coordinate_model(QObject *parent) :
    QAbstractListModel(parent)
{

}

int Coordinate_model::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_coors.size();
}

QVariant Coordinate_model::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    SingleCoordinate *coor = m_coors[index.row()];

    if ( role == CoordinateRole)
        return QVariant::fromValue(coor->coordinate());
    else
        return QVariant();
}

bool Coordinate_model::setData(const QModelIndex &index, const QVariant &value, int role)
{
    //const QGeoCoordinate &coordinate = value.value<QGeoCoordinate>();
    SingleCoordinate *coor = m_coors[index.row()];
    bool somethingChanged = false;

    switch(role){
    case CoordinateRole:{
        if(coor->coordinate()!= value.value<QGeoCoordinate>()){
            coor->setCoordinate(value.value<QGeoCoordinate>());
            somethingChanged = true;
        }
    }
        break;
    case NameRole:{
        if(coor->name().compare(value.toString())!=0){
            coor->setName(value.toString());
            somethingChanged = true;
        }
    }
        break;
    case TimestampRole:{
        if(coor->timestamp() != value.toDouble()){
            coor->setTimestamp(value.toDouble());
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

Qt::ItemFlags Coordinate_model::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> Coordinate_model::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[CoordinateRole] = "coordinate";
    roles[NameRole] = "name";
    roles[TimestampRole] = "timestamp";

    return roles;
}

void Coordinate_model::addMarker(SingleCoordinate *singleCoor)
{
    const int index = m_coors.size();
    beginInsertRows(QModelIndex(),index,index);
    m_coors.append(singleCoor);
    endInsertRows();
}

void Coordinate_model::insertSingleMarker(QGeoCoordinate coordinate, QString name, double timestamp)
{
    SingleCoordinate *singleCoordinate;
    if(name.isEmpty()) singleCoordinate = new SingleCoordinate(coordinate, "UNNAMED", timestamp);
    else singleCoordinate = new SingleCoordinate(coordinate, name, timestamp);
    addMarker(singleCoordinate);
}

void Coordinate_model::removeSingleMarker(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    m_coors.removeAt(index);
    endRemoveRows();
}

void Coordinate_model::reset()
{
    beginRemoveRows(QModelIndex(), 0 , m_coors.size()-1);
    m_coors.clear();
    endRemoveRows();
}

QString Coordinate_model::saveToDisk(QString filename)
{
    if(m_coors.isEmpty()){
        return "Dataset is empty. No data to save";
    }
    // TODO if file exists already i should not add first line!
    else{
        QFile file(filename);

        if (!file.open(QIODevice::Append | QIODevice::Text))
            return "Problem in creating the file. Try again.";

        QTextStream out(&file);
        //out << "Timestamp"<< " " "Name"<< " " << "Latitude" << " " <<"Longitude"<< "\n";
        QList<SingleCoordinate*>::iterator single_coordinate;
        for (single_coordinate = m_coors.begin(); single_coordinate != m_coors.end(); ++single_coordinate)
            out << qSetRealNumberPrecision( 10 )
                << (*single_coordinate)->timestamp() << " "
                << (*single_coordinate)->name() << " "
                << (*single_coordinate)->coordinate().latitude() << " "
                << (*single_coordinate)->coordinate().longitude() << " "
                << "\n";

        file.close();
        return "Coordinates saved in file location: " + filename;
    }
}

SingleCoordinate::SingleCoordinate(const QGeoCoordinate &coor, const QString &name, const double &timestamp, QObject *parent):
    QObject{parent},
    m_coordinate(coor),
    m_name(name),
    m_timestamp(timestamp)
{

}

const QGeoCoordinate &SingleCoordinate::coordinate() const
{
    return m_coordinate;
}

void SingleCoordinate::setCoordinate(const QGeoCoordinate &newCoordinate)
{
    if (m_coordinate == newCoordinate)
        return;
    m_coordinate = newCoordinate;
    emit coordinateChanged();
}

const QString &SingleCoordinate::name() const
{
    return m_name;
}

void SingleCoordinate::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}

double SingleCoordinate::timestamp() const
{
    return m_timestamp;
}

void SingleCoordinate::setTimestamp(double newTimestamp)
{
    if (qFuzzyCompare(m_timestamp, newTimestamp))
        return;
    m_timestamp = newTimestamp;
    emit timestampChanged();
}
