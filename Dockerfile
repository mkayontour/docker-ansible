FROM python:3.7-alpine

COPY requirements.txt ./

RUN apk add --update --no-cache \
    openssh-client \
    rsync \
    musl-dev \
    libffi-dev \
    openssl-dev \
    git \
    cargo \
    vault \
    libcap
    
RUN setcap cap_ipc_lock= /usr/sbin/vault

RUN apk add --update --no-cache \
    --virtual .build-deps \
    make \
    gcc \
    python3-dev \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt \
    && apk del .build-deps

CMD ['ansible']
