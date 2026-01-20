FROM ros:foxy-ros-base

# Install deps
RUN apt update && apt install -y \
    python3-colcon-common-extensions \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get install ros-foxy-ros2bag \
    ros-foxy-rosbag2-converter-default-plugins \
    ros-foxy-rosbag2-storage-default-plugins

# Set workspace
WORKDIR /ros2_ws
COPY src/ /ros2_ws/src/
COPY rosbags/ /ros2_ws/rosbags/

# Build your code
RUN . /opt/ros/foxy/setup.sh && \
    rosdep update && rosdep install --from-paths src --ignore-src -r -y && \
    colcon build

# Default launch command
ENTRYPOINT ["/bin/bash"]