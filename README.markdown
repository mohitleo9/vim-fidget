# vim-fidget - JsFiddle for Vim
## What??
This is a plugin (with a very creative name!) that emulates JsFiddle in vim and lets you post it to actual jsfiddle.com so that it can be shared.

##Why??
I am a web developer and the whole concept of trying out small chunks of programs makes JsFiddle really cool **BUT...**

**WHERE IS MY VIM....?** this plugin answers that

installation instructions:
git clone the repo and run npm install -g
the source the fidget.vim file by :so %

or

    NeoBundle 'mohitleo9/vim-fiddle',{
            \ 'build' : {
            \    'unix' : 'npm install -g',
            \    'mac' : 'npm install -g',
            \ },
      \}


it adds two commands 
VimFidget : create a fidget 
VimFidgetBrowse : upload the fidget to jsfiddle
