#!/bin/bash -ex
# common/ubuntu/remove-banner.sh

sed -i 's/^\(session    optional     pam_motd.so.*\)/#\1/g' /etc/pam.d/sshd
sed -i 's/^\(session    optional     pam_mail.so.*\)/#\1/g' /etc/pam.d/sshd