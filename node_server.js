#!/usr/bin/env node

var server = require('http').createServer(httpHandler),
    spawn = require('child_process').spawn,
    fs = require('fs'),
    exec = require('child_process').exec,
    io = require('socket.io').listen(server),
    querystring = require('querystring'),
    url = require('url'),
    send = require('send'),
    server,
    socket;

server.listen(8092);
var assetsLocation = process.argv[2];

function httpHandler(req, res) {
    switch(req.method){
        case 'GET':
            path = url.parse(req.url).pathname;
            if (path.indexOf('read/') > -1){
                // this means stream the contents of the file
                fileName = path.substring(path.indexOf('read/') + 'read/'.length);
                buf = fs.readFileSync(assetsLocation + "/" + fileName);
                res.write(buf.toString());
                res.end();
                return;
            }
            // nodejs automatically provide the current assetsLocation path
            if (path === null || path === '/') {
                res.write(assetsLocation);
                res.end();
                return;
            }
            send(req, path, {root: assetsLocation})
                .pipe(res);
            return;
        case 'POST':
            var postData = '';
            req.on('data', function(chunck) {
                postData += chunck.toString();
            });
            req.on('end', function () {
                postData = querystring.parse(postData);

                if(postData.action === 'cssReload'){
                    io.emit('cssReload', postData.name);
                }

                if(postData.action === 'reload'){
                    io.emit('reload', 'reload');
                }
            });

            res.write('ok');
            res.end();
            return;

        case 'PUT':
            if (process.platform.toLowerCase().indexOf('darwin') >= 0){
                spawn('open', ['http://localhost:8092' + req.url]);
            }
            else {  // assume unix/linux
                spawn('xdg-open', ['http://localhost:8092' + req.url]);
            }
            res.write('ok');
            res.end();
            return;

        case 'DELETE':
            io.emit('die', 'die');
            process.exit(1);
            return;

        case 'READ':
            return;
    }
}

io.on('connection', function(socket) {
    console.log("user connected");
});

