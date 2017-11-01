#!/usr/bin/env bash

# install openssh server if not installed
sudo apt-get --force-yes --yes install openssh-server

# my 4096-bit ssh pubkey
ssh_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCcQmcqDoQji+0NYe24CY1CeppIeqd9w0WIx3DSUe/CPtkl/ihtIH7L1ePxhroxixtcddfD0Hn6sD6DKJiirPE2PT3R7aUvpLAnYS4ToAE7W8uM19ISyrzLUUudeJAqwYApr8wYdr2/Uk8S+0OphFXfxr2qEmSXB8iO4pynFlVf7o5iC0dVHSK/cQ1K9TxXzXWKUY9b6fuUm/ARzprrJVtf6xFpaap37KgfFbnNlRQoQw9YtSe1ORbtOeU/++1VMUjr5ShhU4pLLE3VuJsX5v4jKRp9L86OlgopjKBMdqFEaDXqw0FrKNw88NptuFffqLv8Z6c1gtVch2Fmi+9DnuruJd/alKO/rgjflWF7Mt2DHSPTvVCX7fVEQ8rbtDoQ1VaEroDV7nyFUAy2md238pmP4fcsHb1xRdzd4sC9DPFj+ln2M3E++Jqsi/ByScpU6S7FTB5rsmnfN/9+AzSt6sSVotueHLsfZOzIakkXNt5HSSYVbol9sGFL4zUDTR1s3pykStQjdsVIDibg4oFdA90t/9YZHEY8yY9zDSjXWOzCRmLYpAc35BAFPc996+HQVtZJcZKdzO79DaD37vZlI6tOGM2YQzyVDg82idX98w2xZs8j+hXBo98BhdTb1IEsX03uhszSzxgYgxogUiOKzVOdETAapoWAXQE56RgQSlvN9w== coastal@mbp"

# copy key to authorized_keys file
sudo echo $ssh_key > ~/.ssh/authorized_keys

# open port 22
sudo sed -i .bak 's/#Port/Port/' /etc/ssh/sshd_config

# enable pubkey auth
sudo sed -i .bak 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config

# restart ssh
sudo service ssh restart