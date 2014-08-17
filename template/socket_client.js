(function(){

    var socket = new io();

    socket.on('reload', function(msg){
        location.reload();
        alert(msg);
    });

    socket.on('cssReload', function(msg){
        cssLinks = document.getElementsByTagName('link');

        for(var i=0; i < cssLinks.length; i++ ){
            var link = links[i];
            if(link.rel=='stylesheet' && link.href.indexOf(msg) > -1){
                d = new Date();
                link.href.replace(/(\?.*)$/,'?asdf='+d.time());
            }
        }

    });

 })();
