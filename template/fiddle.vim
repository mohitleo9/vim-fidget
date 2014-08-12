if !exists("g:fiddle_browser")
    let g:fiddle_browser = "Google Chrome"
endif
if !exists("g:fiddle_auto_save")
    let g:fiddle_auto_save = 1
endif
function! CompileTemplates()
    :silent !sass main.scss main.css
endfunction
function! OpenOrRefreshBrowser()
    if g:fiddle_auto_save
        :w
    endif
    call CompileTemplates()
    if !exists("w:opened")
        let w:opened = 1
        :silent !open `cat /tmp/fiddle.addr`
    else
        let s:command = "silent !osascript -e 'tell application \"" . g:fiddle_browser . "\" to activate' -e 'tell application \"System Events\" to keystroke \"r\" using command down'"
        :exec(s:command)
    endif
endfunction
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 main.scss
badd +0 index.html
badd +0 main.js
silent! argdel *
edit index.html
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
wincmd =
argglobal
let s:l = 1 - ((0 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit main.js
let s:l = 1 - ((0 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
argglobal
edit main.scss
let s:l = 1 - ((0 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
wincmd =
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
nmap <Leader>r :call OpenOrRefreshBrowser()<cr>
" vim: set ft=vim :
