/*
 * Data_status.h
 *
 *  Created on: Jan 21, 2019
 *      Author: mx
 */

#ifndef VARIABLE_C_H
#define VARIABLE_C_H

#include <stdio.h>
#include <string>
#include <cstring>
#include "data/custom_types.h"
#include "data/define.h"

// NOTE: THIS IS A WORKAROUND, ADDED FOR PATH STATUS and COMPUTE SPLINE. IT SHOULD BE REMOVED
// A POSSIBLE SOLUTION IS TO MAKE THE MEMBERS OF ALL THE VARIABLE CLASSES IN DATA PUBLIC INSTEAD
// OF PRIVATE. (JUST FOR GENERATING PATHS, GET AND SET METHOD SHALL BE USED FOR ALL OTHERS NEEDS)

class Variable_c
{
    public:
        char topic_name[BUF_SIZE];
        int updated;
        int valid;
        uint64 timeStamp;

        Variable_c()
        {
            zero();
        }


        virtual void zero() { updated = 0; valid = 0; timeStamp = 0; strcpy(topic_name, ""); }

        virtual void toString(char* s)=0;
        virtual void fromString(char* s, int v = 1, int up = 1) = 0;

        virtual void toString(std::string &s) = 0;
        virtual void fromString(std::string &s, int v = 1, int up = 1) = 0;
};



class IntVariable_c :public Variable_c
{
    public:
        int64 value;

        IntVariable_c()
        {
            zero();
        }


        IntVariable_c(IntVariable_c& v)
        {
            (*this).copyVariableFrom(v);
        }


        IntVariable_c& copyValueFrom(const IntVariable_c& p)
        {
            value = p.value;
            timeStamp = p.timeStamp;
            valid = p.valid;
            updated = p.updated;

            return *this;
        }

        IntVariable_c& copyVariableFrom(const IntVariable_c& p)
        {
            value = p.value;
            timeStamp = p.timeStamp;
            valid = p.valid;
            updated = p.updated;
            strcpy(topic_name, p.topic_name);

            return *this;
        }

        IntVariable_c& operator=(const IntVariable_c& p)
        {
            return copyVariableFrom(p);
        }


        virtual void zero()
        {
            value = 0;  timeStamp = 0; valid = 0; updated = 0; strcpy(topic_name, "");
        }


        virtual void toString(char* s)
        {
            sprintf(s,"%lli %llu %d",value, timeStamp, valid);
        }

        virtual void fromString(char* s, int v=1,int up=1)
        {
            value = 0;  valid = -1;  timeStamp = 0;
            sscanf(s, "%lli %llu %d", &value, &timeStamp, &valid);
            if (valid == -1) valid = v;
            updated = up;
        }


        virtual void toString(std::string &s)
        {
            char temp[BUF_SIZE];
            sprintf(temp, "%lli %llu %d", value, timeStamp, valid);
            s = temp;
        }

        virtual void fromString(std::string &s, int v = 1, int up = 1)
        {
            char temp[BUF_SIZE];
            value = 0;  valid = -1;  timeStamp = 0;
            sscanf(temp, "%lli %llu %d", &value, &timeStamp, &valid);
            s = temp;
            if (valid == -1) valid = v;
            updated = up;
        }

};


class DoubleVariable_c :public Variable_c
{
    public:
        double value;
        double std;

        DoubleVariable_c()
        {
            zero();
        }

        DoubleVariable_c(DoubleVariable_c& v)
        {
            (*this).copyVariableFrom(v);
        }

        DoubleVariable_c& copyValueFrom(const DoubleVariable_c& p)
        {
            value = p.value;
            std = p.std;
            timeStamp = p.timeStamp;
            valid = p.valid;
            updated = p.updated;

            return *this;
        }


        DoubleVariable_c& copyVariableFrom(const DoubleVariable_c& p)
        {
            value = p.value;
            std = p.std;
            timeStamp = p.timeStamp;
            valid = p.valid;
            updated = p.updated;
            strcpy(topic_name, p.topic_name);

            return *this;
        }

        DoubleVariable_c& operator=(const DoubleVariable_c& p)
        {
            return copyVariableFrom(p);
        }

        virtual void zero()
        {
            value = 0.0;  std = 0.0; timeStamp = 0; valid = 0; updated = 0; strcpy(topic_name, "");
        }


        virtual void toString(char* s)
        {
            sprintf(s, "%.8lf %llu %d %.8lf", value, timeStamp, valid, std);
        }


        virtual void fromString(char* s, int v = 1,int up=1)
        {
            value = 0.0;  std = 0.0;  valid = -1;  timeStamp = 0;
            char* p=s;

            do {
                p = strstr(p, ",");
                if (p != NULL) *p = '.';
            } while (p != NULL);

            sscanf(s, "%lf %llu %d %lf", &value, &timeStamp, &valid,&std);
            if (valid == -1) valid = v;
            updated = up;
        }


        virtual void toString(std::string &s)
        {
            char temp[BUF_SIZE];
            sprintf(temp, "%.8lf %llu %d %.8lf", value, timeStamp, valid, std);
            s = temp;
        }

        virtual void fromString(std::string& s, int v = 1, int up = 1)
        {
            char temp[BUF_SIZE];
            value = 0.0;  std = 0.0;  valid = -1;  timeStamp = 0;
            sscanf(temp, "%lf %llu %d %lf", &value, &timeStamp, &valid, &std);
            s = temp;
            if (valid == -1) valid = v;
            updated = up;
        }
};



class StringVariable_c :public Variable_c
{
public:
    //char value[BUF_SIZE];
    std::string value;

    StringVariable_c()
    {
        zero();
    }

    StringVariable_c(StringVariable_c& v)
    {
        (*this).copyVariableFrom(v);
    }

    StringVariable_c& copyValueFrom(const StringVariable_c& p)
    {
        //strcpy(value, p.value);
        value = p.value;
        timeStamp = p.timeStamp;
        valid = p.valid;
        updated = p.updated;

        return *this;
    }


    StringVariable_c& copyVariableFrom(const StringVariable_c& p)
    {
        //strcpy(value, p.value);
        value = p.value;
        timeStamp = p.timeStamp;
        valid = p.valid;
        updated = p.updated;
        strcpy(topic_name, p.topic_name);

        return *this;
    }

    StringVariable_c& operator=(const StringVariable_c& p)
    {
        return copyVariableFrom(p);
    }

    virtual void zero()
    {
        //strcpy(value, "");
        value = "";
        timeStamp = 0; valid = 0; updated = 0; strcpy(topic_name, "");
    }


    virtual void toString(char* s)
    {
        strcpy(s, value.c_str());
    }

    virtual void fromString(char* s, int v = 1, int up = 1)
    {
        value=s;
        if (valid == -1) valid = v;
        updated = up;
    }

    virtual void toString(std::string& s)
    {
        s = value;
    }

    virtual void fromString(std::string &s, int v = 1, int up = 1)
    {
        value=s;
        if (valid == -1) valid = v;
        updated = up;
    }
};



#endif /* VARIABLE_C_H*/
