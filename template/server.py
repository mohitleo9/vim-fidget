from bottle import run, get, static_file
import random
import os
import sys

@get('/static/:name#.+#')
def get_static(name):
    return static_file(name, root='.')

if __name__ == '__main__':
    if len(sys.argv) > 1:
        host, port = sys.argv[1].split(':')
    else:
        port = 8000 + random.randint(0, 1000)
        host='localhost'

    with open('/tmp/fiddle.addr', 'w') as f:
        f.write('http://%s:%s/static/index.html' % (host, port,))

    run(host=host, port=port, reloader=True)
