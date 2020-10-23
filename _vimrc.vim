" Vim with all enhancements
set encoding=utf-8
"插件管理 vim-plug
call plug#begin('D:\Vim\vimplugged')

" 使用标记的版本；允许通配符（需要git 1.9.2或以上）
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" 插件选项
"Plug 'nsf/gocode'
Plug 'ycm-core/YouCompleteMe'
"片段提示补全
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

"使用supertab解决ultisnips和ycm的冲突
Plug 'ervandew/supertab'

"tagbar for go project
Plug 'godlygeek/tabular'

"markdown
Plug 'plasticboy/vim-markdown'

"ctrlp
Plug 'ctrlpvim/ctrlp.vim'

" 设置NerdTree
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'

"##########为了debug go引入
Plug 'mklabs/vim-json' 

"Vim主题配色
Plug 'fatih/molokai'

call plug#end()

"启用真彩色
set termguicolors

"By default syntax-highlighting for Functions, Methods and Structs is disabled. To change it:
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"Enable goimports to automatically insert import paths instead of gofmt:
let g:go_fmt_command = "goimports"

"let g:go_def_mode='gopls' 用gopls的ctrl+]跳转定义话会报错，没弄明白。下面两个godef和guru都可以跳转到定义
"let g:go_def_mode = 'godef'
let g:go_def_mode='guru'
"let g:go_info_mode='godef'

"关于vim-go跳转出现问题的参考
"https://magodo.github.io/vim-go/

inoremap jk <ESC>

map <F1> :NERDTreeMirror<CR>
map <F2> :NERDTreeToggle<CR>

let g:tagbar_autopreview = 1
"关闭排序,即按标签本身在文件中的位置排序
let g:tagbar_sort = 0
let g:tagbar_width = 30
nmap <F3> :TagbarToggle<CR>
nmap <F4> :TagbarToggle<CR>

imap <F5> <C-x><C-o>
" 交换文件放到固定目录下
set directory=$VIM/.vimtmp/swap/
let dirname = $VIM . "/.vimtmp/swap/"
if !isdirectory(dirname)
  call mkdir(dirname, "p")
endif
set backupdir=$VIM/.vimtmp/backup/
let backupdirname=$VIM . "/.vimtmp/backup"
if !isdirectory(backupdirname)
    call mkdir(backupdirname)
endif
" 为所有文件设置持久性撤销
set undofile
set undodir=$VIM/.vimtmp/undodir
let undodirname = $VIM . "/.vimtmp/undodir"
if !isdirectory(undodirname)
  call mkdir(undodirname, "p")
endif
" 关闭缓冲区而不关闭窗口
command! Bd :bp | :sp | :bn | :bd
"折叠方式根据对齐来
set foldmethod=indent

"测试godef是否正常工作
autocmd FileType go nnoremap <buffer> gd :call GoDef()<cr> 
"函数在同一个文件中时不需要打开新窗口
let g:godef_same_file_in_same_window=1 ""
"在光标下定义出打开新窗口
let g:godef_split=0 

set number
imap <F5> <C-x><C-o>
"打开关闭undotree
nnoremap <F4> :UndotreeToggle<cr>

set nocompatible     " 关闭 vi 兼容模式
set nobackup         " 覆盖文件时不备份

set scrolloff=7
set cursorline cursorcolumn
set hlsearch
set incsearch
syntax on                 " 支持语法高亮显示
"filetype plugin indent on " 启用根据文件类型自动缩进
set autoindent            " 开始新行时处理缩进
set expandtab             " 将制表符Tab展开为空格，这对于Python尤其有用
set tabstop=4             " 要计算的空格数
set shiftwidth=4          " 用于自动缩进的空格数
set backspace=2           " 在多数终端上修正退格键Backspace的行为


colorscheme molokai " 修改配色

set autochdir     " 自动切换当前目录为当前
set hidden " 有未保存修改切换缓冲由vim负责保存
set smartindent  " 开启新行时使用智能自动缩进

set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ g
"Add the following line to your vimrc. This instructs deoplete to use omni completion for Go files.
"call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
"光标到上方窗口,需要<c-w><c-w>k,非常麻烦,现在重映射为<c-k>,切换的方便.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l



"默认的 . / -> / :: 是不会被覆盖的，只追加成新的 trigger，正则表达式代表相关语言源文件中，用户只需要输入符号的两个字母，即可自动弹出语义补全

let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,vim': ['rz!\w{2}'],
			\ 'cs,lua,javascript,sh': ['re!\w{2}'],
			\ }
"避免编辑白名单外的文件类型时 YCM也在那分析半天
let g:ycm_filetype_whitelist = { 
	\ "c":1,"cpp":1, "python":1,"java":1,
	\ "go":1,"vim":1,"cs":1,"lua":1,"js":1,
	\ "sh":1,"zsh":1,
	\ }


" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
 
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
