from flask import Flask, request, jsonify
import requests
import os
import traceback  # 🔍 For detailed error logs

app = Flask(__name__)

# Use service DNS name from Kubernetes
PROCESSOR_URL = os.getenv("PROCESSOR_URL", "http://customer-processor:5000/process")

@app.route('/submit', methods=['POST'])
def forward_request():
    try:
        data = request.get_json()
        print(f"📨 Received data: {data}")  # Log incoming payload

        if not data.get('name') or not data.get('email'):
            return jsonify({"error": "Name and email required"}), 400

        print(f"➡️ Forwarding to processor at {PROCESSOR_URL}...")

        response = requests.post(PROCESSOR_URL, json=data, timeout=5)  # timeout added

        print(f"✅ Processor response code: {response.status_code}")
        print(f"📦 Processor response body: {response.text}")

        return jsonify({
            "message": "Forwarded to processor",
            "processor_response": response.json()
        }), response.status_code

    except Exception as e:
        print("❌ Exception during forwarding:")
        traceback.print_exc()  # Full stack trace in logs
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
