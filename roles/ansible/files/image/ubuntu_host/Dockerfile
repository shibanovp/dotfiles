FROM ubuntu:jammy@sha256:0a9887931b0e38af2e3487ed39e29436b0535c4f3f52e57745baaf79d1898956
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
