#!/opt/homebrew/bin/bash

source "$(dirname "$0")/../utils/helpers.sh"

if ! check_bash_version; then
    exit 0
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DOCKER_DIR="$PROJECT_ROOT/docker"
BACKUP_DIR="$DOCKER_BACKUP_DIR/"

# Restarts docker service
restart_docker_compose() {
    local docker_compose="$1"

    # Restart docker service
    if ! cd "$docker_compose" || ! docker compose up -d; then
        log_error "Failed to restart Docker service: $docker_compose"
        return 1
    else
        log_success "Docker service restarted successfully: $docker_compose"
    fi
}

# Docker compose volumes backup script
docker_backup() {
    # Check the BACKUP_DIR env variable exists
    if [[ -z "${DOCKER_BACKUP_DIR:-}" ]]; then
        log_error "DOCKER_BACKUP_DIR environment variable is not set."
        return 1 # Exit function if env variable is not set
    fi

    # Check if backup directory exists, back out if not
    if ! [[ -d "$BACKUP_DIR" ]]; then
        log_error "$BACKUP_DIR doesn't exist."
        return 1 # Exit function if backup dir doesnt exist
    fi

    # Iterate docker folders in docker/
    for docker_compose in "$DOCKER_DIR"/*; do
        local name="$(basename "$docker_compose")"
        local docker_compose_volume_dir="$docker_compose/volumes/"
        local timestamped_docker_backup="$BACKUP_DIR/$name/backup_$(date +%Y%m%d%H%M%S)/"

        # Stop container from running via docker compose down on docker-compose.yml file
        if ! cd "$docker_compose" || ! docker compose down; then
            log_error "Failed to stop Docker container: $docker_compose"
            continue # Move onto next docker compose
        else
            log_info "Docker container stopped: $docker_compose"
        fi
        
        # Check if the docker volumes/ directory exists
        if ! [[ -d "$docker_compose_volume_dir" ]]; then
            log_error "No docker volumes exist "
            continue # Move onto next docker compose
        fi

        # Create timestamped folder backup_$(date +%Y%m%d%H%M%S)/
        if ! mkdir -p "$timestamped_docker_backup"; then
            log_error "Failed to create backup directory."
            restart_docker_compose "$docker_compose"
            return 1 # Exit out of for function
        else
            log_info "Created backup folder: $timestamped_docker_backup"
        fi

        # Create backup files
        if ! cp -a "$docker_compose_volume_dir" "$timestamped_docker_backup"; then # -a copy all files and directories recursively and maintains permissions
            log_error "Failed to create backup."
            restart_docker_compose "$docker_compose"
            return 1 # Exit out of for function
        fi

        restart_docker_compose "$docker_compose"
    done
}

main() {
    # Confirm docker compose volume backup
    if ! confirm_action "backing up docker compose volumes inside MacNewStarter (this will restart currently running containers)."; then
        exit 0
    fi

    log_info "Backing up docker compose volumes..."

    if docker_backup; then
        log_success "🎉 Docker files backed up successfully!"
        log_info "Volumes backed up in: $BACKUP_DIR"
    else
        log_error "Failed to backup docker compose volumes."
    fi
}

main "$@"