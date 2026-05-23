FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/ShahabSL/Skirk/main/install.sh | sh

ENV PATH="/root/.local/bin:$PATH"

RUN mkdir -p /app

CMD sh -c 'echo "$EXIT_JSON" > /app/exit.json && skirk serve-exit --config /app/exit.json'
