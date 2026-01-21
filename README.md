# GH360 Replay Environment
A docker container that can replay rosbags recorded on the GH360 and exposes the data to websockets on port 9090.

# Setup Process
* Install [Docker Desktop] (https://docs.docker.com/desktop/). Alternatively if you are using Linux you can only instal [Docker Engine](https://docs.docker.com/engine/install) as well.
* Clone this repository, and in a terminal window navigate to it using the `cd PATH` command. **Note:** `PATH` has to be replaced with an actual path, e.g. `cd C:\Users\max\Desktop\gh360_replay_environment`.
* Build the docker image:

# Usage Instructions
* Run the docker container: `docker run -it --rm --name gh360_replay_container -p 9090:9090  gh360/replay_environment`
  **Note:** This will automatically also start the websocket server that forwards all ROS messages to port 9090.
* Opening a terminal window in the docker container: `docker exec -it gh360_replay_container bash`
* Replaying a rosbag: 
  1. Open a new terminal window
  2. Open an interactive bash shell inside the container: `docker exec -it gh360_replay_container bash`
  3. Source the ROS2 workspace: `source install/setup.bash`
  4. Play a rosbag: `ros2 bag play rosbags/BAGNAME`
    **Note:** `BAGNAME` has to be replaced by the name of a rosbag, e.g. `ros2 bag play rosbags/final_eval_rosbag_1757431284`
* A simple example website that reads the joint angles and a motor position published by the rosbag can be viewed by opening joint_angle_sub.html in a browser on your host machine.
