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

    zinit wait"0a" lucid from"gh" pick"async.zsh" for \
      mafredri/zsh-async

    zinit wait"0b" lucid for \
            OMZL::git.zsh \
        atload"unalias grv" \
            OMZP::git \
        nocompile \
            felipec/git-completion

    zinit wait'!0c' lucid for \
        OMZL::prompt_info_functions.zsh \

    zinit wait"1a" lucid for \
      atload'ZSH_ALIAS_FINDER_IGNORED="lc,ls,cd,dir,g"' \
        akash329d/zsh-alias-finder \
        MichaelAquilina/zsh-auto-notify \
        MichaelAquilina/zsh-autoswitch-virtualenv \
      svn pick"auto-venv.zsh" from"github" ver"main" \
        Skylor-Tang/auto-venv \
      proto'ssh' atload'alias lc="colorls -lA --sd --gs --dark -t"' \
        vineyardbovines/auto-color-ls \
      proto'ssh' \
        manlao/zsh-auto-nvm

    zinit wait"1b" lucid for \
        dmakeienko/azcli \
        milespossing/Azure-Keyvault-Zsh \
        Tarrasch/zsh-bd \
        begris/bw-zsh-plugin \
        sparsick/ansible-zsh

  # Packs
    # system-completions: Utilize Turbo and initialize the completion system
    # fzy: Download with the bin-gem-node annex-utilizing ice list FROM GIT REPOSITORY
    zinit wait lucid for \
        pack atload=+"zicompinit; zicdreplay" system-completions \
        pack"bgn+keys" fzf \
        pack"bgn" git fzy \
        pack dircolors-material

  # Programs
    # All of the above using the for-syntax and also z-a-bin-gem-node annex
    zinit wait"1" lucid from"gh-r" as"null" for \
         sbin"**/fd"        @sharkdp/fd \
         sbin"**/bat"       @sharkdp/bat \
         sbin"exa* -> exa"  ogham/exa

    zinit ice lucid from"gh-r" as"program" mv"docker* -> docker-compose"
    zinit light docker/compose

    # jarun/nnn, a file browser, using the for-syntax
    zinit lucid pick"misc/quitcd/quitcd.zsh" sbin make light-mode for jarun/nnn

    # zinit ice as"program" atclone"rm -f src/auto/config.cache; ./configure" \
    #     atpull"%atclone" make pick"src/vim"
    # zinit light vim/vim

    zinit from"gh-r" as"program" mv"direnv* -> direnv" \
        atclone'./direnv hook zsh > zhook.zsh' \
        atpull'%atclone' src"zhook.zsh" pick"direnv" for \
            direnv/direnv

    zinit ice lucid from"gh-r" as"program" mv"shfmt* -> shfmt"
    zinit light mvdan/sh

    zinit ice lucid as"program" pick"yank" make
    zinit light mptre/yank

    zinit ice wait'2' lucid has'cmake;make' as'command' pick'src/vramsteg' proto'ssh' \
        atclone'cmake .' atpull'%atclone' make
    zinit light z-shell/vramsteg-zsh

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
    zinit as"completion" proto"ssh" lucid for /
      https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

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

    zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX" nocompile lucid
    zinit light tj/git-extras

    # shellcheck disable=SC2016
    zinit ice as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' \
        atpull'%atclone' make'install' pick"$ZPFX/bin/git-cal" lucid
    zinit light k4rthik/git-cal

    # git-scripts
    GitScripts=(
      git-blamediff
      git-blamedir
      git-brv
      git-fflocals
      git-findfixup
      git-move
      git-rewrite
      git-unique
      git-unmerged
      git-vdiff
    )
    for s in ${GitScripts}; do
      zinit ice as"program" id-as"${s}" pick"${s}" lucid
      zinit snippet "https://github.com/Osse/git-scripts/blob/master/${s}"
    done

    # zinit ice as"program" id-as"git-unique" pick"git-unique" lucid
    # zinit snippet git@github.com/Osse/git-scripts/blob/master/git-unique

    # zinit ice as"program" cp"wd.sh -> wd" mv"_wd.sh -> _wd" \
    #     atpull'!git reset --hard' pick"wd" lucid
    # zinit light mfaerevaag/wd
    zinit as"program" cp"wd.sh -> wd" mv"_wd.sh -> _wd" \
        atpull'!git reset --hard' pick"wd" lucid for \
          mfaerevaag/wd

    # zinit ice as"program" pick"bin/archey" lucid
    # zinit load obihann/archey-osx
    zinit as"program" pick"bin/archey" lucid for \
      obihann/archey-osx

  # Plugins
    zinit ice pick"h.sh" lucid
    zinit light paoloantinori/hhighlighter

    # # forgit
    # zinit ice wait lucid
    # zinit load 'wfxr/forgit'

    # diff-so-fancy
    zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
    zinit load zdharma-continuum/zsh-diff-so-fancy

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
    # zinit wait lucid for \
    #   atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    #     zdharma-continuum/fast-syntax-highlighting \
    #   blockf \
    #     zsh-users/zsh-completions \
    #   atload"!_zsh_autosuggest_start" \
    #     zsh-users/zsh-autosuggestions

  # Snippets
    zinit ice wait"3" lucid
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
    # zinit ice wait'!' lucid nocompletions \
    #        compile"{zinc_functions/*,segments/*,zinc.zsh}" \
    #        atload'!prompt_zinc_setup; prompt_zinc_precmd'
    # zinit load robobenklein/zinc

    # # ZINC git info is already async, but if you want it
    # # even faster with gitstatus in Turbo mode:
    # zinit wait'3b' proto'ssh' for \
    #     romkatv/gitstatus

    zinit lucid wait'4' configure make for universal-ctags/ctags

    zinit wait'5' lucid proto'ssh' for \
            OMZP::colored-man-pages \
        as'completion' \
            OMZP::docker/completions/_docker

    zinit lucid wait'5a' proto'ssh' for \
        multisrc'per-directory-history.plugin.zsh per-directory-history.zsh' \
          OMZP::per-directory-history \
        multisrc'gitfast.plugin.zsh git-prompt.zsh' \
          OMZP::gitfast

    zinit lucid wait'!6a' for zdharma-continuum/null

  if zpwrExists pyenv; then
    # Ensures that building formulae from source doesn't link against Pyenv-provided Python
    export BREW_ORIGINAL="$(which brew)"
    alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
  fi

  source ~/.config/envman/PATH.env

  # Generated for envman. Do not edit.
  [ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
