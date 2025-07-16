from flask import Flask, redirect, render_template, url_for

app = Flask(__name__)


@app.route("/<name>")
def home(name):
    return render_template("index.html", content=name)


if __name__ == "__main__":
    app.run(debug=True)
