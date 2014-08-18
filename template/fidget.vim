
" # Configuration
if !exists('g:fidget_slow')
    let g:fidget_slow = 0
endif

if !exists('g:fidget_slow')
    let g:fidget_slow = 1
endif


function! s:reloadCss()
    echom 'calling'
    call system("curl -d 'action=cssReload&name=template/main.css' http://localhost:8090/ &>/dev/null &")
endfu


function! s:reload()
    echom 'calling'
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
  au! instant-markdown * <buffer>
endfu

let fidget_autostart = 1

if g:fidget_autostart
    " # Define the autocmds "
    aug fidget-start_commands
        au! * <buffer>
        au BufEnter,BufWritePost *main.css call s:reloadCss()
        au BufEnter,BufWritePost *main.js call s:reload()
        au BufEnter,BufWritePost *index.html call s:reload()
    aug END
else
    echom 'asdf'
endif
