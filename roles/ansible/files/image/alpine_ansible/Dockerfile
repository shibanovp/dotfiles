FROM python:3.10.7-alpine3.16@sha256:6015c8fd6d6c1acf529f8165c51e35172a2a8aa1a8fa72d7d2e0e3ce1700739a
RUN apk add --no-cache ca-certificates openssh-client sshpass
RUN adduser -D ansible 
RUN chown -R ansible:ansible /home/ansible
USER ansible
ENV PATH="/home/ansible/.local/bin:${PATH}"
# renovate: datasource=pypi depName=ansible-core versioning=pep440
ARG ANSIBLE_CORE_VERSION=2.14.1
RUN python3 -m pip install --user ansible-core==${ANSIBLE_CORE_VERSION}
COPY . ./
COPY roles/ansible/files/image/alpine_ansible/inventory /etc/ansible/hosts
