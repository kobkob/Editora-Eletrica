# Editora-Eletrica
Electric Books for everyone

[![Build Status](https://api.travis-ci.com/kobkob/Editora-Eletrica.svg?branch=master)](https://travis-ci.com/kobkob/Editora-Eletrica)

It reads a GitHub repo tree and creates a book on the fly. Each directory must have a __README.md__ file to be parsed as a __Chapter__. 

# INSTALL
Editora Eletrica runs in a Debian box.

Install the required software as root with

```
apt install build-essential git libcrypt-ssleay-perl
```

Run the commands bellow as a regular user:

```
wget https://gist.githubusercontent.com/rfilipo/561f0d160b4ffb330942def5cf002f24/raw/fa0733010fa3a31bd7b3956a6366b17fad0b151b/editora_eletrica.sh
sh editora_eletrica.sh
cd Editora-Eletrica
hypnotoad ./editora_eletrica.pl
```

# SETUP
Edit the file editora_eletrica.conf and write the user and repo to match your GitHub address.
