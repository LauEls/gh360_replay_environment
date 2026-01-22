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


RUN pip install pymongo

# Set workspace
WORKDIR /root/ros2_ws
COPY src/ src/
COPY rosbags/ rosbags/
COPY start_websocket_server.sh start_websocket_server.sh

# Build your code
RUN . /opt/ros/foxy/setup.sh && \
    rosdep update && rosdep install --from-paths src --ignore-src -r -y && \
    colcon build

# Default launch command
ENTRYPOINT ["/bin/bash"]

CMD ["./start_websocket_server.sh"]


