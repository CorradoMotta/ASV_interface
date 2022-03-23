#ifndef DEFAULTTYPE_H
#define DEFAULTTYPE_H

#include <QDebug>

class DefaultType{
    Q_GADGET

    Q_PROPERTY(double value READ value WRITE setValue NOTIFY valueChanged)

public:
    DefaultType();
    double value() const;
    void setValue(double newValue);
signals:
    void valueChanged();

private:
    double m_value;
};

//class DefaultType
//{
//    Q_PROPERTY(double value READ value)

//public:
//    DefaultType(double a, double b);
//    DefaultType() = default;

//    ~DefaultType() = default;
//    DefaultType(const DefaultType &) = default;
//    DefaultType &operator=(const DefaultType &) = default;

//    double value() const;
//    double std() const;

//private:
//    double m_value;
//    double m_std;
//};

////! [custom type definition]

////! [custom type meta-type declaration]
//Q_DECLARE_METATYPE(DefaultType);
////! [custom type meta-type declaration]

//////! [custom type streaming operator]
////QDebug operator<<(QDebug dbg, const Message &message);
//////! [custom type streaming operator]


#endif // DEFAULTTYPE_H
