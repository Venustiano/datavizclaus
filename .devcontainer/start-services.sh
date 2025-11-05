#!/usr/bin/env bash
set -eux

# Make script executable (if not already) and ensure logs directory exists
mkdir -p /var/log /home/jovyan
chown jovyan:jovyan /home/jovyan || true

# Create or reset a password for the jovyan user so you can log in to RStudio.
# Change "dev" to a stronger password if you will expose this to others.
echo "jovyan:dev" | chpasswd

# Start (or try to start) RStudio Server in background (listen on 0.0.0.0:8787)
if command -v rserver >/dev/null 2>&1; then
  nohup rserver --server-daemonize=0 --www-address=0.0.0.0 --www-port=8787 \
    &>/var/log/rserver.log &
else
  echo "rserver command not found; rstudio-server may not be installed" >&2
fi

# Start Jupyter Lab as jovyan on 0.0.0.0:8888 with no token (so Codespaces can open it)
# Adjust if you prefer to keep tokens enabled.
su - jovyan -c "nohup jupyter lab --no-browser --ip=0.0.0.0 --port=8888 --NotebookApp.token='' &>/home/jovyan/jupyter.log &"

echo "Started services (if installed). RStudio: http://localhost:8787, JupyterLab: http://localhost:8888"
