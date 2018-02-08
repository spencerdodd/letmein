#!/usr/bin/env bash

# install openssh server if not installed
echo "[*] installing newest version of openssh-server"
sudo apt-get --force-yes --yes install openssh-server
echo "[+] complete"

# my 4096-bit ssh pubkey
macbook="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC/wDmMzRBwyxFmU8dTCHTF3s4elnThXELbbeo9XYDRSq73h4TL1fORottKvFQQgj+kpwnLopXN3U0/zSKncNrMJGvk5VvxgSUdyIfqyjCfISoh1AMk6UJOklENTIS7X/PyNX5gTnIpd/VAm5UQ/BvTVh5VaS0+Rc6I4AnuXm9gKLTlwtRpHrTJXlILznOPUaiz1uH2VSapY71ipPXyIHBcMi2u4qVKISOu3OG+t0L2UpUKpzsu27TtdussLGs1zWxW2TIAB1HBkSgfoOhTEiEzzB0K8DTVd2jHT9wv+pPBDiti2LH3pire5vQlrgNFVaMMC0cJiSJmYWK5VaEUr9bVT+2QGQpi+Wkg49xEOj99AQ+99BL/J0scFh8LGPOGxOZajUkjUbzypNxNkRBBuj/5al5ZV4KYtyURi/GbWdEc4usfsyOXJSyZv818wfshNl5u6UmcsPNpJQtTMtwXF+yGVL0BocpXH2HQYz+i8fFbe/NnwC1TuxhYmhviVZL22c79KvIyBgNheQ6Xhi+1MzMgMNQpYwMjZ9UpvvgLxjOjcgYUTe6mgFG5mK5wGz/INGZPkTRwvo3RsykLsWl52eu+U1IAPlVeaLfBXqZstwuydd36Z4/HJqmLtoo1v4g9h30UeClGt7wkng4zh1x+fVi2QdeF1QZUE/y73lj3AdUrSw== sd"

# copy key to authorized_keys file
echo "[*] copying coastal's ssh pubkey to ~/.ssh/authorized_keys"
sudo echo $macbook >> ~/.ssh/authorized_keys
echo "[+] complete"

# open port 22
echo "[*] enabling ssh server on port 31337 with pubkey authentication,"
echo "	no password login, no root login, and 3 login attempts"
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -e 's/#Port 22/Port 31337/' /etc/ssh/sshd_config > /tmp/ssh_tmp; sudo mv /tmp/ssh_tmp /etc/ssh/sshd_config

# enable pubkey auth
sudo sed -e 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config > /tmp/ssh_tmp; sudo mv /tmp/ssh_tmp /etc/ssh/sshd_config
echo "[+] complete"

# disable password login
sudo sed -e 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config > /tmp/ssh_tmp; sudo mv /tmp/ssh_tmp /etc/ssh/sshd_config
echo "[+] complete"

# disable root login
sudo sed -e 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config > /tmp/ssh_tmp; sudo mv /tmp/ssh_tmp /etc/ssh/sshd_config
echo "[+] complete"

# lock out after 3 tries
sudo sed -e 's/#MaxAuthTries 6/MaxAuthTries 3/' /etc/ssh/sshd_config > /tmp/ssh_tmp; sudo mv /tmp/ssh_tmp /etc/ssh/sshd_config
echo "[+] complete"

# restart ssh
echo "[*] restarting ssh to enable changes"
sudo service ssh restart
echo "[+] complete"

echo "[+] openssh-server configured for coastal access"
