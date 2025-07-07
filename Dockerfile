# Use official nginx image as base
FROM nginx:alpine

# Copy custom index.html to nginx default html directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
