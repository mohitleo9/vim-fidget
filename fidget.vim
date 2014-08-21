
" # Configuration
if !exists('g:fidget_slow')
    let g:fidget_slow = 0
endif


if !exists('g:fidget_autostart')
    let g:fidget_autostart = 0
endif

if !exists('g:fidget_slow')
    let g:fidget_slow = 1
endif


function! s:reloadCss()
    call system("curl -d 'action=cssReload&name=template/main.css' http://localhost:8090/ &>/dev/null &")
endfu


function! s:reload()
    call system("curl -d 'action=reload' http://localhost:8090/ &>/dev/null &")
endfu

function! s:startDaemon()
    silent call system("vim-fidget")
    exe 'sleep 1'
    let g:fidget_files_path = system("curl -s localhost:8090")
endfu

function! s:killDaemon()
    call system("curl -s -X DELETE http://localhost:8090/ &>/dev/null &")
endfu


function! s:openBrowser()
    call system("curl -s -X PUT http://localhost:8090/ &>/dev/null &")
endfu



fu! s:cleanUp()
  call s:killDaemon()
  au! fidget-start_commands *
endfu


fu! s:start_vim_fidget()
    " load the files
    call s:startDaemon()
    tabnew
    exe 'e '.g:fidget_files_path.'/index.html'
    exe 'split '.g:fidget_files_path.'/main.js'
    exe 'vsplit '.g:fidget_files_path.'/main.css'
    " # Define the autocmds "
    aug fidget-start_commands
        au!
        au BufEnter,BufWritePost *main.css call s:reloadCss()
        au BufEnter,BufWritePost *main.js call s:reload()
        au BufEnter,BufWritePost *index.html call s:reload()
    aug END
    call s:openBrowser()
endfu

if g:fidget_autostart
    call s:start_vim_fidget()
else
    echo 'asdf'
endif

command! -nargs=0 VimFidget call s:start_vim_fidget()
