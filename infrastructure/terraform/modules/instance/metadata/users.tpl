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
    - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjzCPLgArwq6oIl2t3hYZ5ijqoK5suRwOawzlQmmdgZHMfRkOJQQtLKuIuCjgwQkjC2w2PoLJhcar/azo2W/I+xwzU1U9Gs8gBNsky3FDmLJT8PIfkQI0EeAyYxdglnODUV9BxatUo0yL0xtHE/3T4lFVC6cKzsQ0lGOq8o8Io4YJAxAW/A19qPEsL6yOiw0qk+14WzeCWWp67P0o8XXjooRwcoV+wTj7k9Gvy/tIjlFG/k2Dgm6Rq6tQscv8aon9LLboXDl/B7x6fPXi3k3W8ZpWbpu2xoDmWHh9+amx3l9dCKnbhMa/hR6GA0fL8zbSBeF+2nmjjwXtI455PnO65/2IcrQwI0JT+6K7WmFuKqCPPr3nVQCSyGfZYDm5+JH30RY4H5feOZA5aZgusf8YOPycHgnBFEvREXWsoX4uShsa+/ZS4xVIYB2zICHg50vDQ5Xbj1c8+Xy08nt6ZHBAVIq4Aq52OkFYxOU4F8SYW+phUNaQ3KN306QYCHQQ99IU= tyutyunov@fv4i4733opgfs3dltqlg