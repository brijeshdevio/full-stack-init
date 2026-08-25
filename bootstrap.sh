#!/usr/bin/env bash

# ==========================================================
# Full Stack Bootstrap
# Location : /usr/bin/full-stack-config.sh
#
# Creates:
#   ./apps/web
#   ./apps/api
#
# Safe to run multiple times.
# Existing applications are never recreated.
# ==========================================================

set -euo pipefail

# ---------- Colors ----------
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
BLUE="\033[0;34m"
NC="\033[0m"

log() {
    echo -e "${BLUE}==>${NC} $1"
}

success() {
    echo -e "${GREEN}✔${NC} $1"
}

warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

error() {
    echo -e "${RED}✖${NC} $1"
}

# ----------------------------------------------------------
# Check required commands
# ----------------------------------------------------------

command -v pnpm >/dev/null 2>&1 || {
    error "pnpm is not installed."
    exit 1
}

command -v nest >/dev/null 2>&1 || {
    error "Nest CLI is not installed."
    exit 1
}

# ----------------------------------------------------------
# Configure CURRENT directory
# ----------------------------------------------------------

ROOT_DIR="$(pwd)"

log "Project Root : $ROOT_DIR"

mkdir -p "$ROOT_DIR/apps"

cd "$ROOT_DIR/apps"

# ==========================================================
# WEB
# ==========================================================

if [[ -f "web/package.json" ]]; then
    success "apps/web already exists. Skipping."
else
    log "Creating React & Shadcn application..."

#    pnpm dlx shadcn@latest init --preset b0 --base radix --template start --pointer web
#    pnpm dlx shadcn@latest init --preset b0 --base aria --template start --pointer
#    npx @tanstack/cli@latest create
    pnpm dlx shadcn@latest init --preset b0 --template vite --pointer --name web
    cd web
    touch .env .env.example
    rm README.md
    success "Web application created."
fi

# ==========================================================
# API
# ==========================================================
cd ..
if [[ -f "api/package.json" && -f "api/nest-cli.json" ]]; then
    success "apps/api already exists. Skipping."
else
    log "Creating NestJS application..."

    nest new api --skip-git --package-manager pnpm
    cd api
    touch .env .env.example
    rm README.md
    success "API application created."
fi

# ==========================================================
# Finished
# ==========================================================

echo
success "Configuration completed."
echo
echo "Project structure:"
echo
echo "$ROOT_DIR"
echo "└── apps"
echo "    ├── web"
echo "    └── api"
echo
# Root package.json
if [[ ! -f "$ROOT_DIR/package.json" ]]; then
cat > "$ROOT_DIR/package.json" <<'EOF'
{
  "name": "full-stack-workspace",
  "private": true,
  "scripts": {
    "dev:web": "pnpm --dir apps/web dev",
    "dev:api": "pnpm --dir apps/api start:dev",
    "dev": "concurrently \"pnpm run dev:api\" \"pnpm run dev:web\""
  },
  "devDependencies": {
    "concurrently": "^9.2.1"
  }
}
EOF

    success "Created root package.json"
else
    warn "package.json already exists. Skipping."
fi

log "Installing root dependencies..."
cd "$ROOT_DIR"
pnpm install

success "Dependencies installed."

cat > "$ROOT_DIR/.gitignore" <<'EOF'
node_modules
.env
EOF

# Initialize Git
log "Initializing git..."
git init
rm -rf apps/api/.git
rm -rf apps/web/.git
git switch -c dev
