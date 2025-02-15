#!/bin/bash

# Function to check database connectivity
check_db_connectivity() {
  docker exec -it my_database pg_isready -U user
}

# Validate database connectivity
if check_db_connectivity; then
  echo "Database connectivity validated successfully."
else
  echo "Failed to validate database connectivity."
  exit 1
fi
