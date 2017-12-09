#!/usr/bin/env bash

# install openssh server if not installed
echo "[*] installing newest version of openssh-server"
sudo apt-get --force-yes --yes install openssh-server
echo "[+] complete"

# my 4096-bit ssh pubkey
macbook="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCcQmcqDoQji+0NYe24CY1CeppIeqd9w0WIx3DSUe/CPtkl/ihtIH7L1ePxhroxixtcddfD0Hn6sD6DKJiirPE2PT3R7aUvpLAnYS4ToAE7W8uM19ISyrzLUUudeJAqwYApr8wYdr2/Uk8S+0OphFXfxr2qEmSXB8iO4pynFlVf7o5iC0dVHSK/cQ1K9TxXzXWKUY9b6fuUm/ARzprrJVtf6xFpaap37KgfFbnNlRQoQw9YtSe1ORbtOeU/++1VMUjr5ShhU4pLLE3VuJsX5v4jKRp9L86OlgopjKBMdqFEaDXqw0FrKNw88NptuFffqLv8Z6c1gtVch2Fmi+9DnuruJd/alKO/rgjflWF7Mt2DHSPTvVCX7fVEQ8rbtDoQ1VaEroDV7nyFUAy2md238pmP4fcsHb1xRdzd4sC9DPFj+ln2M3E++Jqsi/ByScpU6S7FTB5rsmnfN/9+AzSt6sSVotueHLsfZOzIakkXNt5HSSYVbol9sGFL4zUDTR1s3pykStQjdsVIDibg4oFdA90t/9YZHEY8yY9zDSjXWOzCRmLYpAc35BAFPc996+HQVtZJcZKdzO79DaD37vZlI6tOGM2YQzyVDg82idX98w2xZs8j+hXBo98BhdTb1IEsX03uhszSzxgYgxogUiOKzVOdETAapoWAXQE56RgQSlvN9w== sd"
blackbox="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCs2TQwIpO6wh9zv80prW0GXCdrvHZTs5hGFTNiLJYH5QQ/cEvPFcqgl9BDDauPmcP/hKD8gI6vIi07H3xprUr5l6sCky46Y8h8FJaedqECtstRSpIR221YqJpP9e36FJENbX44wl8lftJmT8chf9g+J3Y2lYObkD8zcL6me9bR7BlUAhEhP058ZYzahytHFPxgxMAdcV0YQMgypxrr005yvEZ0UbSCeb/3J+fQpOSAeshYqrC/0Wg++YObbrr8IrVT+6OJHdXzhgczKfTrffUeg5hFmNycs+7aRh1oUufZS/QV9vNY74nFpzWlmdI2m+g2+6JA+wsfp+aU5eiACxiYP2cvnC/I9X8bBajkDd4ww7C03zy87zOzKg4m63GwvTYoaZp6AAsErNrRsqAw7uPhFTUOHvUTmHtQgQ1rU6fntcMmQnmLmgnrG+ZLgmlXnBGFnd5HaY0RgBI4LRQuoOukFCf1fj54Dz/Enz9UDxi+X7Ml4SJ78tRToiGFKJuy6nYvFUzPgFHa+jSeph8a4pXlHuFTXp7zU1pWM32cQplATRAEtZM0IHKhleel744sD6lwN9xmnPCXp5GRjg21t5nACpNc/pPaXxtPCKNyEX/63q2vuMoK5CTn+THJep8cmiVx1HNThVKwuaKd4zLLEgshhDm5mdu4vScikQZEWw/GLQ== coastal@blackbox"

# copy key to authorized_keys file
echo "[*] copying coastal's ssh pubkey to ~/.ssh/authorized_keys"
sudo echo $macbook >> ~/.ssh/authorized_keys
sudo echo $blackbox >> ~/.ssh/authorized_keys
echo "[+] complete"

# open port 22
echo "[*] enabling ssh server on port 22 with pubkey authentication"
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -e 's/#Port/Port/' /etc/ssh/sshd_config > /tmp/ssh_tmp; sudo mv /tmp/ssh_tmp /etc/ssh/sshd_config

# enable pubkey auth
sudo sed -e 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config > /tmp/ssh_tmp; sudo mv /tmp/ssh_tmp /etc/ssh/sshd_config
echo "[+] complete"

# install rsub
echo "[*] installing rsub"
sudo wget -O /usr/local/bin/rsub https://raw.github.com/aurora/rmate/master/rmate
sudo chmod +x /usr/local/bin/rsub
echo "[+] complete"

# restart ssh
echo "[*] restarting ssh to enable changes"
sudo service ssh restart
echo "[+] complete"

echo "[+] openssh-server configured for coastal access"
