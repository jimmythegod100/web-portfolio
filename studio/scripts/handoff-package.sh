#!/usr/bin/env bash
# handoff-package.sh — build a clean client deliverable (no secrets) for Docker handoff.
#
# Usage:
#   ./scripts/handoff-package.sh <client-slug> [--out DIR] [--zip]
#   ./scripts/handoff-package.sh valley-oak --showcase --zip
#
# Produces a folder the client can unzip and run with:
#   docker compose up --build
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLIENTS="$ROOT/clients"
SHOWCASE="$ROOT/showcase"
OUT_BASE="${HANDOFF_OUT:-$ROOT/handoffs}"
SLUG=""
USE_SHOWCASE=0
MAKE_ZIP=0

usage() {
  sed -n '2,12p' "$0"
  exit "${1:-0}"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) usage 0 ;;
    --out) OUT_BASE="${2:-}"; shift 2 ;;
    --showcase) USE_SHOWCASE=1; shift ;;
    --zip) MAKE_ZIP=1; shift ;;
    -*)
      echo "Unknown flag: $1" >&2
      usage 2
      ;;
    *)
      if [[ -z "$SLUG" ]]; then SLUG="$1"; else echo "Extra arg: $1" >&2; usage 2; fi
      shift
      ;;
  esac
done

[[ -n "$SLUG" ]] || usage 2
SLUG="$(printf '%s' "$SLUG" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-|-$//g')"

if [[ "$USE_SHOWCASE" -eq 1 ]]; then
  SRC="${SHOWCASE}/${SLUG}"
else
  SRC="${CLIENTS}/${SLUG}"
fi

[[ -d "$SRC" ]] || {
  echo "Missing project: $SRC" >&2
  echo "Tip: make new-client NAME=${SLUG}   or use --showcase for showcase/${SLUG}" >&2
  exit 1
}

STAMP="$(date +%Y%m%d)"
DEST="${OUT_BASE%/}/${SLUG}-handoff-${STAMP}"
rm -rf "$DEST"
mkdir -p "$DEST"

# Copy project; exclude secrets, caches, local env
rsync -a \
  --exclude '.env' \
  --exclude '.env.local' \
  --exclude '.git' \
  --exclude '__pycache__' \
  --exclude '*.pyc' \
  --exclude '.DS_Store' \
  --exclude 'node_modules' \
  --exclude '.venv' \
  --exclude 'venv' \
  --exclude '*.log' \
  "$SRC/" "$DEST/"

# Ensure .env.example exists for the client
if [[ -f "$SRC/.env.example" && ! -f "$DEST/.env.example" ]]; then
  cp "$SRC/.env.example" "$DEST/.env.example"
fi
if [[ -f "$DEST/.env.example" && ! -f "$DEST/.env" ]]; then
  # Safe starter .env from example (no secrets expected in example)
  cp "$DEST/.env.example" "$DEST/.env"
fi

# Client-facing run sheet
TITLE="$(python3 -c "import sys; print(' '.join(w.capitalize() for w in sys.argv[1].split('-')))" "$SLUG")"
cat > "$DEST/CLIENT-RUN.md" <<EOF
# ${TITLE} — how to run this site

You received a Docker package of your website. You do **not** need to install Node or Python.

## Requirements

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) **or** [Podman](https://podman.io/)
- About 2 GB free disk for the first pull

## Start the site

\`\`\`bash
cd $(basename "$DEST")
# If you use Podman instead of Docker Desktop, start the machine once:
#   podman machine start
cp .env.example .env   # only if .env is missing
docker compose up --build
\`\`\`

Then open:

- **Website:** http://localhost:8088 (or the \`FRONTEND_PORT\` in \`.env\`)
- **API docs** (if included): http://localhost:8001/docs

Stop with \`Ctrl+C\`, or in another terminal: \`docker compose down\`.

## What you can edit

| Folder / file | Purpose |
|---------------|---------|
| \`frontend/\` | Pages, CSS, images |
| \`nginx/default.conf\` | How the web server routes traffic |
| \`backend/\` | Contact/API (only if your project includes it) |
| \`HANDOFF.md\` | Access, support window, hosting notes |

## Hosting options

1. Keep running on a small VPS with \`docker compose up -d\`
2. Or publish the \`frontend/\` folder to Netlify / GitHub Pages (static pages only)

## Support

See \`HANDOFF.md\` for the support window and how to request changes.
EOF

# Fill HANDOFF placeholders if still templated
if [[ -f "$DEST/HANDOFF.md" ]]; then
  sed -i '' \
    -e "s/__CLIENT_NAME__/${TITLE}/g" \
    -e "s/__CLIENT_SLUG__/${SLUG}/g" \
    "$DEST/HANDOFF.md"
fi

# README pointer
if [[ ! -f "$DEST/README.md" ]]; then
  echo "# ${TITLE}" > "$DEST/README.md"
  echo >> "$DEST/README.md"
  echo "Start here: [CLIENT-RUN.md](CLIENT-RUN.md)" >> "$DEST/README.md"
fi

# Sanity: must have compose file
if [[ ! -f "$DEST/docker-compose.yml" && ! -f "$DEST/compose.yml" ]]; then
  echo "ERROR: no docker-compose.yml in package — refusing handoff" >&2
  exit 1
fi

# Refuse if a real-looking secret slipped in
if grep -RIlE 'sk-[a-zA-Z0-9]{20,}|ghp_[a-zA-Z0-9]{20,}|AKIA[0-9A-Z]{16}' "$DEST" >/dev/null 2>&1; then
  echo "ERROR: possible secret detected in package — aborting" >&2
  exit 1
fi

mkdir -p "$OUT_BASE"
echo "Handoff folder: $DEST"

ZIP_PATH=""
if [[ "$MAKE_ZIP" -eq 1 ]]; then
  ZIP_PATH="${DEST}.zip"
  rm -f "$ZIP_PATH"
  if ! command -v zip >/dev/null 2>&1; then
    echo "WARN: zip not installed — folder handoff only (brew install zip)" >&2
    ZIP_PATH=""
  else
    # Info-ZIP reads $ZIP as the archive name — never leave ZIP=1 in the env.
    (
      cd "$(dirname "$DEST")"
      unset ZIP
      zip -qr "$(basename "$ZIP_PATH")" "$(basename "$DEST")"
    )
    if [[ -f "$ZIP_PATH" ]]; then
      echo "Handoff zip:    $ZIP_PATH"
      echo "Size:           $(du -h "$ZIP_PATH" | awk '{print $1}')"
    else
      echo "WARN: zip command ran but $ZIP_PATH missing" >&2
      ZIP_PATH=""
    fi
  fi
fi

# Manifest for our archives
cat > "$DEST/HANDOFF-MANIFEST.txt" <<EOF
slug=${SLUG}
title=${TITLE}
built=$(date -u +%Y-%m-%dT%H:%M:%SZ)
source=${SRC}
zip=${ZIP_PATH:-none}
runtime=docker-compose
EOF

echo
echo "Next:"
echo "  1. Fill ${DEST}/HANDOFF.md (URLs, support window)"
echo "  2. Smoke-test: cd \"$DEST\" && docker compose up --build"
echo "  3. Send zip/folder to client with CLIENT-RUN.md on top"
