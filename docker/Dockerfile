FROM python:3.12-slim AS builder
WORKDIR /app

# Copy only requirements first (for caching)
COPY requirements.txt .

# Upgrade pip & install dependencies into /install
RUN pip install --upgrade pip
RUN pip install --prefix=/install -r requirements.txt

# Copy app source code
COPY . .

# Final image
FROM python:3.12-slim
WORKDIR /app

# Copy installed packages
COPY --from=builder /install /usr/local

# Copy app source code
COPY --from=builder /app /app

EXPOSE 8000
CMD ["uvicorn", "app.main:app"]
