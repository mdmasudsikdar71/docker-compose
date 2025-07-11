# Use the official Golang image
FROM golang:1.22-alpine

# Set maintainer information
LABEL maintainer="MD Masud Sikdar <masudsikdar85@gmail.com>"

# Install necessary packages
RUN apk add --no-cache git curl

# Install air for hot reload
RUN curl -sSfL https://raw.githubusercontent.com/cosmtrek/air/master/install.sh | sh -s -- -b /usr/local/bin

# Set the working directory
WORKDIR /var/www/html

# Copy go.mod and go.sum first for better caching
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application
COPY . .

# Default command (hot-reload server)
CMD ["air"]
