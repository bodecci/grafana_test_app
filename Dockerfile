FROM node:16-slim AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy your application files into the container
COPY . .

# Install application dependencies
RUN npm install

# Entrypoint script to require instrumentation.js and then run app.js
COPY instrumentation.js .
COPY app.js .

FROM alpine:latest
COPY --from=build /usr/src/app app

# Expose port 8080
EXPOSE 8080

# Run the entrypoint script
CMD ["sh", "-c", "node --require ./instrumentation.js app.js"]