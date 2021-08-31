set nocompatible              " be iMproved, required
filetype off                  " required

nnoremap <SPACE> <Nop>
let mapleader=" "

" autocmd BufEnter * lcd %:p:h " Set current directry as working directory. User Nerd tree toggle to reveal current file.

"Plug Package Manager
call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()

"Vundle Package Manager
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'preservim/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'rizzatti/dash.vim'
Plugin 'iamcco/markdown-preview.nvim' 
Plugin 'ctrlp.vim'
call vundle#end()            " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype plugin indent on    " required
syntax on
set autowrite
"colo molokai
set number
set relativenumber
set updatetime=100
set cursorline

"Theme
set t_Co=256 
set background=dark 
set laststatus=2
colorscheme PaperColor

"AirLine
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled = 1

"GoLang
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" au filetype go inoremap <buffer> . .<C-x><C-o>

" Ruby 
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2

" NerdTree configs
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1 " Show hidden files
set backspace=indent,eol,start
" NERDTree plugin specific commands
" :nnoremap <C-g> :NERDTreeToggle<CR>
map <leader>g :NERDTreeToggle<CR>
map <leader>j :NERDTreeFind<CR>

" ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_switch_buffer = 'et'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<c-l>"

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" let g:go_addtags_transform = "camelcase"

map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>
map <C-t>w :W<cr>

inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" Python YCM
let g:ycm_python_interpreter_path = '/usr/local/bin/python3'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'


" Vim Python
" set tabs to have 4 spaces
set ts=4
" indent when moving to the next line while writing code
set autoindent
" expand tabs into spaces
set expandtab
" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4
" show a visual line under the cursor's current line
set cursorline
" show the matching part of the pair for [] {} and ()
set showmatch
" enable all Python syntax highlighting features
let python_highlight_all = 1

" ruby
" Set specific linters
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'ruby': ['rubocop'],
\}
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1 
let g:airline#extensions#ale#enabled = 1 
let g:ale_sign_column_always = 1

" Ruby Solargraph
set hidden
let g:LanguageClient_serverCommands = {
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <C-m> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)

" Markdown preview
nmap P <Plug>MarkdownPreviewToggle

nnoremap B :CtrlPBuffer<Enter>
