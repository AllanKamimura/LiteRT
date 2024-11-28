FROM tensorflow/build:2.19-python3.11

# Enable arm64 architecture
RUN dpkg --add-architecture arm64

# Replace sources.list with the correct repositories for both amd64 and arm64
RUN rm /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu jammy main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports jammy main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu jammy-security main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb [arch=arm64] http://ports.ubuntu.com/ubuntu-ports jammy-security main restricted universe multiverse" >> /etc/apt/sources.list

# Update and install Python 3.11 for amd64
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-distutils

# Install ARM64 cross-compilation tools and Python 3.11 dev headers
RUN apt-get update && apt-get install -y \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    python3.11-dev:arm64

# Set the CROSSTOOL_PYTHON_INCLUDE_PATH environment variable for Python 3.11
ENV CROSSTOOL_PYTHON_INCLUDE_PATH=/usr/include/aarch64-linux-gnu/python3.11

# Optional: Run Bazel or other build commands here, using the exported variable

