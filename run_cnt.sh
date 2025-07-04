
# docker exec -itu 0 px4-ros2 bash  // run root

# enable access to xhost from the container
xhost +


# Run docker and open bash shell 
docker run --rm -it --privileged \
-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
-v "/dev:/dev" \
-v $(pwd)/PX4-Autopilot-PRISMA:/root/PX4-Autopilot-PRISMA:rw \
-v $(pwd)/PX4-Autopilot:/root/PX4-Autopilot:rw \
-v $(pwd)/ros2_ws-src/pkg:/root/ros2_ws/src:rw \
-v $(pwd)/start:/root/start:rw \
-v $(pwd)/planner_4_octo:/root/planner_4_octo:rw \
--env="DISPLAY=$DISPLAY" \
--network host \
--name=px4-ros2-gz px4-ros2-gz bash


