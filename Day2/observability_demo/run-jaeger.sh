#!/bin/bash

# Script to pull and run the latest Jaeger tracing container
# This script will pull the latest Jaeger all-in-one image and run it with proper configuration

set -e  # Exit on any error

echo "🚀 Starting Jaeger Tracing Setup..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker and try again."
    exit 1
fi

print_status "Docker is running ✓"

# Stop and remove existing Jaeger container if it exists
if docker ps -a --format "table {{.Names}}" | grep -q "jaeger"; then
    print_warning "Found existing Jaeger container. Stopping and removing it..."
    docker stop jaeger 2>/dev/null || true
    docker rm jaeger 2>/dev/null || true
fi

# Pull the latest Jaeger all-in-one image
print_status "Pulling latest Jaeger all-in-one image..."
docker pull jaegertracing/all-in-one:latest

print_success "Jaeger image pulled successfully ✓"

# Create a directory for Jaeger data persistence (optional)
mkdir -p ./jaeger-data

# Run Jaeger container
print_status "Starting Jaeger container..."

docker run -d \
    --name jaeger \
    -p 16686:16686 \
    -p 14268:14268 \
    -p 14250:14250 \
    -p 6831:6831/udp \
    -p 6832:6832/udp \
    -p 5778:5778 \
    -p 4317:4317 \
    -p 4318:4318 \
    -e COLLECTOR_OTLP_ENABLED=true \
    -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
    -p 9411:9411 \
    --restart unless-stopped \
    jaegertracing/all-in-one:latest

# Wait a moment for the container to start
sleep 3

# Check if container is running
if docker ps --format "table {{.Names}}" | grep -q "jaeger"; then
    print_success "Jaeger container started successfully! ✓"
    
    echo ""
    echo "🎉 Jaeger is now running with the following endpoints:"
    echo ""
    echo "📊 Jaeger UI:           http://localhost:16686"
    echo "📡 Jaeger Collector:   http://localhost:14268"
    echo "🔍 Zipkin Collector:   http://localhost:9411"
    echo "📨 OTLP gRPC:          http://localhost:4317"
    echo "📨 OTLP HTTP:          http://localhost:4318"
    echo ""
    echo "🔧 Agent endpoints:"
    echo "   UDP Thrift:         localhost:6831"
    echo "   UDP Binary:         localhost:6832"
    echo "   HTTP Thrift:        localhost:14268"
    echo "   Sampling:           http://localhost:5778"
    echo ""
    echo "💡 To view traces, open http://localhost:16686 in your browser"
    echo "🛑 To stop Jaeger:     docker stop jaeger"
    echo "🗑️  To remove Jaeger:   docker rm jaeger"
    
else
    print_error "Failed to start Jaeger container"
    echo "Container logs:"
    docker logs jaeger
    exit 1
fi

print_success "Setup complete! 🎯"