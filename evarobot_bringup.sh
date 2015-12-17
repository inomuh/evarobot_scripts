#!/bin/sh

source /opt/ros/indigo/setup.bash
source /home/pi/ros_catkin_ws/devel/setup.bash
source /home/pi/catkin_ws/devel/setup.bash

#/bin/bash $HOME/start/./check_ntp.sh

roscore
roslaunch evarobot_start start.launch
#ns:=$(hostname)&
#rosservice call /evarobot_rgb/SetRGB 1 1 1 1 &
