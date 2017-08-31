#!/usr/bin/env bash

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory ansible/all.yml
