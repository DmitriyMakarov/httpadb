#!/usr/bin/env python
import subprocess
from bottle import route, request, run, template # $ pip install bottle

opt = None

@route('/')
def index():
    global opt
    opt = request.query.opt or opt
    if opt=="1":
        subprocess.call("./recon.sh")
    return template('<b>Option: {{opt}}</b>',
                    opt=opt)
    


run(host='localhost', port=8000)
