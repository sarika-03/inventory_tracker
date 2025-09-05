FROM python:3.12-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip 
RUN pip install --prefix=/install -r requirements.txt



FROM python:3.12-slim 
WORKDIR /app
COPY --from=builder /app /usr/local
EXPOSE 8000
CMD ["uvicorn", "app.main:app"]