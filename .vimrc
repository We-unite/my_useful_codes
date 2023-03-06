set nocompatible              " 去除VI一致性,必须
filetype off                  " 必须

"============================
set nocp    "设置兼容
set expandtab   "设置tab
set shiftwidth=4    "设置tab的间隔
set tabstop=4   "四个空格代表一个tab
set sts=4
set showmatch   "在输入括号时光标会短暂地跳到与之相匹配的括号处
set autoindent  "设置自动缩进
" set smartindent "设置智能缩进
""set nowrap    "设置自动换行
set tw=500
set lbr
"===set guifont=Monospace "设置字体大小 
set guifont=Courier\ New:b:h16
set encoding=utf-8  "设置编码为utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,GB18030,cp936,big5,euc-jp,euc-kr,latin1
set helplang=cn "帮助中文支持
colorscheme evening "设置主体颜色
set mouse=v " 设置粘贴和复制
"set mouse=a 设置允许鼠标移动光标
 
"自动补全配置
autocmd FileType python set omnifunc=pythoncomplete#Complete 
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS 
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags 
autocmd FileType css set omnifunc=csscomplete#CompleteCSS 
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags 
autocmd FileType php set omnifunc=phpcomplete#CompletePHP 
autocmd FileType c set omnifunc=ccomplete#Complete 
 
" =================================进行Taglist的设置<Begin>============================
map <F3> :TlistToggle<CR>
"map <F3> :silent! Tlist<CR>             "按下F3就可以呼出了
"let Tlist_Ctags_Cmd='/usr/bin/ctags'    "因为我们放在环境变量里，所以可以直接执行 
let Tlist_Use_Right_Window=1            "让窗口显示在右边，0的话就是显示在左边  
"let Tlist_Show_One_File=1               "让taglist可以同时展示多个文件的函数列表 
"let Tlist_File_Fold_Auto_Close=1        "非当前文件，函数列表折叠隐藏 
"let Tlist_Exit_OnlyWindow=1             "当taglist是最后一个分割窗口时，自动推出vim 
"let Tlist_Process_File_Always=0         "是否一直处理tags.1:处理;0:不处理  
"let Tlist_Inc_Winwidth=0                "不是一直实时更新tags，因为没有必要  
" =================================进行Taglist的设置<End>==============================
 
 
 
 
" ############################键盘映射设置区域###############################
map <F2> :NERDTreeToggle<CR>
map <F4> t :NERDTreeMirror<CR>
 
 
" 对应使用函数的配置
set guitablabel=%{ShortTabLabel()}
function ShortTabLabel ()
  let bufnrlist = tabpagebuflist (v:lnum)
  let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
  let filename = fnamemodify (label, ':t')
  return filename
endfunction
 
set tabline=%!MyTabLine()
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " 选择高亮
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " 设置标签页号 (用于鼠标点击)
    let s .= '%' . (i + 1) . 'T'
    " MyTabLabel() 提供完整路径标签 MyShortTabLabel 提供文件名标签
    let s .= ' %{MyShortTabLabel(' . (i + 1) . ')} '
  endfor
  " 最后一个标签页之后用 TabLineFill 填充并复位标签页号
  let s .= '%#TabLineFill#%T'
  " 右对齐用于关闭当前标签页的标签
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif
  return s
endfunction
" 文件名标签
function MyShortTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let label = bufname (buflist[tabpagewinnr (a:n) -1])
  let filename = fnamemodify (label, ':t')
  return filename
endfunction
"完整路径标签
function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  return bufname(buflist[winnr - 1])
endfunction
" vim 标签样式
"  TabLineFill  tab pages line, where there are no labels
hi TabLineFill term=none
hi TabLineFill ctermfg=DarkGrey
hi TabLineFill guifg=#777777
"  TabLineSel   tab pages line, active tab page label
hi TabLineSel term=inverse
hi TabLineSel cterm=none ctermfg=yellow ctermbg=Black
hi TabLineSel gui=none guifg=yellow guibg=Black
  
" Develop editing options
au FileType vim setl expandtab
au FileType vim setl shiftwidth=2
au FileType vim setl tabstop=2
 
" 显示状态栏(默认值为 1，无法显示状态栏)
set laststatus=2
" Format the statusline
" set statusline= %f %m %r %h %w  CWD: %r%{CurDir()}E5%h   Line: %l/%L:%c
  
function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

"#######各类符号自动匹配
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>
:inoremap " ""<Esc>i

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "<Right>"
    else
        return a:char
    endif
endfunction
"#######各类符号自动匹配

"MySet"

set rnu "设置相对行号
set nu "设置绝对行号
" Set cursor shape and color
if &term =~ "xterm"
    " INSERT mode
    let &t_SI = "\<Esc>[6 q" . "\<Esc>]12;blue\x7"
    " REPLACE mode
    let &t_SR = "\<Esc>[3 q" . "\<Esc>]12;black\x7"
    " NORMAL mode
    let &t_EI = "\<Esc>[2 q" . "\<Esc>]12;green\x7"
endif
" 1 -> blinking block  闪烁的方块
" 2 -> solid block  不闪烁的方块
" 3 -> blinking underscore  闪烁的下划线
" 4 -> solid underscore  不闪烁的下划线
" 5 -> blinking vertical bar  闪烁的竖线
" 6 -> solid vertical bar  不闪烁的竖线

syntax on
set cul
set cuc
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white "设置显示当前行当前列为深红色
""set lines=24 columns=80
""set t_Co=256
""set wrap "设置自动折行
