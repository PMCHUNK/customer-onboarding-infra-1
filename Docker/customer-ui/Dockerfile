FROM python:3.9-slim

# Create non-root user
RUN adduser --disabled-password --gecos '' --uid 1001 appuser

WORKDIR /app
COPY . .

RUN pip install flask requests

# Set correct permissions
RUN chown -R 1001:1001 /app

# Switch to non-root user
USER 1001

CMD ["python", "app.py"]
