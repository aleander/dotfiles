export PATH="${HOME}/bin:/usr/local/bin:$PATH:/usr/local/sbin"
export MANPATH="/usr/local/share/man:$MANPATH"


if [ -f ~/.zsh/initial_setup ] ; then
	source ~/.zsh/initial_setup
fi

# The pretty
autoload colors && colors
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git svn hg

vcs_info_wrapper() {
	vcs_info
	if [ -n "$vcs_info_msg_0_" ]; then
		echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
	fi
}
PROMPT="<%{$fg_no_bold[magenta]%}%*%{$reset_color%}> %{$fg_no_bold[green]%}%n%{$reset_color%}@%m:%{$fg_bold[blue]%}%~%{$reset_color%} (%h) %# %(?..%{$fg_bold[red]%}%?%{$reset_color%} )"
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

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
eval "$(pyenv virtualenv-init -)"

if [ -f ~/.zsh/final_setup ] ; then
	source ~/.zsh/final_setup
fi
path=($^path(N))
manpath=($^manpath(N))
setopt EXTENDED_GLOB
path=(${${path//\/##/\/}%/})
manpath=(${${manpath//\/##/\/}%/})
unsetopt EXTENDED_GLOB
typeset -U path manpath

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source /Users/modzero/.rvm/scripts/rvm

alias vim=nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
