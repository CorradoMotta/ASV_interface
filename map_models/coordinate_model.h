/*************************************************************************
 *
 * Abstract List model for points set on the map where the vehicle stands.
 * This modelc allows to store coordinates of interests with their names,
 * to remove or modify any stored coordinate and to download them to a
 * textual file, using the "saveToDisk" function.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

#ifndef COORDINATE_MODEL_H
#define COORDINATE_MODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QGeoCoordinate>
#include <QFile>

// Class that contains information of a single coordinate/marker
class SingleCoordinate : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QGeoCoordinate coordinate READ coordinate WRITE setCoordinate NOTIFY coordinateChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(double timestamp READ timestamp WRITE setTimestamp NOTIFY timestampChanged)

public:
    explicit SingleCoordinate(QObject *parent = nullptr);
    SingleCoordinate(const QGeoCoordinate &coor, const QString &name, const double &timestamp = 0, QObject *parent = nullptr);

    const QGeoCoordinate &coordinate() const;
    void setCoordinate(const QGeoCoordinate &newCoordinate);

    const QString &name() const;
    void setName(const QString &newName);

    double timestamp() const;
    void setTimestamp(double newTimestamp);

signals:

    void coordinateChanged();
    void nameChanged();
    void timestampChanged();

private:

    QGeoCoordinate m_coordinate;
    QString m_name;
    double m_timestamp;
};

class Coordinate_model : public QAbstractListModel
{
    Q_OBJECT

public:

    enum coorRoles{
        CoordinateRole = Qt::UserRole +1,
        NameRole,
        TimestampRole
    };

    explicit Coordinate_model(QObject *parent = nullptr);
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    virtual Qt::ItemFlags flags(const QModelIndex &index) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    /**
     * Add a new marker to the model list.
     *
     * @param Pointer to a single coordinate object.
     */
    void addMarker(SingleCoordinate* singleCoor);

    /**
     * Allows to insert a new single coordinate. This method internally creates a singleCoordinate object and
     * adds it to the list using the addMarker method.
     *
     * @param The geographical coordinates of the point.
     * @param The name to give to the point. Default is no_name
     * @param The timestamp. Default value is 0.
     */
    Q_INVOKABLE void insertSingleMarker(QGeoCoordinate coordinate, QString name = "no_name", double timestamp=0);

    /**
     * Remove a specific coordinate point from the list.
     *
     * @param The index of the marker to remove.
     */
    Q_INVOKABLE void removeSingleMarker(int index);

    /**
     * Empties the list.
     */
    Q_INVOKABLE void reset();

    /**
     * Allows to save the coordinate to list as a plain txt file.
     *
     * @param The filename to be used.
     */
    Q_INVOKABLE QString saveToDisk(QString filename);

private: //members
    QList<SingleCoordinate*> m_coors;
};

#endif // COORDINATE_MODEL_H
