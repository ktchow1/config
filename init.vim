"**************
"*** Editor ***
"**************
set background=dark
set number
set relativenumber
set nocindent
set noautoindent
set nosmartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set hlsearch                " for search
set incsearch               " for search
set ignorecase              " for search
set smartcase               " for search
set splitright
set splitbelow
set mouse=a                 " enable mouse
set clipboard=unnamedplus   " Ubuntu clipboard
set nowrap!
imap <Insert> <Nop>         " disable insert key


"******************
"*** Navigation ***
"******************
" nnoremap <M-h> <C-w>h
" nnoremap <M-j> <C-w>j
" nnoremap <M-k> <C-w>k
" nnoremap <M-l> <C-w>l
" nnoremap <M--> <C-w>-
" nnoremap <M-+> <C-w>+
" nnoremap <TAB>n :tabnew<CR>
" nnoremap <TAB>c :tabclose<CR>
" nnoremap <Leader>c :ccl <bar> lcl<CR>
" inoremap <M-h> <LEFT>
" inoremap <M-j> <DOWN>
" inoremap <M-k> <UP>
" inoremap <M-l> <RIGHT>
" tnoremap <C-\> <C-\><C-n>


"**************************
"*** Build with scripts ***
"**************************
nnoremap <F1> :vnew<CR>:term<CR>
nnoremap <F13> <C-\><C-n> :q<CR>
nnoremap <F2> :copen<CR> <C-w>L
nnoremap <F14> :ccl<CR>
nnoremap <F3> :wa<CR>:setlocal makeprg=./scripts/build.sh<CR>:make debug<CR>
inoremap <F3> <ESC>:wa<CR>:setlocal makeprg=./scripts/build.sh<CR>:make debug<CR>
nnoremap <F4> :wa<CR>:setlocal makeprg=./scripts/build.sh<CR>:make release<CR>
inoremap <F4> <ESC>:wa<CR>:setlocal makeprg=./scripts/build.sh<CR>:make release<CR>


"**************************
"*** Manager : Vim-plug ***
"**************************
call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tomtom/tcomment_vim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'othree/eregex.vim'
Plug 'tpope/vim-surround'
call plug#end()


"************************
"*** Nerdtree / CtrlP ***
"************************
map <C-n> :NERDTreeToggle<CR>
map <C-p> :CtrlP<CR>    
:let g:NERDTreeWinSize=40
:let g:deoplete#enable_at_startup = 1


" **************
" *** Ctrl-P ***
" **************
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v[\/](node_modules)|(\.(git|hg|svn))$',
    \ 'file': '\v\.(so|swp|zip)$'
    \ }
let g:ctrlp_by_filename = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 0


"****************
"*** Fugitive ***
"****************
set diffopt+=vertical
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


"**************
"*** ERegex ***
"**************
let g:eregex_default_enable=0
let g:eregex_forward_delim='/'
let g:eregex_backward_delim='?'
let g:eregex_force_case=0
nnoremap <leader>/ :call eregex#toggle()<CR>


"*******************
"*** Vim-fswitch ***
"*******************
nmap <silent> <C-j>o :FSHere<cr>
nmap <silent> <C-j>l :FSSplitRight<cr>
nmap <silent> <C-j>h :FSSplitLeft<cr>
nmap <silent> <C-j>k :FSSplitAbove<cr>
nmap <silent> <C-j>j :FSSplitBelow<cr>

" augroup fswitch-config
"     au!
"     au BufEnter *.h let b:fswitchdst  = 'cpp,c'
"     au BufEnter *.h let b:fswitchlocs = 'reg:|include/OAPI|src|,reg:|include/reckless|src|,reg:|include/y|src|,reg:/include/src/'
"     au BufEnter *.cpp let b:fswitchdst  = 'h,hpp'
"     au BufEnter *.cpp let b:fswitchlocs = 'reg:|OAPI/src|OAPI/include/OAPI|,reg:|reckless/src|reckless/include/reckless|,reg:|src|include/y|,reg:/src/include/'
"     au BufEnter *.hpp let b:fswitchdst  = 'cpp'
"     au BufEnter *.hpp let b:fswitchlocs = 'reg:|include/OAPI|src|,reg:|include/reckless|src|,reg:/include/src/'
" augroup END


"*****************
"*** Functions ***
"*****************

"*** Open a new buffer for shell ***
function! IsTerminalExist()
    let buffers = tabpagebuflist(tabpagenr())
    for i in range(len(buffers))
        if bufname(get(buffers, i)) =~ "^term://"
            return get(buffers, i)
        endif
    endfor
    return 0
endfunction

function! ShellHWindow()
    echo "ShellHWindow"
    if IsTerminalExist() == 0
        new
        resize 12
        terminal
        execute "normal a"
    else
        execute "normal \<C-w>ja"
    endif
endfunction
nnoremap <M-s> :call ShellHWindow()<CR>
tnoremap <M-s> <C-\><C-n><C-w>k

function! ShellVWindow()
    echo "ShellVWindow"
    if IsTerminalExist() == 0
        vnew
        terminal
        execute "normal a"
    else
        execute "normal \<C-w>la"
    endif
endfunction
nnoremap <M-S> :call ShellVWindow()<CR>
tnoremap <M-S> <C-\><C-n><C-w>h

"*** Close hidden buffers ***
function! CloseHiddenBuffers()
    let open_buffers = []
    for i in range(tabpagenr('$'))
        call extend(open_buffers, tabpagebuflist(i + 1))
    endfor
    for num in range(1, bufnr("$") + 1)
        if buflisted(num) && index(open_buffers, num) == -1
            exec "bdelete ".num
        endif
    endfor
endfunction
nnoremap <M-b> :call CloseHiddenBuffers()<CR>
