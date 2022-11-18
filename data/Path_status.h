/*
 * Path_status.h
 *
 *  Created on: Jun 16, 2020
 *      Author: mx
 */

#ifndef PATH_STATUS_H
#define PATH_STATUS_H

#include <math.h>
#include "custom_types.h"
#include "generic/Variable_c.h"
#include "generic/commands_def.h"
#include <vector>
#include <string>


class PathCommand
{
    private:
        void copy_data(const PathCommand& d)
        {
            cmd_type = d.cmd_type;
            for (int i = 0; i < 12; i++)
                par[i] = d.par[i];
            periodic = d.periodic;
            cw = d.cw;
        }

    public:
        int64 cmd_type;
        double par[12];
        int periodic = 0;
        int cw = 0;

        PathCommand() { zero(); }

        PathCommand(const PathCommand& pv) { (*this) = pv; }

        void zero()
        {
            cmd_type = -1;
            for (int i = 0; i < 12; i++)
                par[i] = 0.0;
            periodic = 0;
            cw = 0;
        }

        PathCommand& operator=(const PathCommand& d)
        {
            copy_data(d);
            return *this;
        }
};


class PathVariable
{
    private:
        void copy_data(const PathVariable& d)
        {
            x = d.x;
            y = d.y;
            t = d.t;
            c = d.c;
            s = d.s;
        }

    public:
        DoubleVariable_c x, y, t, c, s;

        PathVariable() { zero(); }

        PathVariable(const PathVariable& pv) { (*this) = pv; }

        void zero()
        {
            x.zero();
            y.zero();
            t.zero();
            c.zero();
            s.zero();
        }

        PathVariable& operator=(const PathVariable& d)
        {
            copy_data(d);
            return *this;
        }
};


class PathStruct
{
    private:
        void copy_data(const PathStruct& d)
        {
            points = d.points;
            started = d.started;
            periodic = d.periodic;
            path_string.copyVariableFrom(d.path_string);
        }

    public:
        std::vector<PathVariable> points;
        IntVariable_c started, periodic;
        StringVariable_c path_string;

        PathStruct() { zero(); }

        PathStruct(const PathStruct& pv) { (*this) = pv; }

        void zero()
        {
            points.clear();
            started.zero();
            periodic.zero();
            path_string.zero();
        }

        PathStruct& operator=(const PathStruct& d)
        {
            copy_data(d);
            return *this;
        }

        void toString()
        {
            char temp[BUF_SIZE];
            path_string.value = "";

            sprintf(temp, "%d, ", periodic.value);
            path_string.value += temp;

            for (long i = 0; i < points.size(); i++)
            {
                sprintf(temp, "%lf %lf %lf %lf %lf, ", points[i].x.value, points[i].y.value, points[i].c.value, points[i].t.value, points[i].s.value);
                path_string.value += temp;
            }

            path_string.updated = 1;
        }


        void fromString()
        {
            long br = 0;
            int pr = 0;
            char temp[BUF_SIZE];

            PathVariable pv;
            points.clear();

            sscanf(path_string.value.c_str() + br, "%d, ", &(periodic.value));
            while (path_string.value[br++] != ',');

            do {
                pr = sscanf(path_string.value.c_str() + br, " %lf %lf %lf %lf %lf, ", &(pv.x.value), &(pv.y.value), &(pv.c.value), &(pv.t.value), &(pv.s.value));
                while (path_string.value[br++] != ',');
                points.push_back(pv);
            } while (br + 1 < path_string.value.length());
        }
};


class Path_status
{
    private:

        void copy_data(const Path_status&d)
        {
            command = d.command;
            parse_command();

            path_standby = d.path_standby;
            path_active = d.path_active;
        }


        void parse_command_string(std::vector<std::string>& cmd_msg, std::string &cmd_string)
        {
            int i = 0;
            char s[BUF_SIZE];
            std::string str;

            int k = 0;
            do
            {
                if (cmd_string[i] == ' ' || cmd_string[i] == NULL)
                {
                    if (k > 0)
                    {
                        s[k] = NULL;
                        str = s;
                        cmd_msg.push_back(str);
                        k = 0;
                    }
                }
                else
                {
                    s[k] = cmd_string[i];
                    k++;
                }
            } while (cmd_string[i++] != NULL);

        }


    public:

        PathStruct path_standby,path_active;
        StringVariable_c command;
        PathCommand path_cmd_struct;


        Path_status()
        {
            path_standby.zero();
            path_active.zero();
            command.zero();
        }


        Path_status(Path_status&d)
        {
            copy_data(d);
        }


        ~Path_status(){}


        Path_status& operator=(const Path_status&d)
        {
            copy_data(d);
            return *this;
        }


        void parse_command()
        {
            std::vector<std::string> cmd;
            parse_command_string(cmd, command.value);

            if (cmd.size() > 0)
            {

                int i = 1;
                sscanf(cmd[i++].c_str(), "%lld", &(path_cmd_struct.cmd_type));

                if (path_cmd_struct.cmd_type == PATH_PLANNER_COMPUTE_LINE)
                {
                    for (int k = 0; k < 4; k++)
                        sscanf(cmd[i++].c_str(), "%lf", &(path_cmd_struct.par[k]));
                }

                else if (path_cmd_struct.cmd_type == PATH_PLANNER_COMPUTE_CIRCLE)
                {
                    for (int k = 0; k < 4; k++)
                        sscanf(cmd[i++].c_str(), "%lf", &(path_cmd_struct.par[k]));

                    sscanf(cmd[i++].c_str(), "%d", &(path_cmd_struct.periodic));
                    sscanf(cmd[i++].c_str(), "%d", &(path_cmd_struct.cw));
                }

                else if (path_cmd_struct.cmd_type == PATH_PLANNER_COMPUTE_SPLINE)
                {
                    for (int k = 0; k < 12; k++)
                        sscanf(cmd[i++].c_str(), "%lf", &(path_cmd_struct.par[k]));

                    sscanf(cmd[i++].c_str(), "%d", &(path_cmd_struct.periodic));
                }

                else if (path_cmd_struct.cmd_type == PATH_PLANNER_COMPUTE_GRID)
                {
                    for (int k = 0; k < 6; k++)
                        sscanf(cmd[i++].c_str(), "%lf", &(path_cmd_struct.par[k]));
                }
            }

        }



        void switch_path()
        {
            PathStruct temp;
            char standby_str[BUF_SIZE], active_str[BUF_SIZE];

            strcpy(standby_str, path_standby.path_string.topic_name);
            strcpy(active_str, path_active.path_string.topic_name);

            temp = path_active;
            path_active = path_standby;
            path_standby=temp;

            strcpy(path_active.path_string.topic_name , active_str);
            strcpy(path_standby.path_string.topic_name, standby_str);


            path_active.path_string.updated = 1;
        }

};


#endif /* PATH_STATUS_H_*/
