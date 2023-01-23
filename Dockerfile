FROM python:3.9-buster as builder

WORKDIR /app

RUN mkdir -p /app/out

COPY requirements.txt /app/requirements.txt

RUN apt-get update && \
    apt-get install -y git graphviz graphviz-dev

RUN git clone https://github.com/radare/radare2.git && \
    cd radare2 && ./sys/install.sh && cd ..

RUN pip install -U pip && \
    pip install -r /app/requirements.txt

COPY . /app/

# FROM python:3.9-slim-buster as prod

# WORKDIR /app

# COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages/
# COPY --from=builder . /app/

