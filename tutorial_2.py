from flask import Flask, redirect, render_template, url_for

app = Flask(__name__)


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/new")
def new():
    return render_template("new.html")


@app.route("/pricing")
def pricing():
    return render_template("pricing.html")


if __name__ == "__main__":
    app.run(debug=True)
