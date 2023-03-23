FROM python:3.11.2-alpine3.16@sha256:ef378cf70ea86e08b7f9a9176f1a9ab8f7524372895a226bad7d0c1d98291203
RUN apk add --no-cache ca-certificates openssh-client sshpass
RUN adduser -D ansible 
RUN chown -R ansible:ansible /home/ansible
USER ansible
ENV PATH="/home/ansible/.local/bin:${PATH}"
# renovate: datasource=pypi depName=ansible-core versioning=pep440
ARG ANSIBLE_CORE_VERSION=2.14.3
RUN python3 -m pip install --user ansible-core==${ANSIBLE_CORE_VERSION}
COPY . ./
COPY roles/ansible/files/image/alpine_ansible/inventory /etc/ansible/hosts
