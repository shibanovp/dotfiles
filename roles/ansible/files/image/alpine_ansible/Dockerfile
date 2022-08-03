FROM python:3.10.6-alpine3.16@sha256:baac1e99d64d1af62f8e30a137352a85b9e6ba6c86aba8a245657e182b2c971c
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
