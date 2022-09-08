#ifndef GLOBALMETADATA_H
#define GLOBALMETADATA_H

#include <QAbstractListModel>
#include <QObject>
#include <QDebug>
#include <QFile>
#include <QDate>

class Metadata : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString value READ value WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(QString defaultValue READ defaultValue WRITE setDefaultValue NOTIFY defaultValueChanged)
    Q_PROPERTY(bool isMandatory READ isMandatory WRITE setIsMandatory NOTIFY isMandatoryChanged)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged)

public:
    explicit Metadata(QObject *parent = nullptr);
    Metadata(const QString &name, const QString &value, const QString &defaultValue, const bool &isMandatory, const QString &description= "", QObject *parent = nullptr);

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

signals:
    void defaultValueChanged();
    void valueChanged();
    void nameChanged();
    void isMandatoryChanged();
    void descriptionChanged();

private:
    QString m_name;
    QString m_value;
    QString m_defaultValue;
    bool m_isMandatory;
    QString m_description;
};


class GlobalMetadata : public QAbstractListModel
{
    Q_OBJECT


public:
    explicit GlobalMetadata(QObject *parent = nullptr);

    enum metadataRoles{
        nameRole = Qt::UserRole +1,
        valueRole,
        DefaultValueRole,
        levelRole, // mandatory or not
        descriptionRole
    };


public:
    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    virtual Qt::ItemFlags flags(const QModelIndex &index) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

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
