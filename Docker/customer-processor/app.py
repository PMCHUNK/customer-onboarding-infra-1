from flask import Flask, request, jsonify
import psycopg2, os

app = Flask(__name__)

# ──────────────────────────
# config values from secrets
# ──────────────────────────
DB_HOST = os.environ.get("DB_HOST", "your-db-host")
DB_NAME = os.environ.get("DB_NAME", "your-db-name")
DB_USER = os.environ.get("DB_USER", "your-db-user")
DB_PASS = os.environ.get("DB_PASSWORD", "your-db-password")


print("🔧 Loaded DB Configuration:")
print(f"🔹 DB_HOST: {DB_HOST}")
print(f"🔹 DB_NAME: {DB_NAME}")
print(f"🔹 DB_USER: {DB_USER}")
print(f"🔹 DB_PASS: {DB_PASS}")  # NOTE: Do not log passwords in production

# ──────────────────────────
# health endpoint for probes
# ──────────────────────────
@app.route('/healthz', methods=['GET'])
def heathz():
    return jsonify({"status": "ok"}), 200

# main API
@app.route('/process', methods=['POST'])
def process():
    data = request.json or {}
    name  = data.get('name')
    email = data.get('email')

    try:
        conn = psycopg2.connect(
                 host=DB_HOST,
                 dbname=DB_NAME,
                 user=DB_USER,
                 password=DB_PASS,
                 sslmode='require'  # This line is important!
)
        cur = conn.cursor()
        cur.execute("CREATE TABLE IF NOT EXISTS customers (name TEXT, email TEXT);")
        cur.execute("INSERT INTO customers (name, email) VALUES (%s, %s);", (name, email))
        conn.commit()
        cur.close()
        conn.close()
        return jsonify({'message': 'Data saved to DB'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    # ▶ run on port 5000 to match K8s probes
    app.run(host='0.0.0.0', port=5000)
