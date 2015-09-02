" Call this before other things, because it could mess things up
set nocompatible
" Start up pathogen
execute pathogen#infect()
" Turn filetype plugin on
filetype plugin indent on
" Use pathogen to easily modify the runtime path to include
" all plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" Set the colorscheme and font settings
" colorscheme solarized
colorscheme molokai
syntax on
set guifont=Consolas

" set guioptions - for eclipse integration
" set guioptions-=m " turn off menu bar
" set guioptions-=T " turn off toolbar
" set guioptions-=L " turn off left scroll bar
" set guioptions-=l

" backspace fix
set backspace=indent,eol,start

" set leader to comma
let mapleader=","

" Set working directory
cd ~/workspaces/l_dev_workspace
set autochdir
let NERDTreeChDirMode=2
let Tlist_Use_Right_Window=1

" set eclim locate file scope to project
let g:EclimLocateFileScope='workspace'
" set eclim locate to be non-case sensitive
let g:EclimLocateFileCaseInsensitive='never'
" set eclim todo search to show TODO Eric
let g:EclimTodoSearchPattern='\(\<fixme\>\|\<todo\>\)\c'
" set eclim to keep local history]
let g:EclimProjectKeepLocalHistory=1


" quickly edit and reload the vimrc file by pressing
" \ev \sv
" !! Currently not working
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" VIM Behaviour
set hidden			" Hide buffers instead of closing them
set nowrap			" don't wrap lines
set tabstop=4		" a tab is four spaces
set autoindent		" always set autoindenting on
set copyindent		" copy the previous indentation on autoidenting
set number			" always show line numbers
set shiftwidth=4	" number of spaces to use for autoindenting
set shiftround		" use multiple of shiftwidth when indenting with '<' and '>'
set showmatch		" set show matching parens
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,
					" 	case sensitive otherwise
set smarttab		" insert tabs on the start of a line according to
					"	shiftwidth, not tabstop
set hlsearch		" highlight search terms
set incsearch		" show search matches as you type
set history=1000	" remember more commands and search history
set undolevels=1000	" use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title			" change the terminal's title
set visualbell		" don't beep
set noerrorbells	" don't beep
set mouse=a			" enable the mouse

" Don't let VIM write backup files. Remove if you suck at teh bash and 
" your terminal crashes regularly or you are dealing with huge files
set nobackup
set noswapfile

"Turn off the arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Map space to center screen on line
nmap <space> zz

" =- Set shortcuts -=
" suggested mappings
nnoremap <silent> <leader>i :JavaImport<cr>
"nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declarations<cr>
nnoremap <silent> <leader>s :JavaSearch<cr>
nnoremap <silent> <leader>S :JavaDocSearch<cr>
"nnoremap <silent> <leader>C :JavaSearchContext<cr>
" custom mappings
nnoremap <silent> <leader>n 	:NERDTreeToggle .<CR>
nnoremap <silent> <leader>N 	:ProjectTreeToggle <CR>
nnoremap <silent> <leader>l 	:TlistToggle <CR>
nnoremap <silent> <leader>f 	:LocateFile <CR>
nnoremap <silent> <leader>b		:Buffers <CR>
nnoremap <silent> <leader>m  	:Sign <CR>
nnoremap <silent> <leader>M  	:Signs <CR>
nnoremap <silent> <leader>e		:lopen <CR>

" Scratch pad
nnoremap <silent> <leader>p		:Sscratch<CR>

" Date insert
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

" Auto open NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif

" Close vim if the only windows open is NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | en

" Auto load vimrc if it is changed
autocmd! bufwritepost _vimrc source %

" xml formatting with :PrettyXML
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint.exe --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
