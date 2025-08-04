FROM python:3.9-slim

# Create non-root user
RUN useradd -u 1001 appuser

WORKDIR /app
COPY . .

RUN pip install flask requests

# Change ownership of app files
RUN chown -R appuser:appuser /app

USER 1001

CMD ["python", "app.py"]
