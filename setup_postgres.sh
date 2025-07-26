#!/usr/bin/env bash

# Exit on error, undefined variables, and pipe failures
set -euo pipefail
IFS=$'\n\t'

# Number of retries for Docker operations
MAX_RETRIES=3
RETRY_DELAY=5

###################
# Configuration   #
###################

# Container settings
DB_CONTAINER_NAME="${DB_CONTAINER_NAME:-postgres_container}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-appdb}"
DB_USER="${DB_USER:-appuser}"
DB_PASSWORD="${DB_PASSWORD:-securepass}"  # Should be overridden via environment variable
DB_VERSION="${DB_VERSION:-15}"

# Volume settings
USE_VOLUME="${USE_VOLUME:-true}"
DB_VOLUME="${DB_VOLUME:-pgdata}"

###################
# Helper Functions#
###################

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

error() {
    log "ERROR: $1" >&2
    exit 1
}

check_requirements() {
    log "Checking system requirements..."
    
    # Check Docker installation
    if ! command -v docker &> /dev/null; then
        error "Docker is not installed. Please install Docker first."
    fi
    
    # Check Docker daemon
    if ! docker info &> /dev/null; then
        error "Docker daemon is not running. Please start Docker first."
    fi
    
    # Check Docker network connectivity
    if ! docker pull hello-world &> /dev/null; then
        error "Docker cannot connect to registry. Please check your network connection."
    fi
}

check_port() {
    log "Checking port availability..."
    if lsof -Pi :"$DB_PORT" -sTCP:LISTEN -t &> /dev/null; then
        error "Port $DB_PORT is already in use. Please specify a different port."
    fi
}

prepare_volume() {
    if [ "$USE_VOLUME" = true ]; then
        log "Checking volume '$DB_VOLUME'..."
        if ! docker volume inspect "$DB_VOLUME" &> /dev/null; then
            log "Creating volume '$DB_VOLUME'..."
            docker volume create "$DB_VOLUME"
        fi
    fi
}

retry_command() {
    local cmd="$1"
    local retries=0
    
    while [ $retries -lt $MAX_RETRIES ]; do
        if eval "$cmd"; then
            return 0
        fi
        retries=$((retries + 1))
        log "Command failed, attempt $retries of $MAX_RETRIES. Retrying in $RETRY_DELAY seconds..."
        sleep $RETRY_DELAY
    done
    
    error "Command '$cmd' failed after $MAX_RETRIES attempts"
}

check_container_exists() {
    if docker container ls -a --format '{{.Names}}' | grep -q "^${DB_CONTAINER_NAME}$"; then
        log "Warning: Container '$DB_CONTAINER_NAME' already exists."
        read -p "Do you want to remove it and create a new one? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            error "Aborted by user."
        fi
        log "Removing existing container..."
        retry_command "docker rm -f $DB_CONTAINER_NAME"
    fi
}

###################
# Main Script     #
###################

check_container_health() {
    local timeout=30
    local counter=0
    log "Waiting for container to be healthy (timeout: ${timeout}s)..."
    
    while [ $counter -lt $timeout ]; do
        if docker logs "$DB_CONTAINER_NAME" 2>&1 | grep -q "database system is ready to accept connections"; then
            log "Container is healthy!"
            return 0
        fi
        counter=$((counter + 1))
        sleep 1
    done
    
    error "Container failed to become healthy within ${timeout} seconds"
}

main() {
    log "Starting PostgreSQL container setup..."
    
    # Check prerequisites
    check_requirements
    check_port
    check_container_exists
    
    # Prepare volume if needed
    prepare_volume
    
    # Pull the latest PostgreSQL image
    log "Pulling PostgreSQL $DB_VERSION image..."
    retry_command "docker pull postgres:${DB_VERSION}"
    
    # Prepare volume arguments if enabled
    volume_args=""
    if [ "$USE_VOLUME" = true ]; then
        volume_args="-v ${DB_VOLUME}:/var/lib/postgresql/data"
    fi
    
    # Create and start the container
    log "Creating PostgreSQL container..."
    retry_command "docker run -d \\
        --name \"$DB_CONTAINER_NAME\" \\
        -e POSTGRES_DB=\"$DB_NAME\" \\
        -e POSTGRES_USER=\"$DB_USER\" \\
        -e POSTGRES_PASSWORD=\"$DB_PASSWORD\" \\
        -p \"$DB_PORT:5432\" \\
        $volume_args \\
        --restart unless-stopped \\
        postgres:${DB_VERSION}"
    
    # Verify container is running and healthy
    log "Verifying container status..."
    if ! docker ps --format '{{.Names}}' | grep -q "^${DB_CONTAINER_NAME}$"; then
        error "Container failed to start. Check docker logs for details."
    fi
    
    check_container_health
    
    log "PostgreSQL container '$DB_CONTAINER_NAME' is now running!"
    log "Connection details:"
    log "  Host: localhost"
    log "  Port: $DB_PORT"
    log "  Database: $DB_NAME"
    log "  User: $DB_USER"
    log "  Password: [Set via DB_PASSWORD]"
    
    if [ "$USE_VOLUME" = true ]; then
        log "Data is being persisted in volume: $DB_VOLUME"
    else
        log "Warning: No persistent volume configured. Data will be lost when container is removed."
    fi
}

main "$@"
