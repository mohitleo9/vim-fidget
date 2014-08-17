(function(){

    var socket = new io();

    // socket.on.apply(this, action_dictionary_function);
    socket.on('reload', function(msg){
        location.reload();
        alert(msg);
    });
 })();
