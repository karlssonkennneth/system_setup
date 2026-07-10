# My Configuration

This repository contains my configuration files that I want to share between my
machines.

I am staring with GNU Stow, the long term plan is to switch to Home Manager at
some point

Start with installing everything in the Brewfile

## Brew
After stowing the Brew folder

```console
brew bundle install
```
Looks for ~/Brewfile and installs its contents

## GNU Stow 
Create folders for the different configurations that you want and run:

```console
$ stow "folder"
```
For instance if you want to add the configuration for .zshrc:

```console
$ stow zsh
```

## Zsh
Install oh-my-zsh
https://ohmyz.sh/#install

```console
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### powerlevel10k
```console
brew install powerlevel10k
echo "source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
```

## Yazi
Install theme for Yazi
```console
ya pack -a BennyOe/tokyo-night
```

## Doom Emacs
Install Emacs and Doom:

```console
brew install --cask emacs
git clone https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

Stow the config, then sync:

```console
stow doom
~/.config/emacs/bin/doom sync
```

Install the font:

```console
brew install --cask font-jetbrains-mono-nerd-font
```

## mbsync
mbsync (isync) syncs email from IMAP servers to a local maildir on disk. Doom Emacs reads email through mu4e, which needs mail stored locally — mbsync is what keeps it in sync.

Install:

```console
brew install mu isync
```

Stow the config:

```console
stow mbsync
```

**Note:** `~/.mbsyncrc` contains no passwords — credentials are stored in `~/.authinfo.gpg` (see GPG section below).

After stowing, create the mail directory and run the initial sync:

```console
mkdir -p ~/Mail/proton
mbsync proton
mu init --maildir=~/Mail --my-address=yourname@protonmail.com
mu index
```

### Proton Mail Bridge
mbsync for ProtonMail requires Proton Bridge running in the background:

```console
brew install --cask proton-mail-bridge
```

Open it, log in, and set it to launch at login. It exposes local IMAP (port 1143) and SMTP (port 1025) that mbsync connects to.

## GPG
GPG is used to encrypt `~/.authinfo.gpg`, which stores email credentials (Proton Bridge password etc.) so they never sit in plain text.

### Setting up GPG on a new machine

1. **Export your key from the old machine:**

```console
gpg --export-secret-keys --armor kennethkarlsson81@protonmail.com > gpg-private-key.asc
```

2. **Copy `gpg-private-key.asc` to the new machine** (USB, encrypted cloud, etc. — treat it like a password).

3. **Import on the new machine:**

```console
gpg --import gpg-private-key.asc
```

4. **Trust the key:**

```console
gpg --edit-key kennethkarlsson81@protonmail.com
# At the prompt type:
trust
5
quit
```

5. **Delete the exported file:**

```console
rm gpg-private-key.asc
```

6. **Copy `~/.authinfo.gpg`** from your backup to `~/.authinfo.gpg` on the new machine — it is safe to copy since it is encrypted.

### Recreating ~/.authinfo.gpg from scratch
If you don't have a backup of `~/.authinfo.gpg`, recreate it from Bitwarden:

```console
nano ~/.authinfo
# Add credentials, then encrypt:
gpg --encrypt --recipient kennethkarlsson81@protonmail.com ~/.authinfo
rm ~/.authinfo
```

Credentials to add (get passwords from Bitwarden):
- **Proton Bridge password** — item: `Proton Mail Bridge`

## Python
