FROM python:3.12-slim AS builder
WORKDIR /app

# Copy only requirements first (for caching)
COPY requirements.txt .

# Upgrade pip & install dependencies into /install
RUN pip install --upgrade pip
RUN pip install --prefix=/install -r requirements.txt

# Copy app source code
COPY . .

# Final stage
FROM python:3.12-slim
WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /install /usr/local

# Copy app code
COPY --from=builder /app /app

EXPOSE 8000

# ✅ Add host and port explicitly (important in containers)
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
