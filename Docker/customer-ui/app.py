from flask import Flask, request, render_template
import os

app = Flask(__name__)

@app.route('/')
def form():
    return render_template('form.html')

@app.route('/submit', methods=['POST'])
def submit():
    name = request.form['name']
    email = request.form['email']

    import requests
    response = requests.post('http://customer-ingestion:5001/submit', json={'name': name, 'email': email})

    if response.status_code == 200:
        return render_template('success.html', name=name, email=email)
    else:
        return "Failed to submit", 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)  # Changed from 80 to 8080
