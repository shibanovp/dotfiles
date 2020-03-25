#!/bin/sh -x
pip install --user ansible
ansible-playbook -e ansible_python_interpreter=$(which python3) install.yml