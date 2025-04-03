#!/bin/bash

tmux new-session -s flamingo_layout -d
tmux split-window -h -t flamingo_layout 
tmux split-window -v -t flamingo_layout
tmux split-window -v -t flamingo_layout:0.0 
tmux split-window -v -t flamingo_layout:0.1
tmux split-window -v -t flamingo_layout:0.4
tmux send-keys -t flamingo_layout:0.3 "ros2 launch flamingo_ros2_bringup cable_world_headless.launch.py" C-m  # Open gz garden world
tmux send-keys -t flamingo_layout:0.0 'sleep 5 && cd ../PX4-Autopilot-PRISMA && HEADLESS=1 PX4_SYS_AUTOSTART=4007 PX4_GZ_MODEL=x500_flamingo PX4_GZ_MODEL_POSE="0 0 0.5 0 0 3.14" ./build/px4_sitl_default/bin/px4' C-m  # Spawn x500 depth
tmux send-keys -t flamingo_layout:0.5 "sleep 12 && rviz2 -d /root/ros2_ws/src/gz_drone_bringup/launch/rviz_flamingo.rviz" C-m  # Spawn x500 depth
tmux send-keys -t flamingo_layout:0.2 "sleep 12 && ros2 run trajectory_planner offboard_control" C-m #Offboard trajectory planner run
tmux send-keys -t flamingo_layout:0.4 "sleep 12 && ros2 launch gz_drone_bringup tf_tree_init_flamingo.launch.py" C-m  # Launch tf tree
tmux send-keys -t flamingo_layout:0.1 "sleep 5 && MicroXRCEAgent udp4 -p 8888" C-m  # Start the micro XRCE-DDS agent

tmux attach -t flamingo_layout 
