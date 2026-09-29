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
Install Emacs 31.1 and Doom. The `emacs-plus@31` formula currently provides
Emacs 31.1, is built from source (no bottle), and
enables native compilation unconditionally (`--with-native-compilation=aot`):

```console
stow emacs-plus                              # icon config, must precede the build
brew install d12frosted/emacs-plus/emacs-plus@31
git clone https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

`stow emacs-plus` installs `~/.config/emacs-plus/build.yml`, which selects the
`modern-doom3` icon. The formula reads it both at build time and at post-install,
so the icon can be changed later without a rebuild:

```console
brew postinstall emacs-plus@31
```

The app lives in the keg, not `/Applications`. Link it so launchers and the
`emacs` alias in `.zshrc` both find it — use the `opt` path, which survives
version bumps, then register it with Launch Services:

```console
ln -s /opt/homebrew/opt/emacs-plus@31/Emacs.app /Applications/Emacs.app
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
  -f /opt/homebrew/opt/emacs-plus@31/Emacs.app
```

Re-run the `lsregister` line after `brew upgrade emacs-plus@31`: it resolves
the symlink and records the versioned Cellar path, which the upgrade replaces.

A symlink is deliberate over `cp -r`. Spotlight will not index a symlinked
bundle (`mdfind kMDItemFSName == 'Emacs.app'` comes back empty), but Raycast
finds it, and the symlink tracks upgrades instead of going stale.

Never leave two Emacs bundles installed: both declare the `org.gnu.Emacs`
bundle id, and macOS resolves `Emacs` to whichever it likes regardless of what
is registered.

After changing Emacs versions, packages must be rebuilt for the new version:

```console
~/.config/emacs/bin/doom sync --rebuild
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

Install the ACP bridge used by `agent-shell` (needs `node` from the Brewfile).
The package itself comes from `packages.el`, but it does nothing without this:

```console
npm install -g @agentclientprotocol/claude-agent-acp
```

### Machine-local settings

Some settings differ between machines — which LLM agent `SPC o l c` starts, for
instance. Those differences are deliberately kept out of this repository, since
it is public and the details would identify the machine and its owner.

Instead, `config.el` loads an untracked `local.el` from `~/.config/doom/` if the
file exists, and silently skips it otherwise. `local.el` is gitignored, so
nothing machine-specific can be committed by accident.

Set it up on a machine that needs overrides:

```console
cd ~/.config/doom
cp local.el.example local.el
```

Then edit `local.el`. `local.el.example` is tracked and documents every
available variable, so it doubles as the reference for what can be overridden.

Machines needing no overrides — the personal one — are left alone: with no
`local.el` present, the defaults in `config.el` apply. Every variable therefore
has a working default, and `local.el` only ever changes behaviour, never
enables it.

### gptel chat

Doom's `:tools llm` module already installs gptel. The same machine-local
switch selects the default chat backend: Copilot on the work machine, Claude
on the personal machine. Use `SPC o l l` to open a chat and `SPC o l s` to send.

On the work machine, authorize Copilot when prompted (or run
`M-x gptel-gh-login`). No API key is needed. If your Copilot plan requires a
different endpoint, set `my/gptel-copilot-host` in the untracked `local.el`;
see `local.el.example` for the plan-specific hosts.

On the personal machine, gptel's Claude chat needs an Anthropic **API key**,
separate from the Claude Code subscription login used by `agent-shell`. Store
it in `~/.authinfo.gpg` as `machine api.anthropic.com login apikey password
YOUR_API_KEY` and never in the tracked Doom config.

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

## Search (fd / ripgrep)

```console
stow search
```

Installs `~/.ignore`, which prunes caches, media archives and build artifacts
from searches rooted at `~` (Doom's `SPC SPC`, `SPC /`, `SPC s p`). Takes the
home index from ~777k files to ~8.6k, and `fd` from 27s to 0.15s.

Only affects searches started from `~` — searching inside a project is
unaffected, since fd and ripgrep read ignore files from the search root down.

Note: Doom indexes with `fd -tl`, which lists symlinks but does not descend
into them. So `~/.config/doom/config.org` is not reachable by that path in
`SPC SPC`; it shows up under its real path, `system_setup/doom/.config/doom/`.
Use `SPC f p` (`doom/find-file-in-private-config`) to jump straight there.

## Python
