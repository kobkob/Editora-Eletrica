# Editora-Eletrica
Electric Books for everyone

[![Build Status](https://api.travis-ci.com/kobkob/Editora-Eletrica.svg?branch=master)](https://travis-ci.com/kobkob/Editora-Eletrica)



It reads a GitHub repo tree and creates a book on the fly. Each directory must have a __README.md__ file to be parsed as a __Chapter__. 

# INSTALL
You must have perl5 and the modules:

- mojolicious
- Pithub;
- Encode;
- MIME::Base64;
- Text::MultiMarkdown

Run the commands bellow:

```
gitclone https://github.com/kobkob/Editora-Eletrica.git
cd Editora-Eletrica
hypnotoad ./editora_eletrica.pl
```

# SETUP
Edit the file editora_eletrica.conf and write the user and repo to match your GitHub address.
