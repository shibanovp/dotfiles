FROM python:3.10.5-alpine3.16@sha256:a746f64081fca7d6368935750ffcbf04d447cb0131408c60cbf1a4392981890a
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
