#Create a simple API server on port 8090
#Endpoints /counter that accespts a post request with a body object containing a key called "counter" and a value of 1 or more

from flask import Flask
from flask import request
import json

app = Flask(__name__)

counter = 0

@app.route('/counter/', methods=['POST'])
def counter():
    global counter
    if request.method == 'POST':
        #Print the cookies
        print(request.cookies['counter'])
        return json.dumps({'success':True}), 200, {'ContentType':'application/json'}
    else:
        print(request.cookies)
if __name__ == '__main__':
    app.run(host='10.0.0.147', port=8090)
    
