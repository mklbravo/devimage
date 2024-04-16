#!/bin/bash

mkdir -p /root/.ssh
ln -s /run/secrets/ssh_private_key /root/.ssh/id_rsa
