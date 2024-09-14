# Use the latest Ubuntu base image
FROM ubuntu:latest

# Set the environment variable for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Set the project name and repository URL
ENV PROJECT_NAME=ApolloOS
ENV GIT_REPO=https://github.com/maazster72/ApolloOS.git 

# Update the package list and install the required packages
RUN apt-get update && \
    apt-get install -y \
    micro \
    make \
    nasm \
    qemu \
    git \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the repository into a specified directory
RUN git clone $GIT_REPO /$PROJECT_NAME

# Set the working directory
WORKDIR /$PROJECT_NAME

# Set the default command to run when starting the container
CMD ["bash"]

