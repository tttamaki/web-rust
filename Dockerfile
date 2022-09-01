FROM rust:1.62.0-alpine AS builder

RUN apk add --no-cache gcc musl-dev
WORKDIR /work
COPY . .
RUN cargo build --release


FROM scratch AS production

COPY --from=builder /work/target/release/hello-world /usr/local/
ENTRYPOINT [ "/usr/local/hello-world" ]
