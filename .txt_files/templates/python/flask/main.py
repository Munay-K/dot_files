from flask import Flask, render_template

# !1| Global variables for program operation !1|

app = Flask(__name__)

# !1| URL handlers !1|

@app.route('/')
def index():
    return render_template('index.html')

# !1| Server startup !1|

if __name__ == "__main__":
    app.run(
           debug = True,       #Activates the debugger and the reloade (useful during development.)
           threaded=True,      #Enables threaded mode which is already defined by default.
           host=('0.0.0.0'),   #Defines the host to launch the current web application
           port=5550           #Defines the port to launch the current web application
          )
