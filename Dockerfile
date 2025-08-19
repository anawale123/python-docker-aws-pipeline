#STAGE 1: BUILD 
FROM python:3.8-slim AS build

WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libmariadb-dev \
    pkg-config

COPY . .

RUN pip install flask

#STAGE 2: PRODUCTION 
FROM python:3.8-slim

WORKDIR /app

COPY --from=build /app /app

EXPOSE 5001

CMD ["python", "app.py"]
