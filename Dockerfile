FROM ros:foxy-ros-base

# Install deps
RUN apt update && apt install -y \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-pip \
    python3-tornado \
    python3-twisted \
    python3-autobahn \
    python3-pil\
    python3-bson\
    ros-foxy-test-msgs \
    ros-foxy-pybind11-vendor \
    && rm -rf /var/lib/apt/lists/*

# RUN apt-get install ros-foxy-ros2bag \
#     ros-foxy-rosbag2-converter-default-plugins \
#     ros-foxy-rosbag2-storage-default-plugins

# RUN apt-get install ros-foxy-test-msgs
# RUN add-apt-repository universe && \
#     apt-get update

RUN pip install pymongo

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