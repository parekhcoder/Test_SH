# Example Dockerfile
FROM ubuntu:22.04

# Copy your script
COPY resources/testlog.sh /app/testlog.sh
RUN chmod +x /app/testlog.sh

# Set entrypoint
CMD ["/app/testlog.sh"]
