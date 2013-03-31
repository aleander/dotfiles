set nocompatible
filetype off
 
set rtp +=~/.vim/bundle/vundle/
call vundle#rc()
 
" My bundles here
"
" Vundle itself
Bundle 'gmarik/vundle'
" Pretty
Bundle 'altercation/vim-colors-solarized'
" Where am I?
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
" TMux
Bundle 'benmills/vimux'
Bundle 'benmills/vimux-golang'
Bundle 'benmills/vimux-ruby-test'
" Languages
" Ruby, the worst thing to ever happen to programming languages
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rbenv'
" Yes, I do include a lot of crap by tpope, the guy who think "foreplay" is a
" good name for a software package. At least it's not smf.sh, seriously, yes,
" that thing exists.
"
" Generally, I should have quit that software development bullshit and moved
" go be a bike courier or something ages ago. Or maybe try teaching, I always
" assumed I'd be a crap teacher, but never really tried it. It's not really
" the same set of skills as socializing, as evidenced by bajillions of
" teachers who are abusive assholes with no knowledge but ample supply of
" conspiracy theories who still get to keep their job. Come to think of it, I
" don't want to have anything to do with them either. That settles it, I'm
" becoming a goddamn bike courier any moment now.
"
" Too bad it's Netherlands and everything is in walking distance. I'll just
" move to Finland and try to reenact UnReal world. Fuck it all.

" I sometimes use Python. Ambivalence of universe have mercy on my
" non-existent soul
"
" I would install jedi-vim, but it depends on jedi, which is a python thing,
" and no sanity comes from trying to install python packages system-wise,
" because fuck you all, that's why.

" No, I don't have special plugins for the language I write the most in.
" That's because perl is not bonkers insane or hell-bent on world destruction.
" I will now add some packages, because life sucks.
Bundle 'vim-perl/vim-perl'

