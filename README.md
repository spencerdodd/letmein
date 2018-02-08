# letmein

script to perform automation of spinning up a hardened ssh server that
I can access. Performs the following hardening methods:

* enables public-key authentication

* disables password authentication

* disables root login

* set MaxAuthTries to 3

* sets port to 31337

* *(optional)* enables 2-factor authentication through Google Authenticator

### usage:

```
git clone https://github.com/spencerdodd/letmein
cd letmein
./letmein.sh
```

If you want me to have 