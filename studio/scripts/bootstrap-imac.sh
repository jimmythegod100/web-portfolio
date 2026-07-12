#!/usr/bin/env bash
# Bootstrap the web studio on the iMac (Apple Silicon / Intel macOS).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "==> VM Web Studio — iMac bootstrap"
echo "    Studio root: $ROOT"
echo "    Expected repo: vincent-web-portfolio (or local clone)"
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
echo "==> Container runtime (Podman preferred on this iMac)"
if command -v podman >/dev/null 2>&1; then
  echo "  ✓ podman found: $(podman --version)"
  if command -v docker >/dev/null 2>&1; then
    echo "  ✓ docker CLI: $(command -v docker) → $(docker --version 2>/dev/null | head -1)"
  fi
  if ! docker info >/dev/null 2>&1; then
    echo "  → starting Podman machine…"
    "$ROOT/scripts/ensure-runtime.sh" || {
      echo "  ! Runtime not ready. Run: make ensure-runtime"
    }
  else
    echo "  ✓ docker info OK"
  fi
elif command -v docker >/dev/null 2>&1; then
  echo "  ✓ docker found: $(docker --version)"
  if ! docker info >/dev/null 2>&1; then
    echo "  ! Docker is installed but not running. Start Docker Desktop, then: make up"
  fi
else
  echo "  → No container runtime found."
  echo "    Preferred: brew install podman && podman machine init && podman machine start"
  echo "    Or Docker Desktop: https://www.docker.com/products/docker-desktop/"
  if [[ "${INSTALL_PODMAN:-}" == "1" ]]; then
    brew install podman || true
    podman machine init 2>/dev/null || true
    podman machine start || true
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

mkdir -p handoffs
touch handoffs/.gitkeep

echo
echo "==> Done. Next steps on the iMac:"
echo "    1. make ensure-runtime   # Podman machine up"
echo "    2. cd $ROOT && make up && make smoke"
echo "    3. make showcase         # http://localhost:8090"
echo "    4. make new-client NAME=demo-brand"
echo "    5. make handoff NAME=demo-brand DO_ZIP=1   # client deliverable"
echo
echo "Design plan:  docs/DESIGN_PLAN.md"
echo "Setup guide:  docs/SETUP_IMAC.md"
echo "Scope form:   docs/templates/SCOPE_CONTRACT.md"
echo "Handoff:      docs/DOCKER-HANDOFF.md"
