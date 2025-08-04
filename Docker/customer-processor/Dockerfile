# ───── base image ─────
FROM python:3.10-slim

# ───── create non-root user ─────
RUN useradd -u 1001 -m appuser

# ───── setup ─────
WORKDIR /app
COPY requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# ───── permissions and port ─────
USER 1001
EXPOSE 5000

CMD ["python", "app.py"]
