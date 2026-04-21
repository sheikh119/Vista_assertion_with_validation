# Build from repository root. Needs CUDA-capable host + drivers for GPU;
# CPU-only installs may work for limited testing but are not guaranteed.
FROM python:3.11-bookworm

WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends \
    git build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
COPY web/backend/requirements.txt web/backend/

RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir -r web/backend/requirements.txt

COPY scripts ./scripts
COPY web/backend ./web/backend
COPY formal_verification ./formal_verification

WORKDIR /workspace/web/backend

EXPOSE 8000
ENV PYTHONUNBUFFERED=1

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
