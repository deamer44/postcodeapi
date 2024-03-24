# Stage 1: Build environment
FROM golang:alpine AS builder

# Set working directory
WORKDIR /

# Copy go.mod and go.sum files (assuming you use Go Modules)
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy your Go source code
COPY main.go go.sum ./

# Build the Go binary (replace "my-library" with your library name)
RUN CGO_ENABLED=0 go build -o app

# Stage 2: Final image
FROM scratch

# Copy the Go binary
COPY --from=builder /app .

# Set the entrypoint
ENTRYPOINT ["./app"]