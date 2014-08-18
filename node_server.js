#!/usr/bin/env node

var server = require('http').createServer(httpHandler),
    spawn = require('child_process').spawn,
    exec = require('child_process').exec,
    io = require('socket.io').listen(server),
    querystring = require('querystring'),
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
            console.log(path);
            // nodejs automatically servers index.html
            if (path === null) { path = 'index.html';  }
            send(req, path, {root: __dirname})
                .pipe(res);
            return;
        case 'POST':
            var postData = '';
            req.on('data', function(chunck) {
                postData += chunck.toString();
            });
            req.on('end', function () {
                postData = querystring.parse(postData);
                console.log("post req");

                if(postData.action === 'cssReload'){
                    console.log(postData.name);
                    io.emit('cssReload', postData.name);
                }

                if(postData.action === 'reload'){
                    console.log(postData.name);
                    io.emit('reload', 'reload');
                }
            });

            res.write('ok');
            res.end();
            return;

        case 'PUT':
            spawn('open', ['http://localhost:8090/index.html']);
            res.write('ok');
            res.end();
            return;

        case 'DELETE':
            process.exit(1);
            return;
    }
}

io.on('connection', function(socket) {
    console.log("user connected");
});

