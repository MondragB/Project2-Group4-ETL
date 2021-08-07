from flask import Flask

app = Flask(__name__)


@app.route("/text")
def home():
    return "Hello World"


@app.route("/html")
def normal():
    return "<h1>Hello World</h1>"

if __name__ == "__main__":
    app.run(debug=True)
