" Source Bundles stuff
"
source $HOME/.vim/bundles.vim

" Go, the crap invented by Google with deadbeat package management
set rtp +=$GOROOT/misc/vim

" Pseudoscientific rational universally applicable colorscheme
" It's quite pleasant to me, but all the oh-so-optimal junk makes me feel
" dirty
let g:solarized_termtrans=1
let g:solarized_termcolors=256
colorscheme solarized
 
syntax on
filetype plugin indent on
 
let mapleader = ","
let localleader = "\\"
 
let bclose_multiple = 0
 
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_extensions = ['bookmarkdir', 'dir', 'buffertag', 'tag', 'line', 'mixed']
 
set laststatus=2
set statusline=%F\ %m\ %{fugitive#statusline()}\ %y%=%l,%c\ %P
set number
 
" Misc stuff
map <leader>n :setlocal number!<cr>
map <leader>ft :set ft=
nnoremap <silent> <leader><leader> :noh<return><esc>

" CtrlP
map <leader>pb :CtrlPBookmarkDir<cr>
map <leader>pa :CtrlPBookmarkDirAdd 
map <leader>bh :CtrlP /Users/aleander<cr>
map <leader>bm :CtrlP /Users/aleander/Documents/Projects

" Vimux
map <Leader>rp :VimuxPromptCommand<CR>
map <Leader>rl :VimuxRunLastCommand<CR>
map <Leader>ri :VimuxInspectRunner<CR>
map <Leader>rx :VimuxClosePanes<CR>
map <Leader>rq :VimuxCloseRunner<CR>
map <Leader>rs :VimuxInterruptRunner<CR>

" http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting
nnoremap <Leader><esc> :noh<return><esc>
