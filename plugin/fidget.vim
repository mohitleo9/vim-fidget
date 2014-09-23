if (exists("g:vim_fidget_loaded") && g:vim_fidget_loaded)
  finish
endif
let g:vim_fidget_loaded = 1
" # Configuration

function! s:reloadCss()
    call system("curl -d 'action=cssReload&name=main.css' http://localhost:8092/ &>/dev/null &")
endfu


function! s:reload()
    call system("curl -d 'action=reload' http://localhost:8092/ &>/dev/null &")
endfu

function! s:startDaemon()
    let s:path = expand('<sfile>:p:h')
    let s:fidget_path = s:path.'/fidget.sh'
    silent call system(s:fidget_path)
    " This is necessary for stuff to take place :)
    exe 'sleep 1'
    let g:fidget_files_path = system("curl -s localhost:8092")
endfu

function! s:killDaemon()
    call system("curl -s -X DELETE http://localhost:8092/ &>/dev/null")
endfu


function! s:openBrowser()
    call system("curl -s -X PUT http://localhost:8092/index.html &>/dev/null &")
endfu

function! s:createJsFiddle()
    call system("curl -s -X PUT http://localhost:8092/jsFiddle.html &>/dev/null &")
endfunction

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
        au BufWritePost *main.css call s:reloadCss()
        au BufWritePost *main.js call s:reload()
        au BufWritePost *index.html call s:reload()
        au BufDelete *index.html call s:cleanUp()
    aug END
    call s:openBrowser()
endfu

command! -nargs=0 VimFidget call s:start_vim_fidget()
command! -nargs=0 VimFidgetBrowse call s:createJsFiddle()
