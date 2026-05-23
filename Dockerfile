FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl netcat-openbsd && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/ShahabSL/Skirk/main/install.sh | sh

ENV PATH="/root/.local/bin:$PATH"

RUN mkdir -p /app

CMD sh -c 'echo "$EXIT_JSON" > /app/exit.json && \
  while true; do echo -e "HTTP/1.1 200 OK\r\nContent-Length: 2\r\n\r\nOK" | nc -l -p ${PORT:-10000} -q 1; done & \
  skirk serve-exit --config /app/exit.json' --start-exit=false
