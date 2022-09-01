FROM rust:1.62.0-alpine AS develop

RUN adduser -D rustuser \
    && apk add --no-cache su-exec shadow gcc musl-dev

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]


FROM rust:1.62.0-alpine AS builder

RUN apk add --no-cache gcc musl-dev
WORKDIR /work
COPY . .
RUN cargo build --release


FROM scratch AS production

COPY --from=builder /work/target/release/hello-world /usr/local/
ENTRYPOINT [ "/usr/local/hello-world" ]
