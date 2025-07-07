# Use the official Node.js 22 Alpine image as base
FROM node:22-alpine

# Set maintainer info
LABEL maintainer="MD Masud Sikdar <masudsikdar85@gmail.com>"

# Enable Corepack & install Yarn
RUN corepack enable && corepack prepare yarn@stable --activate

# Create and set working directory
WORKDIR /var/www/html

# Use non-root user for security (Node Alpine ships with one)
# NOTE: Alpine’s node image uses node:node (UID 1000)
USER node

# Default command — you can override in docker-compose
CMD ["sh"]
