#!/usr/bin/env bash
# Bootstrap the web studio on the iMac (Apple Silicon / Intel macOS).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "==> VM Web Studio — iMac bootstrap"
echo "    Studio root: $ROOT"
echo

need_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Install from https://brew.sh then re-run this script."
    exit 1
  fi
}

ensure_pkg() {
  local pkg="$1"
  if brew list --formula "$pkg" >/dev/null 2>&1 || brew list --cask "$pkg" >/dev/null 2>&1; then
    echo "  ✓ $pkg"
  else
    echo "  → installing $pkg"
    brew install "$pkg" || brew install --cask "$pkg" || true
  fi
}

need_brew

echo "==> Core packages"
ensure_pkg git
ensure_pkg gh
ensure_pkg python@3.12 || ensure_pkg python
ensure_pkg node

echo
echo "==> Container runtime"
if command -v docker >/dev/null 2>&1; then
  echo "  ✓ docker found: $(docker --version)"
  if ! docker info >/dev/null 2>&1; then
    echo "  ! Docker is installed but not running. Open Docker Desktop on the iMac, then re-run: make up"
  fi
elif command -v podman >/dev/null 2>&1; then
  echo "  ✓ podman found: $(podman --version)"
  echo "  Tip: alias docker=podman if you prefer, or install Docker Desktop for a simpler UI."
else
  echo "  → Docker Desktop not found."
  echo "    Install: https://www.docker.com/products/docker-desktop/"
  echo "    Or: brew install --cask docker"
  if [[ "${INSTALL_DOCKER:-}" == "1" ]]; then
    brew install --cask docker || true
  else
    echo "    (Set INSTALL_DOCKER=1 to let this script try brew cask install.)"
  fi
fi

echo
echo "==> Environment file"
if [[ ! -f .env ]]; then
  cp .env.example .env
  echo "  ✓ created .env from .env.example"
else
  echo "  ✓ .env already exists"
fi

mkdir -p clients
touch clients/.gitkeep

echo
echo "==> Done. Next steps on the iMac:"
echo "    1. Start Docker Desktop (if using Docker)"
echo "    2. cd $ROOT && make up"
echo "    3. open http://localhost:8000/docs"
echo "    4. make new-client NAME=demo-brand"
echo
echo "Design plan:  docs/DESIGN_PLAN.md"
echo "Setup guide:  docs/SETUP_IMAC.md"
