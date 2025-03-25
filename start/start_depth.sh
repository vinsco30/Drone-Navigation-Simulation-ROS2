#!/bin/bash

tmux new-session -s nav_layout -d
tmux split-window -h -t nav_layout 
tmux split-window -v -t nav_layout
tmux split-window -v -t nav_layout:0.0 
tmux split-window -v -t nav_layout:0.1
#tmux send-keys -t nav_layout:0.0 "ros2 launch leonardo_field_description launch_leonardo_race_field.py" C-m  # Open gz garden world
#tmux send-keys -t nav_layout:0.1 'PX4_SYS_AUTOSTART=4002 PX4_GZ_MODEL=x500_depth PX4_GZ_MODEL_POSE= "-9.5 -3.5 0.5" ./PX4-Autopilot-PRISMA/build/px4_sitl_default/bin/px4' C-m  # Spawn x500 depth
tmux send-keys -t nav_layout:0.0 "cd ../PX4-Autopilot-PRISMA && make px4_sitl gz_x500_depth" C-m  # Spawn x500 depth
tmux send-keys -t nav_layout:0.1 "sleep 5 && ros2 launch gz_drone_bringup tf_tree_init_launch.py" C-m  # Launch tf tree
tmux send-keys -t nav_layout:0.2 "MicroXRCEAgent udp4 -p 8888" C-m  # Start the micro XRCE-DDS agent
tmux send-keys -t nav_layout:0.3 "sleep 7 && rviz2 -d /root/ros2_ws/src/gz_drone_bringup/launch/rviz_nav.rviz" C-m  # Launch rviz
tmux send-keys -t nav_layout:0.4 "sleep 10 && ros2 run ros_gz_bridge parameter_bridge /camera@sensor_msgs/msg/Image@gz.msgs.Image" C-m  # Launch nav2

tmux attach -t nav_layout 
