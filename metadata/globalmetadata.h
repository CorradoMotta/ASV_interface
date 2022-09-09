#ifndef GLOBALMETADATA_H
#define GLOBALMETADATA_H

#include <QAbstractListModel>
#include <QObject>
#include <QDebug>
#include <QFile>
#include <QDate>
#include <QSettings>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>

class Metadata : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(QString acdd_name READ acdd_name WRITE setAcdd_name NOTIFY acdd_nameChanged)
    Q_PROPERTY(QString defaultValue READ defaultValue WRITE setDefaultValue NOTIFY defaultValueChanged)
    Q_PROPERTY(bool isMandatory READ isMandatory WRITE setIsMandatory NOTIFY isMandatoryChanged)
    Q_PROPERTY(bool isAuto READ isAuto WRITE setIsAuto NOTIFY isAutoChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)

public:
    explicit Metadata(QObject *parent = nullptr);
    Metadata(const QString &name, const QString &acdd_name, const QString &value, const QString &defaultValue, const bool &isMandatory, const bool &isAuto = false, const QString &description = "", QObject *parent = nullptr);

    const QString &defaultValue() const;
    void setDefaultValue(const QString &newDefaultValue);

    const QString &value() const;
    void setValue(const QString &newValue);

    const QString &name() const;
    void setName(const QString &newName);

    bool isMandatory() const;
    void setIsMandatory(bool newIsMandatory);

    const QString &description() const;
    void setDescription(const QString &newDescription);

    const QString &acdd_name() const;
    void setAcdd_name(const QString &newAcdd_name);

    bool isAuto() const;
    void setIsAuto(bool newIsAuto);

signals:
    void defaultValueChanged();
    void valueChanged();
    void nameChanged();
    void isMandatoryChanged();
    void descriptionChanged();
    void acdd_nameChanged();
    void isAutoChanged();

private:
    QString m_name;
    QString m_acdd_name;
    QString m_value;
    QString m_defaultValue;
    bool m_isMandatory;
    bool m_isAuto;
    QString m_description;

};


class GlobalMetadata : public QAbstractListModel
{
    Q_OBJECT


public:
    explicit GlobalMetadata(QObject *parent = nullptr);

    enum metadataRoles{
        nameRole = Qt::UserRole +1,
        acddNameRole,
        valueRole,
        defaultValueRole,
        levelRole, // mandatory or not
        autoRole,
        descriptionRole
    };


public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    virtual Qt::ItemFlags flags(const QModelIndex &index) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    /**
     * Populate the model from JSON.
     */
    void readJson(QString filename);

    /**
     * Empties the values of the metadata.
     */
    Q_INVOKABLE void reset();

    /**
     * Set the default values.
     */
    Q_INVOKABLE void default_values();

    /**
     * Allows to save the metadata as a .ini file
     *
     * @param The filename to be used.
     */
    Q_INVOKABLE QString saveToDisk(QString filename);


private: //members
    QList<Metadata*> m_metadata;

};

#endif // GLOBALMETADATA_H
