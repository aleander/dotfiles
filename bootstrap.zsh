#!/usr/bin/env zsh

# You did install zsh first, did you?
#chsh -s $(which zsh)

cd $HOME

dotdirs=("${(@f)$(find .dotfiles/dotfiles -type d)}")
dotfiles=("${(@f)$(find .dotfiles/dotfiles -type f | grep -v '.swp$')}")
timestamp=$(date +%Y%m%d%H%M%S)

for d in $dotdirs ; do
	mkdir -p ${d/.dotfiles\/dotfiles\//}
done

for f in $dotfiles ; do
	fn=${f/.dotfiles\/dotfiles\//}
	if [ -e $fn ] ; then
		mkdir -p .dotfiles/backup-$timestamp/$(dirname $fn)
		mv $fn .dotfiles/backup-$timestamp/$fn
	fi
  ln -sf "$HOME/$f" "$fn"
done

mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}

if [ -f $XDG_CONFIG_HOME/modzero/dotfiles.sh ]; then
  source  $XDG_CONFIG_HOME/modzero/dotfiles.sh
fi

VIM_COMMAND=vim

if [ "${SKIP_VIMPLUG}" != "yes" ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  $VIM_COMMAND +PlugInstall +qall
fi
