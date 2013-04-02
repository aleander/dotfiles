# Final components of paths, needed before we add things like perlbrew
export PATH="/usr/local/bin:$PATH"
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

# History
export HISTFILE=~/.zshhistory
export HISTSIZE=1000
export SAVEHIST=1000
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# Stuff for languages
# Go
#
# First find it
if [ -x "$(which go)" ] ; then 
	export GOVERSION=$(go version | sed 's/^.*[^0-9]\(\([0-9]\{1,\}\.\)\{2\}[0-9]\)$/\1/')
	export GOROOT=${$(dirname $(which go))/\/bin/}
	export GOPATH=~/.go:~/Documents/Projects/go
	source $GOROOT/share/zsh/site-functions/_go
fi

# Perl
if [ -d ~/.perl5 ] ; then
	export PERLBREW_ROOT=~/.perl5/perlbrew
	source ~/.perl5/perlbrew/etc/bashrc
	source ~/.perl5/perlbrew/etc/perlbrew-completion.bash
fi

# Ruby
if [ -d ~/.rbenv ] ; then
	eval "$(rbenv init -)"
fi

# Python
if [ -x "$(which python)" ] ; then
	mypython=$(which python)
	if [ -x ${$(dirname $(which python))/bin/share\/python/}virtualenvwrapper.sh -a -d $HOME/.venvs ] ; then
		export WORKON_HOME=~/.venvs
		source ${$(dirname $(which python))/bin/share\/python/}virtualenvwrapper.sh
	fi
fi

if [ -f ~/.zsh/final_setup ] ; then
	source ~/.zsh/final_setup
fi

# Set and cleanup paths
export PATH="$HOME/.bin:${GOPATH//://bin:}/bin:$GOROOT/bin:$PATH"
path=($^path(N))
manpath=($^manpath(N))
setopt EXTENDED_GLOB
path=(${${path//\/##/\/}%/})
manpath=(${${manpath//\/##/\/}%/})
unsetopt EXTENDED_GLOB
typeset -U path manpath
