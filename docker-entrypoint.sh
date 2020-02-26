#!/bin/bash

SSHPORT="${SSHPORT:-22}"
SSHPASSWORD="${SSHPASSWORD:-root}"

# set sshd config: allow password login, use custom port
#     and allow listen on all interfaces when reverse tunneling
sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config
sed -i s/#Port.*/Port\ $SSHPORT/ /etc/ssh/sshd_config
sed -i s/GatewayPorts.*/GatewayPorts\ yes/ /etc/ssh/sshd_config
sed -i s/AllowTcpForwarding.*/AllowTcpForwarding\ yes/ /etc/ssh/sshd_config

# add root password
echo "root:$SSHPASSWORD" | chpasswd

# generate host keys if not present
ssh-keygen -A

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"