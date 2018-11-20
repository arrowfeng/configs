" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

let skip_defaults_vim=1
syntax enable
syntax on
set number
set showmode
set encoding=utf-8
set t_Co=256
set autoindent
set tabstop=2
set showmatch
set ignorecase
set foldenable
set ruler
set mouse=a

"au BufRead,BufNewFile *.py set filetype=py

" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh,*.py exec ":call SetTitle()"
" 加入注释
func SetComment()
	call setline(1,"/*================================================================")
	call append(line("."),   "*   Copyright (C) ".strftime("%Y")." HALO Ltd. All rights reserved.")
	call append(line(".")+1, "*   ")
	call append(line(".")+2, "*   文件名称：".expand("%:t"))
	call append(line(".")+3, "*   创 建 者：Zhangdunfeng")
	call append(line(".")+4, "*   创建日期：".strftime("%Y-%m-%d %H:%M:%S"))
	call append(line(".")+5, "*   描    述：")
	call append(line(".")+6, "*")
	call append(line(".")+7, "================================================================*/")
	call append(line(".")+8, "")
	call append(line(".")+9, "")
endfunc
" 加入shell,Makefile注释
func SetComment_sh()
	call setline(4, "#================================================================")
	call setline(5, "#   Copyright (C) ".strftime("%Y")." HALO Ltd. All rights reserved.")
	call setline(6, "#   ")
	call setline(7, "#   文件名称：".expand("%:t"))
	call setline(8, "#   创 建 者：Zhangdunfeng")
	call setline(9, "#   创建日期：".strftime("%Y-%m-%d %H:%M:%S"))
	call setline(10, "#   描    述：")
	call setline(11, "#")
	call setline(12, "#================================================================")
	call setline(13, "")
	call setline(14, "")
endfunc
" 定义函数SetTitle，自动插入文件头
func SetTitle()
	if &filetype == 'make'
		call setline(1,"")
		call setline(2,"")
		call SetComment_sh()

	elseif &filetype == 'sh'
		call setline(1,"#!/bin/bash")
		call setline(2,"")
		call SetComment_sh()
	
	elseif &filetype == 'python'
		call setline(1,"#!/usr/bin/python")
		call setline(2,"# coding=UTF-8")
		call setline(3,"")
		call SetComment_sh()

	else
	    call SetComment()
	    if expand("%:e") == 'hpp'
		  call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")
		  call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")
		  call append(line(".")+12, "#ifdef __cplusplus")
		  call append(line(".")+13, "extern \"C\"")
		  call append(line(".")+14, "{")
		  call append(line(".")+15, "#endif")
		  call append(line(".")+16, "")
		  call append(line(".")+17, "#ifdef __cplusplus")
		  call append(line(".")+18, "}")
		  call append(line(".")+19, "#endif")
		  call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")

	    elseif expand("%:e") == 'h'
	  	call append(line(".")+10, "#pragma once")
	    elseif &filetype == 'c'
	  	call append(line(".")+10,"#include \"".expand("%:t:r").".h\"")
	    elseif &filetype == 'cpp'
	  	call append(line(".")+10, "#include \"".expand("%:t:r").".h\"")
	    endif
	endif
endfunc
