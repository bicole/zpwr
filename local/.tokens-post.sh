#!/usr/bin/env zsh
# shellcheck shell=zsh
#
if zpwrExists zinit; then
  # shellcheck disable=SC1090
  . $HOME/.zcommon

  setopt promptsubst

  # Adding more zinit plugins after everything else has already run
  zinit light-mode lucid proto'ssh' for \
     zdharma-continuum/zinit-annex-rust \
     zdharma-continuum/zinit-annex-patch-dl \
     zdharma-continuum/zinit-annex-bin-gem-node \
     zdharma-continuum/zinit-annex-readurl \
     zdharma-continuum/zinit-annex-binary-symlink \
     zdharma-continuum/zinit-annex-linkman \
     zdharma-continuum/zinit-annex-submods \
     zdharma-continuum/zinit-annex-meta-plugins \
     zdharma-continuum/zinit-annex-default-ice \
     zdharma-continuum/zinit-annex-man \
     zdharma-continuum/zinit-annex-test \
     zdharma-continuum/zinit-annex-unscope \
     psprint/zinit-annex-pull

    zinit wait lucid for \
            OMZL::git.zsh \
        atload"unalias grv" \
            OMZP::git

    zinit wait'!' lucid for \
        OMZL::prompt_info_functions.zsh \
        OMZT::gnzh

    # gitfast
    # shellcheck disable=SC1011
    zinit wait'0a'H lucid nocompile for \
        felipec/git-completion

    zinit wait"1a" lucid for \
        akash329d/zsh-alias-finder \
        sparsick/ansible-zsh

    zinit svn from"github" pick"async.zsh" light-mode for \
        mafredri/zsh-async

    zinit proto'ssh' for \
        vineyardbovines/auto-color-ls

    zinit wait'1c' for MichaelAquilina/zsh-auto-notify

    zinit wait"1b" proto'ssh' for \
        manlao/zsh-auto-nvm

    zinit svn pick"auto-venv.zsh" from"github" ver"main" for \
        Skylor-Tang/auto-venv

    zinit wait lucid for \
        MichaelAquilina/zsh-autoswitch-virtualenv \
        dmakeienko/azcli \
        milespossing/Azure-Keyvault-Zsh \
        svn           Tarrasch/zsh-bd \
        begris/bw-zsh-plugin \
        bossjones/boss-git-zsh-plugin \

  # Packs
    # ls_colors: default profile
    # system-completions: Utilize Turbo and initialize the completion system
    # fzy: Download with the bin-gem-node annex-utilizing ice list FROM GIT REPOSITORY
    zinit wait lucid for \
        pack ls_colors \
        pack atload=+"zicompinit; zicdreplay" system-completions \
        pack"bgn+keys" fzf \
        pack"bgn" git fzy \
        pack apr \
        pack dircolors-material

  # Programs
    # All of the above using the for-syntax and also z-a-bin-gem-node annex
    zinit wait"1" lucid from"gh-r" as"null" for \
         sbin"**/fd"        @sharkdp/fd \
         sbin"**/bat"       @sharkdp/bat \
         sbin"exa* -> exa"  ogham/exa

    zinit ice from"gh-r" as"program" mv"docker* -> docker-compose"
    zinit light docker/compose

    # jarun/nnn, a file browser, using the for-syntax
    zinit pick"misc/quitcd/quitcd.zsh" sbin make light-mode for jarun/nnn

    # zinit ice as"program" atclone"rm -f src/auto/config.cache; ./configure" \
    #     atpull"%atclone" make pick"src/vim"
    # zinit light vim/vim

    zinit ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
        atpull'%atclone' src"zhook.zsh"
    zinit light direnv/direnv

    # zinit ice from"gh-r" as"program" mv"direnv* -> direnv"
    # zinit light direnv/direnv

    zinit ice from"gh-r" as"program" mv"shfmt* -> shfmt"
    zinit light mvdan/sh

    zinit ice as"program" pick"yank" make
    zinit light mptre/yank

    zinit ice wait'2' lucid has'cmake;make' as'command' pick'src/vramsteg' proto'ssh' \
        atclone'cmake .' atpull'%atclone' make
    zinit light z-shell/vramsteg-zsh

    zinit ice as"program" pick"$ZPFX/sdkman/bin/sdk" id-as'sdkman' run-atpull \
        atclone"wget https://get.sdkman.io/?rcupdate=false -O scr.sh; SDKMAN_DIR=$ZPFX/sdkman bash scr.sh" \
        atpull"SDKMAN_DIR=$ZPFX/sdkman sdk selfupdate" \
        atinit"export SDKMAN_DIR=$ZPFX/sdkman; source $ZPFX/sdkman/bin/sdkman-init.sh"
    zinit light zdharma-continuum/null

    # asciinema
    zinit ice as"command" wait lucid \
        atinit"export PYTHONPATH=$ZPFX/lib/python3.7/site-packages/" \
        atclone"PYTHONPATH=$ZPFX/lib/python3.7/site-packages/ \
        python3 setup.py --quiet install --prefix $ZPFX" \
        atpull'%atclone' test'0' \
        pick"$ZPFX/bin/asciinema"
    zinit load asciinema/asciinema.git

    # Installation of Rust compiler environment via the z-a-rust annex
    # shellcheck disable=SC3054
    zinit id-as"rust" wait=1 as=null sbin="bin/*" lucid rustup \
        atload="[[ ! -f ${ZINIT[COMPLETIONS_DIR]}/_cargo ]] && zinit creinstall -q rust; \
        export CARGO_HOME=\$PWD; export RUSTUP_HOME=\$PWD/rustup" for \
            zdharma-continuum/null

  # Completions
    zinit ice as"completion" proto"ssh"
    zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

    zinit ice as"completion"
    zinit light zsh-users/zsh-completions

  # Scripts
    # ogham/exa also uses the definitions
    # shellcheck disable=SC2296,SC2298,SC2016
    zinit ice wait"0c" lucid reset \
        atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
                \${P}sed -i \
                '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
                \${P}dircolors -b LS_COLORS > c.zsh" \
        atpull'%atclone' pick"c.zsh" nocompile'!' \
        atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
    zinit light trapd00r/LS_COLORS

    # revolver
    zinit ice wait"2" lucid as"program" pick"revolver"
    zinit light molovo/revolver

    # zunit
    zinit ice wait"2" lucid as"program" pick"zunit" \
                atclone"./build.zsh" atpull"%atclone"
    zinit load molovo/zunit

    zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX" nocompile
    zinit light tj/git-extras

    # shellcheck disable=SC2016
    zinit ice as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' \
        atpull'%atclone' make'install' pick"$ZPFX/bin/git-cal"
    zinit light k4rthik/git-cal

    zinit ice as"program" id-as"git-unique" pick"git-unique"
    zinit snippet git@github.com/Osse/git-scripts/blob/master/git-unique

    zinit ice as"program" cp"wd.sh -> wd" mv"_wd.sh -> _wd" \
        atpull'!git reset --hard' pick"wd"
    zinit light mfaerevaag/wd

    zinit ice as"program" pick"bin/archey"
    zinit load obihann/archey-osx

  # Plugins
    zinit ice pick"h.sh"
    zinit light paoloantinori/hhighlighter

    # # forgit
    # zinit ice wait lucid
    # zinit load 'wfxr/forgit'

    # diff-so-fancy
    zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
    zinit load zdharma-continuum/zsh-diff-so-fancy

    # zsh-startify, a vim-startify like plugin
    zinit ice wait"0b" lucid atload"zsh-startify"
    zinit load zdharma-continuum/zsh-startify

    # declare-zsh
    zinit ice wait"2" lucid
    zinit load zdharma-continuum/declare-zsh

    # fzf-marks
    zinit ice wait lucid
    zinit load urbainvaes/fzf-marks

    # # zsh-autopair
    # zinit ice wait lucid
    # zinit load hlissner/zsh-autopair

    zinit ice wait"1" lucid
    zinit load psprint/zsh-navigation-tools

    # zdharma-continuum/history-search-multi-word
    zstyle ":history-search-multi-word" page-size "11"
    zinit ice wait"1" lucid
    zinit load zdharma-continuum/history-search-multi-word

    # ZUI and Crasis
    zinit ice wait"1" lucid
    zinit load zdharma-continuum/zui

    # shellcheck disable=SC2016
    zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)cra*]} ]]' lucid
    zinit load zdharma-continuum/zinit-crasis

    # Gitignore plugin – commands gii and gi
    zinit ice wait"2" lucid
    zinit load voronkovich/gitignore.plugin.zsh

    # Autosuggestions & fast-syntax-highlighting
    # zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
    # zinit light zdharma-continuum/fast-syntax-highlighting
    # # zsh-autosuggestions
    # zinit ice wait lucid atload"!_zsh_autosuggest_start"
    # zinit load zsh-users/zsh-autosuggestions

  # Snippets
    zinit snippet OMZP::macos


  # Git
    zinit as'null' wait'3a' lucid for \
      sbin Fakerr/git-recall \
      sbin davidosomething/git-my \
        make"PREFIX=$ZPFX install" \
      iwata/git-now \
      sbin paulirish/git-open \
      sbin paulirish/git-recent \
        make"PREFIX=$ZPFX install" \
      tj/git-extras \
        make'GITURL_NO_CGITURL=1' \
        sbin'git-url;git-guclone' \
      zdharma-continuum/git-url

  # Themes
    zinit ice wait'!' lucid nocompletions \
           compile"{zinc_functions/*,segments/*,zinc.zsh}" \
           atload'!prompt_zinc_setup; prompt_zinc_precmd'
    zinit load robobenklein/zinc

    # ZINC git info is already async, but if you want it
    # even faster with gitstatus in Turbo mode:
    zinit wait'3b' proto'ssh' for \
        romkatv/gitstatus

    zinit wait configure make for universal-ctags/ctags

    zinit wait'5' lucid proto'ssh' for \
            OMZP::colored-man-pages \
        as'completion' \
            OMZP::docker/completions/_docker

  # Ensures that building formulae from source doesn't link against Pyenv-provided Python
  export BREW_ORIGINAL="$(which brew)"
  alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

  source ~/.config/envman/PATH.env

  # Generated for envman. Do not edit.
  [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
