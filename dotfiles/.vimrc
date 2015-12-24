let g:python_host_prog = '/usr/local/bin/python'
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'junegunn/vim-emoji'
Plug 'junegunn/vim-journal'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
if v:version >= 703
  Plug 'mhinz/vim-signify'
endif

Plug 'benekastah/neomake'

Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'    }
if v:version >= 703
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle'      }
endif
Plug 'justinmk/vim-gtfo'

Plug 'altercation/vim-colors-solarized'

" Languages
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'chrisbra/unicode.vim', { 'for': 'journal' }

call plug#end()

" Pseudoscientific rational universally applicable colorscheme
" It's quite pleasant to me, but all the oh-so-optimal junk makes me feel
" dirty
if has('gui_running')
    set background=light
else
    set background=dark
endif
let g:solarized_termtrans=1
let g:solarized_termcolors=256
colorscheme solarized

let mapleader = ","
let localleader = "\\"

let bclose_multiple = 0

set laststatus=2
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P
set number

" Misc stuff
map <leader>n :setlocal number!<cr>
map <leader>ft :set ft=
nnoremap <silent> <leader><esc> :noh<return><esc>

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

nnoremap <silent> <leader><leader> :Files<cr>
nnoremap <silent> <leader>C        :Colors<cr>
nnoremap <silent> <leader><enter>  :Buffers<cr>
nnoremap <silent> <leader>ag      :Ag <c-r><c-w><cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

