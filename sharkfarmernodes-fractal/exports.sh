#!/usr/bin/env bash
set -euo pipefail

DATA_DIR="$APP_DATA_DIR/data"

# Create data dir
mkdir -p "$DATA_DIR"

# OPTIONAL: seed config on first install
CONF="$DATA_DIR/bitcoin.conf"
if [ ! -f "$CONF" ]; then
cat > "$CONF" <<'EOF'
server=1
daemon=0
prune=30000
txindex=0
printtoconsole=1
EOF
fi

# Make it writable (Umbrel apps most commonly run as umbrel user: 1000:1000)
# If your image runs as non-root with another UID, either change this UID or use user: "0:0" in compose.
chown -R 1000:1000 "$DATA_DIR"
chmod -R u+rwX,g+rwX "$DATA_DIR"