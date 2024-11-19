#!/bin/bash
set -e

# Wait for Postgres to start
until pg_isready -h "$DB_HOST" -U "$DB_USERNAME"; do
  echo "Waiting for PostgreSQL to become available..."
  sleep 2
done

# Create databases if they do not exist
echo "Creating databases..."
psql -h "$DB_HOST" -U "$DB_USERNAME" -c "CREATE DATABASE IF NOT EXISTS simple_invoice;"
psql -h "$DB_HOST" -U "$DB_USERNAME" -c "CREATE DATABASE IF NOT EXISTS simple_invoice_test;"