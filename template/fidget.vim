
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
    echom 'calling'
    call system("curl -d 'action=cssReload&name=template/main.css' http://localhost:8090/ &>/dev/null &")
endfu


function! s:reload()
    echo 'calling'
    call system("curl -d 'action=reload' http://localhost:8090/ &>/dev/null &")
endfu

function! s:startDaemon()
    call s:system("vim-fidget &>/dev/null &")
endfu

function! s:killDaemon()
    call system("curl -s -X DELETE http://localhost:8090/ &>/dev/null &")
endfu



fu! s:cleanUp()
  call s:killDaemon()
  au! fidget-start_commands *
endfu


if g:fidget_autostart
    " # Define the autocmds "
    aug fidget-start_commands
        au! * <buffer>
        au BufEnter,BufWritePost *main.css call s:reloadCss()
        au BufEnter,BufWritePost *main.js call s:reload()
        au BufEnter,BufWritePost *index.html call s:reload()
    aug END
else
    echo 'asdf'
endif
