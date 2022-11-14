/*************************************************************************
 *
 * Abstract List model for bathymetry. This model works as a backend for
 * the dinamically configurable bathymetry function that is available in the
 * interface.
 *
 * Author: Corrado Motta
 * Date: 04/2022
 * Mail: corradomotta92@gmail.com
 *
 *************************************************************************/

#ifndef BATHYMETRYMODEL_H
#define BATHYMETRYMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include "depth_point.h"

class BathymetryModel : public QAbstractListModel
{
    Q_OBJECT

public:

    enum bathRoles{
        CoordinateRole = Qt::UserRole +1,
        TimestampRole,
        ColorHueRole,
        DepthRole
    };

    explicit BathymetryModel(QString folderName, QObject *parent = nullptr);
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    virtual Qt::ItemFlags flags(const QModelIndex &index) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    /**
     * Add a new depth point to the model list.
     *
     * @param Pointer to a Depth_point object.
     */
    void addDepthPoint (Depth_point * depthPoint);

    /**
     * Calculates the hue value based on a specific depth range.
     * The Hue value is then used to give a meaningful color to
     * the bathymetry points.
     *
     * @param Depth of the specific point.
     * @param Maximum depth of the depth range.
     * @param Minimum depth of the depth range.
     * @return The hue value (between 0 and 1).
     */
    double calculateHueValue (const double &depth, const int &maxDepth, const int &minDepth);

    /**
     * Allows to insert a new depth point. This method internally creates a Depth_point objects and
     * adds it to the list using the addDepthPoint method.
     *
     * @param Latitude of the point.
     * @param Longitude of the point.
     * @param Timestamp received from the vehicle.
     * @param Depth value of the point.
     * @param Maximum depth of the depth range.
     * @param Minimum depth of the depth range.
     */
    Q_INVOKABLE void addDepthPoint(const double &lat, const double &lon, const double &timestamp, const double &depth, const int &maxDepth, const int &minDepth);

    /**
     * Remove a specific point from the list.
     *
     * @param The index of the point to remove.
     */
    Q_INVOKABLE void removeDepthPoint(int index);

    /**
     * Sets a new depth range. This method also updates the color of the depth points
     * according to the new range of values.
     *
     * @param Maximum depth of the depth range.
     * @param Minimum depth of the depth range.
     */
    Q_INVOKABLE void newDepthRange(const int &maxDepth, const int &minDepth);

    /**
     * Empties the list.
     */
    Q_INVOKABLE void reset();

    /**
     * Allows to save the bathymetry to list as a plain txt file.
     *
     * @param The filename to be used.
     */
    Q_INVOKABLE QString saveToDisk(QString filename);

private:

    const double m_hueMax = 0.652;
    const double m_hueMin = 0.513;

    QString m_folderName;
    QList<Depth_point*> m_bathymetry;

};

#endif // BATHYMETRYMODEL_H
