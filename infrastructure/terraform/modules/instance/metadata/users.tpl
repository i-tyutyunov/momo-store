#cloud-config
groups:
  - ansible
users:
- name: ${instance_user_name}
  primary_group: ${instance_user_name}
  shell: /bin/bash
  sudo: 'ALL=(ALL) NOPASSWD:ALL'
  ssh-authorized-keys:
    - ${ssh_public_key}