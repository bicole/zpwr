export ZPWR_DEBUG=true
export ZPWR_AUTO_COMPLETE=true
export ZPWR_GITHUB_ACCOUNT='bicole'

export ZPWR_PLUGIN_MANAGER=zinit

export ZPWR_AUTO_LS_RM=false
export ZPWR_AUTO_LS_CD=false
export ZPWR_BANNER_CLEARLIST=false

export ZPWR_DEFAULT_OMZ_THEME=xiong-chiamiov-plus
export ZSH_THEME=robbyrussel
# export ZPWR_PROMPT=OMZ
export ZPWR_PROMPT=powerlevel10k
export ZPWR_PROMPT_FILE=~/.p10k.zsh

export ENABLE_CORRECTION="true"

alias vim='vim -p'
export ZPWR_VIM=vim
# export ZPWR_VIM='vim -p'
export ZPWR_EXA_COMMAND="command exa --git -l -F -H --color-scale -g -a --colour=always --icons --group-directories-first -h"

export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME="$HOME/repos"
export CHOOSEEV_ROOT_DIR="$PROJECT_HOME/chooseev"

export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

export ZSH_TMUX_UNICODE=true
export ZSH_TMUX_AUTONAME_SESSION=true
export ZSH_TMUX_AUTOCONNECT=true

export FORGIT_FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"

# Unalias cd
# which cd >/dev/null 2>&1 && unset -f cd 2>/dev/null
which goto >/dev/null 2>&1 && unalias goto 2>/dev/null
goto() {
  cd $HOME/repos/*$1* || return
}

ZPWR_GH_PLUGINS=(
    bicole/fasd
    bicole/fzf-tab
    bicole/fzf-zsh-plugin
    bicole/gh_reveal
    bicole/jhipster-oh-my-zsh-plugin
    bicole/revolver
    MenkeTechnologies/zsh-git-acp
    MenkeTechnologies/zsh-git-repo-cache
    MenkeTechnologies/zsh-nginx
    MenkeTechnologies/zsh-sed-sub
    MenkeTechnologies/zsh-sudo
    # MenkeTechnologies/zsh-travis
    MenkeTechnologies/zsh-very-colorful-manuals
    bicole/zsh-z
    bicole/zunit
    marlonrichert/zsh-hist
    zdharma-continuum/history-search-multi-word
    zdharma-continuum/zbrowse
    zdharma-continuum/zsh-tig-plugin
    zdharma-continuum/zsh-unique-id
    zdharma-continuum/zui
    zdharma-continuum/zzcomplete
    zsh-users/zsh-completions
    #comps
    MenkeTechnologies/zsh-better-npm-completion
    MenkeTechnologies/zsh-cargo-completion
    MenkeTechnologies/zsh-cpan-completion
    MenkeTechnologies/zsh-gem-completion
    MenkeTechnologies/zsh-pip-description-completion
    MenkeTechnologies/zsh-xcode-completions
)

ZPWR_OMZ_PLUGINS=(
    ansible
    autoenv
    azure
    coffee
    coffee
    colorize
    common-aliases
    # eza
    fzf
    git
    git-flow
    # gitfast
    gitignore
    golang
    gulp
    man
    nmap
    node
    npm
    nvm
    otp # oathtool
    # per-directory-history
    perl
    pip
    postgres
    pre-commit
    procs # procs
    pylint
    python
    rbenv
    rsync
    ruby
    rust
    ssh-agent
    ssh
    tailscale
    tig
    tmux
    uv
    vi-mode
    vscode
    vundle
    # wd
    zsh-interactive-cd
    zsh-navigation-tools
)

ZPWR_OMZ_LIBS=(
    git.zsh
    directories.zsh
    grep.zsh
    functions.zsh
    nvm.zsh
    termsupport.zsh
)

ZPWR_OMZ_COMPS=(
    autopep8/_autopep8
    coffee/_coffee
    git-flow/_git-flow
    gitfast/_git
    golang/_golang
    macos/_security
    pep8/_pep8
    pip/_pip
    pylint/_pylint
    redis-cli/_redis-cli
    rust/_rustc
)
