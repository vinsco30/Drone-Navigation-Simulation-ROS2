# Drone-Navigation-Simulation-ROS2
Docker configuration for autonomous navigation in GPS-denied environment with PX4 Autopilot.

## Details

- **Auto-deletion:** After its execution, the Docker container is automatically deleted. This helps in maintaining a clean environment by freeing up resources on the host machine.

- **`ros2_ws-src` folder:** This folder should contain the source code for the ROS2 workspace. The Docker container comes pre-loaded with `px4-ros-com` and `px4-msgs`, which are dependencies for the PX4-ROS2 communication. In this workspace there is the `leonardo_field_description` package which contains the world simulation.

- **PX4 Firmware:** The PX4 Firmware is not included in the Docker container. Instead, its folder is shared with the container using a Docker volume. This allows the firmware to be updated without having to rebuild the Docker container.


### Installing

A step by step series of examples that tell you how to get a development environment running:

1. Clone the repository to your local machine.
3. Clone the PX4 Firmware with `git clone --single-branch -b release/1.14 git@github.com:vinsco30/PX4-Autopilot-PRISMA.git --recursive`
4. Build the docker imagege with `cd docker && docker build -t px4-ros2-gz -f px4_gz_sim_dockerfile.txt .`
5. Run the container with `./run_cnt.sh`.

### Running

If you want to run the simulation in the Contest world, you have to start the simulation with:

    ros2 launch leonardo_field_description launch_leonardo_race_field.py 

Then to spawn the x500 drone with depth camera you can run

    PX4_SYS_AUTOSTART=4002 PX4_GZ_MODEL=x500_depth PX4_GZ_MODEL_POSE="-9.5 -3.5 0.5" ./PX4-Autopilot-PRISMA/build/px4_sitl_default/bin/px4 

### Alternative Running (developing Navigation)

![Simulation setup with TMUX](/docker/simulation_complete.png)

During the development of the aerial navigation stack several simulations need to be runned, to simplify this you can use tmux.

First, clone into `ros2_ws/src/pkg` the package for the bringup of the TF tree for PX4 simulation [drone-bringup ](https://github.com/vinsco30/drone-bringup), with the command

    git clone https://github.com/vinsco30/drone-bringup.git

Then you can compile and source the workspace and run the simulation with

    ./start.sh

which will start a tmux session with 4 screen opening gz, rviz2 and running the tf tree and the Micro XRCE-DDS agent.

To stop the session you should kill the gz simulator and then type `ctrl+b :kill-server`.

