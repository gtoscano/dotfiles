# Dockerfile
# Created by Gregorio Toscano
# This Dockerfile creates a Debian-based image with a non-root user
# Build it: docker build -t gregoriotoscano/dotfiles:latest .
# Push it to dockerhub: docker push gregoriotoscano/dotfiles:latest (after docker login)
# Run it from dockerhub: docker run -it --rm gregoriotoscano/dotfiles:latest

FROM debian:bookworm-slim

# 1. Update package list and install sudo
RUN apt-get update && apt-get install -y sudo wget curl \
    && rm -rf /var/lib/apt/lists/*

# 2. Create a non-root user 'gtoscano' and add to 'sudo' group
RUN useradd -m -s /bin/bash -G sudo gtoscano

# 3. Grant passwordless sudo privileges to 'gtoscano'
RUN echo 'gtoscano ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# (Optional) Switch to the new user by default
USER gtoscano

# cd to the home directory
WORKDIR /home/gtoscano

# The container will now run as the 'gtoscano' user with sudo privileges.
CMD ["/bin/bash"]
