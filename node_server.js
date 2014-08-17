#!/usr/bin/env node

var server = require('http').createServer(httpHandler),
    spawn = require('child_process').spawn,
    exec = require('child_process').exec,
    io = require('socket.io').listen(server),
    url = require('url'),
    send = require('send'),
    server,
    socket;

server.listen(8090);

function httpHandler(req, res) {
    switch(req.method){
        case 'GET':
            console.log("get");
            console.log(__dirname);
            path = url.parse(req.url).pathname;
            // nodejs automatically servers index.html
            if (path !== null){
                send(req, path, {root: __dirname})
                    .pipe(res);
            }
            res.end();
            return;
        case 'POST':
            console.log("post req");
            io.emit('reload', 'reload');
            res.write('ok');
            res.end();
            return;
    }
}

io.on('connection', function(socket) {
    console.log("user connected");
});

