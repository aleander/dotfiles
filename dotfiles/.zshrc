export PATH="${HOME}/.bin:/usr/local/bin:$PATH:/usr/local/sbin"
export MANPATH="/usr/local/share/man:$MANPATH"
export LANG=en_US.utf-8
export LC_CTYPE=en_US.utf-8

if [ -f ~/.zsh/initial_setup ] ; then
	source ~/.zsh/initial_setup
fi

setopt auto_pushd
setopt pushd_to_home
setopt pushd_ignore_dups

setopt extended_glob

# The pretty
autoload colors && colors
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' actionformats \
    "%{$fg_no_bold[magenta]%}(%{$reset_color%}%s%{$fg_no_bold[magenta]%})%{$fg_no_bold[yellow]%}-%{$fg_no_bold[magenta]%}[%{$fg_no_bold[green]%}%b%{$fg_no_bold[yellow]%}|%{$fg_no_bold[red]%}%a%{$fg_no_bold[magenta]%}]%{$reset_color%} "
zstyle ':vcs_info:*' formats       \
    "%{$fg_no_bold[magenta]%}(%{$reset_color%}%s%{$fg_no_bold[magenta]%})%{$fg_no_bold[yellow]%}-%{$fg_no_bold[magenta]%}[%{$fg_no_bold[green]%}%b%{$fg_no_bold[magenta]%}]%{$reset_color%} "
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git svn hg

vcs_info_wrapper() {
	vcs_info
	if [ -n "$vcs_info_msg_0_" ]; then
		echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
	fi
}

typeset -a precmd_functions
precmd_functions=()

my_precmd() {
  print -rP -- "-[$fg_no_bold[green]%n$reset_color@%m$fg_no_bold[yellow]:$fg_bold[blue]%~$reset_color]-${PYENV_VERSION:+$fg_no_bold[magenta]($fg_no_bold[yellow]$PYENV_VERSION$fg_no_bold[magenta])$reset_color}"
}

precmd_functions+=my_precmd

PROMPT="<%{$fg_no_bold[magenta]%}%*%{$reset_color%}> (%h) %# %(?..%{$fg_bold[red]%}%?%{$reset_color%} )"
RPROMPT=$'$(vcs_info_wrapper)'

export CLICOLOR=true
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
fpath=($HOME/.zsh/functions $fpath)

if [ $(uname) = 'Darwin' ] ; then
	# Use gnu ls
	alias ls='gls --color=auto'
	# And use dir colors
	eval $(gdircolors ~/.dir_colors)
else
	# Just parse the dir colors
	eval $(dircolors ~/.dir_colors)
	alias ls='ls --color=auto'
fi

# History
export HISTFILE=~/.zshhistory
export HISTSIZE=1000
export SAVEHIST=1000
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# Autocorrection sucks
unsetopt correct_all

# Autocomplete
autoload -U compinit
compinit
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcompdump
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

if [ "$(whence run-help)" != "run-help" ] ; then
  unalias run-help
  autoload run-help
  HELPDIR=/usr/local/share/zsh/help
fi

if which pyenv > /dev/null; then
  eval "$(pyenv init -)";
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
  eval "$(pyenv virtualenv-init -)"
fi

if which pyenv > /dev/null && which brew > /dev/null ; then
  # Stop pyenv from interfering with Homebrew
  alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
  if [[ -x $(which reattach-to-user-namespace) ]]; then

  fi
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -x "$(which composer)" ] && PATH="${HOME}/.composer/vendor/bin:${PATH}"
[ -f ~/.rvm/scripts/rvm ] && /Users/modzero/.rvm/scripts/rvm

[ -s "/Users/modzero/.dnx/dnvm/dnvm.sh" ] && . "/Users/modzero/.dnx/dnvm/dnvm.sh" # Load dnvm

export PATH="${HOME}/bin:${PATH}"
export GOPATH="${HOME}/Documents/Gopath"
export PATH="${GOPATH}/bin:/usr/local/opt/go/libexec/bin:${PATH}"

path=($^path(N))
manpath=($^manpath(N))
setopt EXTENDED_GLOB
path=(${${path//\/##/\/}%/})
manpath=(${${manpath//\/##/\/}%/})
unsetopt EXTENDED_GLOB
typeset -U path manpath

if [ -f ~/.zsh/final_setup ] ; then
	source ~/.zsh/final_setup
fi
