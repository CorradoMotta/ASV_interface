#ifndef BATHYMETRYMODEL_H
#define BATHYMETRYMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include "depth_point.h"

class BathymetryModel : public QAbstractListModel
{
    Q_OBJECT

    enum bathRoles{
        CoordinateRole = Qt::UserRole +1,
        ColorHueRole,
        DepthRole
    };

signals:

    // QAbstractItemModel interface
public:
    explicit BathymetryModel(QObject *parent = nullptr);
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    virtual Qt::ItemFlags flags(const QModelIndex &index) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    void addDepthPoint (Depth_point * depthPoint);
    double calculateHueValue (const double &depth, const int &maxDepth, const int &minDepth);
    Q_INVOKABLE void addDepthPoint(const QGeoCoordinate &coor, const double &depth, const int &maxDepth, const int &minDepth);
    Q_INVOKABLE void removeDepthPoint(int index);
    Q_INVOKABLE void newDepthRange(const int &maxDepth, const int &minDepth);


private:
    QList<Depth_point*> m_bathymetry;
    const double m_hueMax = 0.652;
    const double m_hueMin = 0.513;
};

#endif // BATHYMETRYMODEL_H
