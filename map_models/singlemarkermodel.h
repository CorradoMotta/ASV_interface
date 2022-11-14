/*************************************************************************
 *
 * Abstract List model for points and lines drawn on the map. This model
 * allows to store coordinates (as part of the SingleMarker class), to
 * upload an existing dataset into the map (in the GPX format),
 * to remove or modify any stored coordinate and to send them to the
 * vehicle.
 *
 * Note: this class has been modified to allow only one marker to be
 * inserted at a time.
 *
 * Author: Corrado Motta
 * Date: 06/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

#ifndef SINGLEMARKERMODEL_H
#define SINGLEMARKERMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QGeoCoordinate>
#include <QFile>
#include <QFileInfo>
#include <QXmlStreamReader>
#include <QUrl>
#include <QPoint>

// Class that contains information of a single point/marker
class SingleMarker : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QGeoCoordinate coordinate READ coordinate WRITE setCoordinate NOTIFY coordinateChanged)
    Q_PROPERTY(int group READ group WRITE setGroup NOTIFY groupChanged)
    Q_PROPERTY(QPoint xyCoor READ xyCoor WRITE setXyCoor NOTIFY xyCoorChanged)

public:
    explicit SingleMarker(QObject *parent = nullptr);
    SingleMarker(const QGeoCoordinate &coor, const int group, const QPoint xyCoor,  QObject *parent = nullptr);

    const QGeoCoordinate &coordinate() const;
    void setCoordinate(const QGeoCoordinate &newCoordinate);

    int group() const;
    void setGroup(int newGroup);

    QPoint xyCoor() const;
    void setXyCoor(QPoint newXyCoor);

signals:

    void coordinateChanged();
    void groupChanged();
    void xyCoorChanged();

private:

    QGeoCoordinate m_coordinate;
    int m_group;
    QPoint m_xyCoor;
};

// Abstract Interface Model
class SingleMarkerModel : public QAbstractListModel
{
    Q_OBJECT

public:

    enum markerRoles {
        CoordinateRole = Qt::UserRole +1,
        XYRole,
        GroupRole
    };

    explicit SingleMarkerModel(QObject *parent = nullptr);
    virtual int rowCount(const QModelIndex& parent) const override;
    virtual QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    virtual Qt::ItemFlags flags(const QModelIndex &index) const override;

    /**
     * Add a new marker to the model list.
     *
     * @param Pointer to a single marker object.
     */
    void addMarker(SingleMarker* singleMarker);

    /**
     * Allows to insert a new single marker. This method internally creates a singleMarker objects and
     * adds it to the list using the addMarker method.
     *
     * @param The geographical coordinates of the point.
     * @param The group which it belongs to. Not used yet. Default value is 0.
     * @param The index where you want to insert the marker (leave it empty to append a new value).
     */
    Q_INVOKABLE void insertSingleMarker(QGeoCoordinate coordinate, int group = 0, int index = -99);

    /**
     * Remove a specific marker from the list.
     *
     * @param The index of the marker to remove.
     */
    Q_INVOKABLE void removeSingleMarker(int index);

    /**
     * Empties the list.
     */
    Q_INVOKABLE void reset();

    /**
     * Allows to import data from file. This method only works if the dataset list is empty and with GPX
     * format.
     *
     * @param Full path + filename of the file to be imported.
     * @return A string with a message to be displayed on the interface.
     */
    Q_INVOKABLE QString readDataFromFile(QString filename);

    /**
     * Returns the coordinate at a specific index.
     *
     * @param Full path + filename of the file to be imported.
     * @return A string with a message to be displayed on the interface.
     */
    Q_INVOKABLE QGeoCoordinate getCoordinate (int index);

public slots:

private: //members
    QList<SingleMarker*> m_marker;
};

#endif // SINGLEMARKERMODEL_H
