# import necessary libraries
from flask import Flask, render_template
import pandas as pd
from pandas import DataFrame, read_csv;

# create instance of Flask app
app = Flask(__name__)

# create route that renders index.html template
@app.route("/")
def index():
    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)

@app.route("/")
def page():
    return render_template("data_analysis.html")

if __name__ == "__main__":
    app.run(debug=True)

@app.route("/")
def page():
    return render_template("neural_network.html")

if __name__ == "__main__":
    app.run(debug=True)

@app.route("/")
def page():
    return render_template("random_forest.html")

if __name__ == "__main__":
    app.run(debug=True)

@app.route("/")
def page():
    return render_template("neural_network_code.html")

if __name__ == "__main__":
    app.run(debug=True)

@app.route("/")
def page():
    return render_template("random_forest_code.html")

if __name__ == "__main__":
    app.run(debug=True)

@app.route("/")
def page():
    return render_template("model_comparison.html")

if __name__ == "__main__":
    app.run(debug=True)

@app.route("/")
def page():
    return render_template("about_us.html")

if __name__ == "__main__":
    app.run(debug=True)That's 