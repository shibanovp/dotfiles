FROM ubuntu:jammy@sha256:2b7412e6465c3c7fc5bb21d3e6f1917c167358449fecac8176c6e496e5c1f05f
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
