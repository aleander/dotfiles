#!/usr/bin/env zsh

# You did install zsh first, did you?
#chsh -s $(which zsh)

cd $HOME

dotdirs=("${(@f)$(find .dotfiles/dotfiles -type d)}")
dotfiles=("${(@f)$(find .dotfiles/dotfiles -type f | grep -v '.swp$')}")
timestamp=$(date +%Y%m%d%H%M%S)

for d in $dotdirs ; do
	mkdir -p $d
done

for f in $dotfiles ; do
	fn=${f/.dotfiles\/dotfiles\//}
	if [ -e $fn ] ; then
		mkdir -p .dotfiles/backup-$timestamp/$(dirname $fn)
		mv $fn .dotfiles/backup-$timestamp/$fn
	fi
	ln -sf "$HOME/$f" "$fn"
done

# Init vim. If there is no vim, I ain't playing that game
if ! [ -d ~/.vim/bundle/vundle ] ; then
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

vim -u ~/.vim/bundles.vim +BundleInstall +qa
