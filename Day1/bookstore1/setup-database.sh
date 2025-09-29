#!/bin/bash

echo "🚀 Setting up PostgreSQL database for Bookstore..."

# Stop any existing containers
echo "📦 Stopping any existing containers..."
docker-compose down

# Remove any existing volumes to start fresh
echo "🗑️  Removing existing volumes..."
docker volume rm bookstore1_postgres_data 2>/dev/null || true

# Start the PostgreSQL container
echo "🐘 Starting PostgreSQL container..."
docker-compose up -d

# Wait for PostgreSQL to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
until docker-compose exec postgres pg_isready -U bookstore_user -d bookstore; do
    echo "Waiting for PostgreSQL..."
    sleep 2
done

echo "✅ PostgreSQL is ready!"

# Display connection information
echo ""
echo "🎉 Database setup complete!"
echo ""
echo "📋 Connection Details:"
echo "   Host: localhost"
echo "   Port: 5432"
echo "   Database: bookstore"
echo "   Username: bookstore_user"
echo "   Password: bookstore_password"
echo ""
echo "🔗 JDBC Connection String:"
echo "   jdbc:postgresql://localhost:5432/bookstore?user=bookstore_user&password=bookstore_password"
echo ""
echo "📊 To verify the setup, you can run:"
echo "   docker-compose exec postgres psql -U bookstore_user -d bookstore -c \"SELECT COUNT(*) FROM books;\""
echo ""
echo "🛑 To stop the database:"
echo "   docker-compose down"
echo ""
echo "🔄 To restart the database:"
echo "   docker-compose up -d"