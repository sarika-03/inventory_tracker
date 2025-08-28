FROM python:3.12-slim as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt


FROM python:3.12-slim 
WORKDIR /app
COPY --from=builder /app /usr/local
EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]