FROM python:3.10.6-alpine3.16@sha256:db0f3888d0ef4293a6387462b87a75bcdd0c4bc4cfc798ec617a5923be780cf6
RUN apk add --no-cache ca-certificates openssh-client sshpass
RUN adduser -D ansible 
RUN chown -R ansible:ansible /home/ansible
USER ansible
ENV PATH="/home/ansible/.local/bin:${PATH}"
# renovate: datasource=pypi depName=ansible-core versioning=pep440
ARG ANSIBLE_CORE_VERSION=2.13.2
RUN python3 -m pip install --user ansible-core==${ANSIBLE_CORE_VERSION}
COPY . ./
COPY roles/ansible/files/image/alpine_ansible/inventory /etc/ansible/hosts
