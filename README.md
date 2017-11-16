# letmein

script to set up newly spun up virtualbox guest OSs so I can ssh into them. It performs the following:

* installs openssh-server

* copies my pub key to `~/.ssh/authorized_keys`

* enables ssh server on port 22 with pub key auth

* installs `rsub` to allow for file editing natively in sublime text on my host computer

* restarts ssh to enable the changes

Tested on Ubuntu 17.10 Server

### usage:

```
git clone https://github.com/spencerdodd/letmein
cd letmein
./letmein.sh
```
