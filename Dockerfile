## Dockerfile for Jetson Stats Node Exporter
# sources: https://rnext.it/jetson_stats/docker.html
#          https://github.com/laminair/jetson_stats_node_exporter
# Usage: See git hub documentation

# Base image, Python image
FROM python:3.10-slim

# Set environment variables (prevents writing .pyc files and buffering of stdout and stderr)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies (including gcc and python3-dev and curl-->for docker-healthcheck) and clean up to reduce image size
RUN apt-get update && apt-get install -y gcc python3-dev curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# THIS EXPORTER assumes jetson-stats==4.3.2 on host device ensure its installed via sudo pip3 install -U jetson-stats==4.3.2

WORKDIR /app
COPY . .
# Install Python requirements.txt no venv
RUN pip3 install --no-cache-dir -r requirements.txt
CMD ["python3","-m","jetson_stats_node_exporter"]
