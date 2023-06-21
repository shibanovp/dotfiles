FROM ubuntu:jammy@sha256:83f0c2a8d6f266d687d55b5cb1cb2201148eb7ac449e4202d9646b9083f1cee0
RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
    ca-certificates openssh-server sudo python3 \
    && rm -rf /var/lib/apt/lists/*
RUN groupadd -g 1000 ubuntu
RUN useradd -rm -d /home/ubuntu -s /bin/bash -g ubuntu -G sudo -u 1000 ubuntu
ARG PASSWORD=ubuntu
RUN echo "ubuntu:${PASSWORD}" | chpasswd
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mkdir -p /home/ubuntu/.ssh
RUN chown ubuntu:ubuntu /home/ubuntu/.ssh
RUN chmod 700 /home/ubuntu/.ssh
RUN mkdir /var/run/sshd
ENV PORT=22
EXPOSE $PORT

CMD ["sh", "-c", "exec /usr/sbin/sshd -D -p $PORT"]
