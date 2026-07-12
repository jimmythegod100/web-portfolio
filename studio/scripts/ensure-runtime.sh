#!/usr/bin/env bash
# ensure-runtime.sh — make sure Podman/docker CLI can talk to a running engine.
set -euo pipefail

MACHINE="${PODMAN_MACHINE:-podman-machine-default}"

find_podman_sock() {
  local sock
  sock="$(ls /var/folders/*/T/podman/${MACHINE}-api.sock 2>/dev/null | head -1 || true)"
  if [[ -z "$sock" ]]; then
    sock="$(ls "${TMPDIR:-/tmp}"/podman/${MACHINE}-api.sock 2>/dev/null | head -1 || true)"
  fi
  printf '%s' "$sock"
}

export_sock_if_present() {
  local sock
  sock="$(find_podman_sock)"
  if [[ -n "$sock" ]]; then
    export DOCKER_HOST="unix://${sock}"
  fi
}

runtime_ok() {
  export_sock_if_present
  docker info >/dev/null 2>&1
}

if ! command -v docker >/dev/null 2>&1 && ! command -v podman >/dev/null 2>&1; then
  echo "ERROR: neither docker nor podman found. Install Podman: brew install podman" >&2
  exit 1
fi

# Fast path: already usable
if runtime_ok; then
  echo "Container runtime OK (already running)"
  echo "  docker: $(command -v docker)"
  echo "  DOCKER_HOST=${DOCKER_HOST:-"(default)"}"
  docker ps --format '  running: {{.Names}}' 2>/dev/null | head -20 || true
  # Print export line for parent shells that source us
  [[ -n "${DOCKER_HOST:-}" ]] && echo "export DOCKER_HOST='${DOCKER_HOST}'"
  exit 0
fi

if command -v podman >/dev/null 2>&1; then
  running_line="$(podman machine list 2>/dev/null | awk -v m="$MACHINE" 'NR>1 && index($1,m)==1 {print; exit}')"
  if echo "$running_line" | grep -qiE 'currently running|[[:space:]]running[[:space:]]'; then
    echo "==> Podman machine listed running but API down — restarting ${MACHINE}"
    podman machine stop "$MACHINE" >/dev/null 2>&1 || true
    sleep 1
  fi

  echo "==> Starting Podman machine: ${MACHINE}"
  if ! perl -e 'alarm shift; exec @ARGV' 120 podman machine start "$MACHINE"; then
    echo "WARN: podman machine start timed out or failed — probing API…" >&2
  fi

  for _ in $(seq 1 45); do
    if runtime_ok; then
      break
    fi
    sleep 1
  done
fi

if ! runtime_ok; then
  echo "ERROR: container runtime not ready. Tried Podman machine '${MACHINE}'." >&2
  echo "  Fix: podman machine start ${MACHINE}" >&2
  echo "  Then: export DOCKER_HOST=unix://\$(ls /var/folders/*/T/podman/${MACHINE}-api.sock | head -1)" >&2
  exit 1
fi

echo "Container runtime OK"
echo "  docker: $(command -v docker)"
echo "  DOCKER_HOST=${DOCKER_HOST:-"(default)"}"
docker ps --format '  running: {{.Names}}' 2>/dev/null | head -20 || true
[[ -n "${DOCKER_HOST:-}" ]] && echo "export DOCKER_HOST='${DOCKER_HOST}'"
