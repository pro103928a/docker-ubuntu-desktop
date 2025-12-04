FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV USER=render
ENV HOME=/home/render

RUN apt update -y && apt install --no-install-recommends -y \
    xfce4 \
    xfce4-goodies \
    tigervnc-standalone-server \
    novnc \
    websockify \
    sudo \
    xterm \
    init \
    vim \
    net-tools \
    curl \
    wget \
    git \
    tzdata \
    dbus-x11 \
    x11-utils \
    x11-xserver-utils \
    x11-apps \
    software-properties-common \
    python3 \
    python3-numpy \
    && apt clean && rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:mozillateam/ppa -y && \
    echo 'Package: *' >> /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Pin: release o=LP-PPA-mozillateam' >> /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Pin-Priority: 1001' >> /etc/apt/preferences.d/mozilla-firefox && \
    apt update -y && apt install -y firefox && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN apt update -y && apt install -y xubuntu-icon-theme && \
    apt clean && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash render && \
    echo "render ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY start.sh /start.sh
RUN chmod +x /start.sh

USER render
WORKDIR /home/render

EXPOSE 6080

CMD ["/start.sh"]
