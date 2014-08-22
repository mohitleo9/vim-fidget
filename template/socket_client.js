(function(){

    var socket = new io();

    socket.on('reload', function(msg){
        location.reload();
    });

    socket.on('die', function(msg) {
        window.open('', '_self', '');
        window.close();

        var firefoxWarning =
        "<h1>Oops!</h1>" +
        "<h3>Firefox doesn't allow windows to self-close.</h3>" +
        "<h3>If you want the preview window to close automatically like in other browsers, go to about:config and set dom.allow_scripts_to_close_windows to true.</h3>"
        document.body.innerHTML = firefoxWarning;
    });
    socket.on('cssReload', function(msg){
        cssLinks = document.getElementsByTagName('link');

        for(var i=0; i < cssLinks.length; i++ ){
            if(cssLinks[i].rel=='stylesheet' && cssLinks[i].href.indexOf(msg) > -1){
                d = new Date();
                // https://groups.google.com/forum/#!topic/mimosajs/A7Kbf6plBd0
                if (typeof window.chrome != 'undefined'){
                    // break the url to force update in chrome
                    console.log("chrome");
                    // cssLinks[i].href = '#asdf';
                }
                cssLinks[i].href = cssLinks[i].href.replace(/\?.*|$/,'?v= '+ d.getTime() )
            }
        }
    });

 })();
