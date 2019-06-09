from flask import Flask, render_template

# ------------------------------------------------------------
# _[1]_ Global variables for program operation
# ------------------------------------------------------------

app = Flask(__name__)

# ------------------------------------------------------------
# _[1]_ URL Handlers
# ------------------------------------------------------------

@app.route('/')
def index():
    return render_template('index.html')

# ------------------------------------------------------------
# _[1]_ Server startup
# ------------------------------------------------------------

if __name__ == "__main__":
    app.run(
           debug = True,       #Activates the debugger and the reloade (useful during development.)
           threaded=True,      #Enables threaded mode which is already defined by default.
           host=('0.0.0.0'),   #Defines the host to launch the current web application
           port=5550           #Defines the port to launch the current web application
          )
