#!/usr/bin/env bash
# Scaffold a new client project from the studio template.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE="$ROOT/templates/client-project"
CLIENTS="$ROOT/clients"

NAME_RAW="${1:-}"
if [[ -z "$NAME_RAW" ]]; then
  echo "Usage: $0 <client-slug>"
  echo "Example: $0 sunrise-bakery"
  exit 1
fi

SLUG="$(echo "$NAME_RAW" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')"
TITLE="$(python3 -c "import sys; print(' '.join(w.capitalize() for w in sys.argv[1].split('-')))" "$SLUG")"

DEST="$CLIENTS/$SLUG"
if [[ -e "$DEST" ]]; then
  echo "Client folder already exists: $DEST"
  exit 1
fi

mkdir -p "$CLIENTS"
cp -R "$TEMPLATE" "$DEST"

find "$DEST" -type f \( \
  -name '*.html' -o -name '*.css' -o -name '*.js' -o -name '*.py' \
  -o -name '*.md' -o -name '*.yml' -o -name '*.yaml' -o -name '*.toml' \
  -o -name '*.txt' -o -name '*.example' -o -name 'Dockerfile' -o -name 'Makefile' \
  -o -name '*.conf' -o -name '.env.example' \
\) -print0 | while IFS= read -r -d '' file; do
  sed -i '' \
    -e "s/__CLIENT_SLUG__/${SLUG}/g" \
    -e "s/__CLIENT_NAME__/${TITLE}/g" \
    "$file"
done

cp "$DEST/.env.example" "$DEST/.env"

COUNT="$(find "$CLIENTS" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
FRONTEND_PORT=$((8088 + COUNT - 1))
API_PORT=$((8001 + COUNT - 1))
sed -i '' \
  -e "s/^FRONTEND_PORT=.*/FRONTEND_PORT=${FRONTEND_PORT}/" \
  -e "s/^API_PORT=.*/API_PORT=${API_PORT}/" \
  "$DEST/.env" "$DEST/.env.example"

echo "Created client project: $DEST"
echo "  Display name: $TITLE"
echo "  Frontend:     http://localhost:${FRONTEND_PORT}"
echo "  API:          http://localhost:${API_PORT}/docs"
echo
echo "Next:"
echo "  cd $DEST"
echo "  docker compose up --build"
