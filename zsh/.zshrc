# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# To fix breaking on zsh after every Macos update
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; 
then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH:$HOME/.config/emacs/bin:$HOME/bin
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set language to English
export LC_ALL=en_US.UTF-8

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
zsh-autosuggestions
git
web-search
sudo
last-working-dir
extract
dirhistory
z
macos
history
fzf
)

source $ZSH/oh-my-zsh.sh

# Needed for fzf R search + plus plugin above
export FZF_BASE="/opt/homebrew/opt/fzf"
# vi mode
bindkey -v
export KEYTIMEOUT=1

# bind the '§' to the sudo plugin, it is not compatible with vi-mode 
bindkey -M vicmd '§' sudo-command-line
bindkey -M viins '§' sudo-command-line
#bindkey "^R" history-incremental-search-backward
#bindkey '^r' fzf-history-widget
#alias zshconfig="code ~/.zshrc"
#alias mc="mc --nosubshell"

# Used for pipenv
export PIPENV_VENV_IN_PROJECT=1

# Alias for setting up Python environment
alias vp311="source ~/repos/dev/bin/activate"
alias dev311="source ~/repos/dev/bin/activate"
alias vp38="source ~/repos/py_38_dev_env/dev_env/bin/activate"
alias dev38="source ~/repos/py_38_dev_env/dev_env/bin/activate"
alias startenv="pipenv shell"

# Alias for programs replacing standard programs
alias vim="nvim"
alias cat="bat"
alias fd="fd -u"
alias rg="rg -u"
alias l="eza -al --icons"
alias ls="eza -al --icons"
alias ll="eza -al --icons"


# Alias for edit files
alias ezsh="nvim ~/.zshrc"
alias editzsh="nvim ~/.zshrc"
alias elazy="nvim ~/.config/nvim"
alias fvim="vim \$(find ~/repos/icup_lightweight_S/vendor/volvocars/tools/docker_build ~/repos/icup_lightweight_S/vendor/volvocars/tools/docker_image ~/repos/icup_lightweight_S/vendor/volvocars/tools/ci/ -type f | fzf)"
alias fcode="code \$(find ~/repos/icup_lightweight_S/vendor/volvocars/tools/docker_build /Users/KKARLS28/repos/spa2_lightweight/tools ~/repos/icup_lightweight_S/vendor/volvocars/tools/docker_image ~/repos/icup_lightweight_S/vendor/volvocars/tools/ci/ -type f | fzf)"
alias update="source ~/.zshrc"
alias reload="source ~/.zshrc"
alias configure="source ~/.zshrc"

# Navigate to folders
alias v38="cd ~/repos/py_38_dev_env/dev_env"
alias v311="cd ~/repos/dev"
alias repos="cd ~/repos"
alias ci="cd ~/repos/icup_lightweight_S/vendor/volvocars/tools/ci"
alias test="cd ~/repos/icup_lightweight_S/vendor/volvocars/test"
alias test_manager="cd ~/repos/icup_lightweight_S/vendor/volvocars/tools/ci/lib/core/test_manager"
alias artinfci="cd ~/repos/icup_lightweight_S/vendor/volvocars/tools/ci/lib/core/artinfci"
alias artinfci_infra="cd ~/repos/icup_lightweight_S/vendor/volvocars/tools/ci/lib/core/artinfci_infra"
alias tools="cd ~/repos/icup_lightweight_S/vendor/volvocars/tools"
alias lib="cd ~/repos/icup_lightweight_S/vendor/volvocars/tools/ci/lib"
alias services="cd ~/repos/icup_lightweight_S/vendor/volvocars/tools/services"
alias volvo="cd ~/repos/icup_lightweight_S/vendor/volvocars"
alias aosp="cd ~/repos/icup_lightweight_S/"
alias dhu="cd ~/repos/spa2_lightweight"
alias spa2="cd ~/repos/spa2_lightweight"
alias hardware="~/repos/icup_lightweight_S/vendor/volvocars/hardware"
alias jenkins="~/repos/icup_lightweight_S/vendor/volvocars/tools/ci/jenkins"
alias docker_build="~/repos/icup_lightweight_S/vendor/volvocars/tools/docker_build"
alias docker_image="~/repos/icup_lightweight_S/vendor/volvocars/tools/docker_image"
alias sharedlibs="~/repos/icup_lightweight_S/jenkins_shared_libs"
alias commit_eval="~/repos/icup_lightweight_S/vendor/volvocars/tools/ci/lib/core/artinfci/commit_evaluator"
alias cidocker="~/repos/icup_lightweight_S/vendor/volvocars/tools/docker_image/run.sh --multiuser"
alias analyze="(cd ~/repos/icup_lightweight_S/vendor/volvocars/tools/ci/lib && ~/repos/icup_lightweight/vendor/volvocars/tools/ci/jenkins/ci_docker_run.sh ./analyze.sh) "

# Alias for running programs
alias commitcheck="~/repos/icup_lightweight_S/vendor/volvocars/tools/commit-check/bin/commit-check"

# Alias for convenience
alias copylast="tail -n 1 | xclip -selection clipboard"
#alias emacs="emacsclient -c"
#alias fvim="(cd ~/repos/icup_lightweight/vendor/volvocars/tools/ci/ && vim $(fzf))"  
#alias pycharm="(cd /home/kkarls28/pycharm-community-2022.2.1/bin && /home/kkarls28/repos/r_aosp/vendor/volvocars/tools/ci/jenkins/ci_docker_run.sh --multiuser ./pycharm.sh) "
#alias unit_test="(cd /home/kkarls28/repos/r_aosp/vendor/volvocars/tools/ci/shipit && /home/kkarls28/repos/r_aosp/vendor/volvocars/tools/ci/jenkins/ci_docker_run.sh pytest -n 8 -vs --ignore=test_manager/runners) "
#alias test="(cd /home/kkarls28/repos/r_aosp/vendor/volvocars/tools/ci/shipit && /home/kkarls28/repos/r_aosp/vendor/volvocars/tools/ci/jenkins/ci_docker_run.sh pytest -n 8 -vs --ignore=test_manager/runners) && (cd /home/kkarls28/repos/r_aosp/vendor/volvocars/tools/ci/shipit && /home/kkarls28/repos/r_aosp/vendor/volvocars/tools/ci/jenkins/ci_docker_run.sh ./analyze.sh)"
#alias cipycharm="(cd /home/kkarls28/pycharm-community-2022.2.1/bin && /home/kkarls28/repos/r_aosp/vendor/volvocars/tools/ci/jenkins/ci_docker_run.sh --multiuser ./pycharm.sh)"
#alias pycharm="(cd /home/kkarls28/pycharm-community-2022.2.1/bin && ./pycharm.sh)"

# Fix slow terminal
DISABLE_UNTRACKED_FILES_DIRTY="true"
# neofetch # Add system info when starting terminal
source /Users/KKARLS28/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# Created by `pipx` on 2023-09-04 07:30:04
export PATH="$PATH:/Users/KKARLS28/.local/bin"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
