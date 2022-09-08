#include "globalmetadata.h"

GlobalMetadata::GlobalMetadata(QObject *parent)
    : QAbstractListModel{parent}
{
    m_metadata.append(new Metadata("Title","","",true));
    m_metadata.append(new Metadata("Abstract","","",true));
    m_metadata.append(new Metadata("keywords","","unmanned marine vehicles,marine robotics,autonomous systems",true));
    m_metadata.append(new Metadata("Conventions","","ACDD-1.3,CF-1.6",true));
    m_metadata.append(new Metadata("PI name","","",true));
    m_metadata.append(new Metadata("PI email","","",true));
    m_metadata.append(new Metadata("PI institution","","CNR-INM",true));
    m_metadata.append(new Metadata("Date created","",QDateTime::currentDateTime().toString(Qt::ISODate),true));
    m_metadata.append(new Metadata("Platform","","",true));
    m_metadata.append(new Metadata("License","","Creative Commons",true));
    m_metadata.append(new Metadata("Dataset version","","1.0",true));

    m_metadata.append(new Metadata("ID","","",false));
    m_metadata.append(new Metadata("Processing level","","",false));
    m_metadata.append(new Metadata("Vertical max","","",false));
    m_metadata.append(new Metadata("Vertical min","","",false));
}

int GlobalMetadata::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_metadata.size();
}

QVariant GlobalMetadata::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();
    Metadata *g_metadata = m_metadata[index.row()];

    if ( role == nameRole)
        return g_metadata->name();
    if (role == valueRole)
        return g_metadata->value();
    if (role == DefaultValueRole)
        return g_metadata->defaultValue();
    if (role == levelRole)
        return g_metadata->isMandatory();
    if (role == descriptionRole)
        return g_metadata->description();
    return QVariant();
}

bool GlobalMetadata::setData(const QModelIndex &index, const QVariant &value, int role)
{
    Metadata *g_metadata = m_metadata[index.row()];
    bool somethingChanged = false;

    // at the moment the only element that can change is the value.
    switch(role){
    case nameRole:
    {
        if(g_metadata->name()!= value.toString()){
            g_metadata->setName(value.toString());
            somethingChanged = true;
        }
        break;
    }
    case valueRole:
    {
        if(g_metadata->value()!= value.toString()){
            g_metadata->setValue(value.toString());
            somethingChanged = true;
        }
        break;
    }
    }
    if(somethingChanged){
        emit dataChanged(index,index,QVector<int>()<<role);
        return true;
    }
    return false;

}

Qt::ItemFlags GlobalMetadata::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;
    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> GlobalMetadata::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[nameRole] = "name";
    roles[valueRole] = "value";
    roles[DefaultValueRole] = "defaultValue";
    roles[levelRole] = "isMandatory";
    roles[descriptionRole] = "description";

    return roles;
}

void GlobalMetadata::reset()
{
    QList<Metadata*>::iterator metadata;
    for (metadata = m_metadata.begin(); metadata != m_metadata.end(); ++metadata){
        (*metadata)->setValue("");
        emit dataChanged(QAbstractItemModel::createIndex(metadata - m_metadata.begin(),0),QAbstractItemModel::createIndex(metadata - m_metadata.begin(),0),
                         QVector<int>()<<valueRole);
    }
}

void GlobalMetadata::default_values()
{
    QList<Metadata*>::iterator metadata;
    for (metadata = m_metadata.begin(); metadata != m_metadata.end(); ++metadata){
        (*metadata)->setValue((*metadata)->defaultValue());
        emit dataChanged(QAbstractItemModel::createIndex(metadata - m_metadata.begin(),0),QAbstractItemModel::createIndex(metadata - m_metadata.begin(),0),
                         QVector<int>()<<valueRole);
    }
}

QString GlobalMetadata::saveToDisk(QString filename)
{
    qDebug() << "Not implemented yet!";
}


// --------------
// Metadata class
// --------------

Metadata::Metadata(const QString &name, const QString &value, const QString &defaultValue, const bool &isMandatory, const QString &description, QObject *parent):
    QObject{parent},
    m_name(name),
    m_value(value),
    m_defaultValue(defaultValue),
    m_isMandatory(isMandatory),
    m_description(description)
{

}

const QString &Metadata::name() const
{
    return m_name;
}

void Metadata::setName(const QString &newName)
{
    if (m_name == newName)
        return;
    m_name = newName;
    emit nameChanged();
}

const QString &Metadata::value() const
{
    return m_value;
}

void Metadata::setValue(const QString &newValue)
{
    if (m_value == newValue)
        return;
    m_value = newValue;
    emit valueChanged();
}

const QString &Metadata::defaultValue() const
{
    return m_defaultValue;
}

void Metadata::setDefaultValue(const QString &newDefaultValue)
{
    if (m_defaultValue == newDefaultValue)
        return;
    m_defaultValue = newDefaultValue;
    emit defaultValueChanged();
}

bool Metadata::isMandatory() const
{
    return m_isMandatory;
}

void Metadata::setIsMandatory(bool newIsMandatory)
{
    if (m_isMandatory == newIsMandatory)
        return;
    m_isMandatory = newIsMandatory;
    emit isMandatoryChanged();
}

const QString &Metadata::description() const
{
    return m_description;
}

void Metadata::setDescription(const QString &newDescription)
{
    if (m_description == newDescription)
        return;
    m_description = newDescription;
    emit descriptionChanged();
}
