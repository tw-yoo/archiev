# Use an ARM-compatible base image
FROM --platform=linux/arm64 ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    xz-utils \
    clang \
    libglu1-mesa \
    curl

# Create a non-root user and switch to it
RUN useradd -m dockeruser
USER dockeruser
WORKDIR /home/dockeruser

# Download and install Flutter (use the appropriate version for your needs)
RUN curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.10.3-stable.tar.xz \
    && tar -xf flutter_linux_2.10.3-stable.tar.xz \
    && rm flutter_linux_2.10.3-stable.tar.xz

# Add Flutter to the path
ENV PATH="/home/dockeruser/flutter/bin:${PATH}"

# Add Flutter to the path
ENV PATH="/flutter/bin:${PATH}"

# Install Dart
RUN flutter --version
RUN flutter --debug --no-version-check precache

# Disable analytics and upgrade Flutter
RUN flutter config --no-analytics
RUN flutter upgrade

# Install additional dependencies
RUN flutter doctor --android-licenses
RUN flutter doctor --web

# Disable Dart SDK preview
RUN flutter doctor --no-dart-sdk-preview

# Set the working directory
WORKDIR /app

# Copy the Flutter project files to the container
COPY . .

# Run your Flutter commands
CMD ["flutter", "run"]
