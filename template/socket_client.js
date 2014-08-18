(function(){

    var socket = new io();

    socket.on('reload', function(msg){
        location.reload();
    });

    socket.on('cssReload', function(msg){
        cssLinks = document.getElementsByTagName('link');

        for(var i=0; i < cssLinks.length; i++ ){
            if(cssLinks[i].rel=='stylesheet' && cssLinks[i].href.indexOf(msg) > -1){
                d = new Date();
                cssLinks[i].href = cssLinks[i].href.replace(/\?.*|$/,'?v= '+ d.getTime() )
            }
        }
    });

 })();
