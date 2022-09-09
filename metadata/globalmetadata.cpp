#include "globalmetadata.h"

GlobalMetadata::GlobalMetadata(QObject *parent)
    : QAbstractListModel{parent}
{
}

GlobalMetadata::GlobalMetadata(const QString &jsonPath, QObject *parent):
    QAbstractListModel{parent}
{
    // populate the list model from json
    readJson(jsonPath);
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
    if ( role == acddNameRole)
        return g_metadata->acdd_name();
    if (role == valueRole)
        return g_metadata->value();
    if (role == defaultValueRole)
        return g_metadata->defaultValue();
    if (role == levelRole)
        return g_metadata->isMandatory();
    if (role == autoRole)
        return g_metadata->isAuto();
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
    roles[acddNameRole] = "acdd_name";
    roles[valueRole] = "value";
    roles[defaultValueRole] = "defaultValue";
    roles[levelRole] = "isMandatory";
    roles[autoRole] = "isAuto";
    roles[descriptionRole] = "description";

    return roles;
}

void GlobalMetadata::readJson(QString filename)
{
    QString val;
    QFile file;
    QList<Metadata*> o_metadata;

    // open file
    file.setFileName(filename);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    val = file.readAll();
    file.close();

    // set JSON reader
    QJsonDocument d = QJsonDocument::fromJson(val.toUtf8());
    QJsonObject values = d.object().value("data").toObject();

    // Append metadata to the model (for the moment only if not auto)
    foreach(const QString& key, values.keys()) {
        QJsonObject sett4 = values.value(key).toObject();
        if(!sett4.value("auto").toBool() && sett4.value("required").toBool())
            m_metadata.append(new Metadata(sett4.value("name").toString(), // name
                                           sett4.value("ACDD").toString(), // ACDD convention
                                           "", // value
                                           sett4.value("default").toString(), // default value
                                           sett4.value("required").toBool(), // if mandatory
                                           sett4.value("auto").toBool(), // if auto generated
                                           sett4.value("description").toString() // description
                                           ));
        else if(!sett4.value("auto").toBool() && !sett4.value("required").toBool())
            o_metadata.append(new Metadata(sett4.value("name").toString(), // name
                                           sett4.value("ACDD").toString(), // ACDD convention
                                           "", // value
                                           sett4.value("default").toString(), // default value
                                           sett4.value("required").toBool(), // if mandatory
                                           sett4.value("auto").toBool(), // if auto generated
                                           sett4.value("description").toString() // description
                                           ));

    }
    m_metadata.append(o_metadata); // better to sort instead
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
    //QFile file(filename);
    QString filepath =filename;
    QSettings* settings = new QSettings(filepath, QSettings::IniFormat); //QDir::currentPath()
    QList<Metadata*>::iterator metadata;

    settings->beginGroup("mandatory_global_attributes");
    for (metadata = m_metadata.begin(); metadata != m_metadata.end(); ++metadata){
        if((*metadata)->isMandatory()){
            if((*metadata)->value().isEmpty()) qDebug() <<(*metadata)->name() << " should be mandatory but is empty!";
            settings->setValue((*metadata)->acdd_name(),(*metadata)->value());
        }
    }
    settings->endGroup();

    settings->beginGroup("optional_global_attributes");
    for (metadata = m_metadata.begin(); metadata != m_metadata.end(); ++metadata){
        if(! (*metadata)->isMandatory()) settings->setValue((*metadata)->acdd_name(),(*metadata)->value());

    }
    settings->endGroup();

    settings->sync();
    return "Coordinates saved in file location: " + filepath;;
}

// --------------
// Metadata class
// --------------

Metadata::Metadata(const QString &name, const QString &acdd_name, const QString &value, const QString &defaultValue, const bool &isMandatory, const bool &isAuto, const QString &description, QObject *parent):
    QObject{parent},
    m_name(name),
    m_acdd_name(acdd_name),
    m_value(value),
    m_defaultValue(defaultValue),
    m_isMandatory(isMandatory),
    m_isAuto(isAuto),
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

const QString &Metadata::acdd_name() const
{
    return m_acdd_name;
}

void Metadata::setAcdd_name(const QString &newAcdd_name)
{
    if (m_acdd_name == newAcdd_name)
        return;
    m_acdd_name = newAcdd_name;
    emit acdd_nameChanged();
}

bool Metadata::isAuto() const
{
    return m_isAuto;
}

void Metadata::setIsAuto(bool newIsAuto)
{
    if (m_isAuto == newIsAuto)
        return;
    m_isAuto = newIsAuto;
    emit isAutoChanged();
}
