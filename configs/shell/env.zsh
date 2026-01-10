# =========================================
# System Paths
# =========================================
export DOCKER_BACKUP_DIR="${DOCKER_BACKUP_DIR_ENV}"
export MAC_NEW_STARTER_DIR="${MAC_NEW_STARTER_DIR_ENV}"

# =========================================
# AI Providers
# =========================================
export OPENAI_API_KEY="${OPENAI_API_KEY_ENV}"

# =========================================
# Open WebUI (Docker compose)
# =========================================
export OPEN_WEBUI_PORT="${OPEN_WEBUI_PORT_ENV}"
export OPEN_WEBUI_CONFIG_PATH="${OPEN_WEBUI_CONFIG_PATH_ENV}"

# =========================================
# Media stack (Docker compose)
# =========================================

# Global
export TZ="${TZ_ENV}"

# Shared media paths
export MEDIA_DOWNLOADS_PATH="${MEDIA_DOWNLOADS_PATH_ENV}"
export MEDIA_TV_PATH="${MEDIA_TV_PATH_ENV}"
export MEDIA_MOVIES_PATH="${MEDIA_MOVIES_PATH_ENV}"

# qBittorrent
export QBIT_PUID="${QBIT_PUID_ENV}"
export QBIT_PGID="${QBIT_PGID_ENV}"
export QBIT_WEBUI_PORT="${QBIT_WEBUI_PORT_ENV}"
export QBIT_TORRENT_PORT="${QBIT_TORRENT_PORT_ENV}"
export QBIT_CONFIG_PATH="${QBIT_CONFIG_PATH_ENV}"

# Sonarr
export SONARR_PUID="${SONARR_PUID_ENV}"
export SONARR_PGID="${SONARR_PGID_ENV}"
export SONARR_PORT="${SONARR_PORT_ENV}"
export SONARR_CONFIG_PATH="${SONARR_CONFIG_PATH_ENV}"

# Radarr
export RADARR_PUID="${RADARR_PUID_ENV}"
export RADARR_PGID="${RADARR_PGID_ENV}"
export RADARR_PORT="${RADARR_PORT_ENV}"
export RADARR_CONFIG_PATH="${RADARR_CONFIG_PATH_ENV}"

# Prowlarr
export PROWLARR_PUID="${PROWLARR_PUID_ENV}"
export PROWLARR_PGID="${PROWLARR_PGID_ENV}"
export PROWLARR_PORT="${PROWLARR_PORT_ENV}"
export PROWLARR_CONFIG_PATH="${PROWLARR_CONFIG_PATH_ENV}"

# Byparr
export BYPARR_PORT="${BYPARR_PORT_ENV}"
