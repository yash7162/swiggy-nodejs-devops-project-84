
# # Use Node.js based on Debian Slim as the base image
# FROM node:16-slim

# # Create and set the working directory inside the container
# WORKDIR /app

# # Copy the entire codebase to the working directory
# COPY . .

# # Install dependencies
# RUN npm install

# # Expose the port your app runs on
# EXPOSE 3000

# # Define the command to start your application
# CMD ["npm", "start"]


FROM node:16-slim

WORKDIR /app

# Ensure dirs are writable by any UID (OpenShift random UID runs in group 0)
RUN mkdir -p /app /.npm /tmp/.npm \
    && chgrp -R 0 /app /.npm /tmp \
    && chmod -R g+rwX /app /.npm /tmp

COPY package*.json ./
RUN npm install --legacy-peer-deps

COPY . .

EXPOSE 3000

CMD ["npm", "start"]


