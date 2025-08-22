export ZPWR_AUTO_COMPLETE=true
export ZPWR_GITHUB_ACCOUNT='bicole'

export ZPWR_PLUGIN_MANAGER=zinit

export ZPWR_AUTO_LS_RM=false
export ZPWR_AUTO_LS_CD=false
export ZPWR_BANNER_CLEARLIST=false

export ZPWR_DEFAULT_OMZ_THEME=xiong-chiamiov-plus
# export ZPWR_PROMPT=OMZ
export ZPWR_PROMPT=powerlevel10k
export ZPWR_PROMPT_FILE=

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

# Ensures that building formulae from source doesn't link against Pyenv-provided Python
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

export FORGIT_FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"

# Unalias cd
# which cd >/dev/null 2>&1 && unset -f cd 2>/dev/null
which goto >/dev/null 2>&1 && unalias goto 2>/dev/null
goto() {
  cd $HOME/repos/*$1* || return
}
