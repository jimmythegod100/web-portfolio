# iMac Setup — Required Software & Config

Run this on the **iMac** (primary build machine). MacBook can stay light: Git + Cursor + browser.

**Repo path on disk:** `~/Projects/web-portfolio` (symlink `~/Projects/vincent-web-portfolio` optional)

## 1. Install checklist

| Software | Purpose | Install |
|----------|---------|---------|
| **Homebrew** | Package manager | https://brew.sh |
| **Git** | Version control | `brew install git` |
| **GitHub CLI (`gh`)** | Push, PRs, Pages | `brew install gh` |
| **Docker Desktop** | Containers (preferred on iMac) | https://docker.com/products/docker-desktop |
| **Python 3.12+** | Backend / scripts | `brew install python@3.12` |
| **Node.js 22 LTS** (via nvm or brew) | Frontend tooling if needed | `brew install node` or nvm |
| **Cursor** | Coding | Already in use |
| **PostgreSQL client** (optional) | Inspect DB | `brew install libpq` |

**Alternative to Docker Desktop:** Podman (`brew install podman`) — Docker Desktop is simpler for learning.

### Disk budget (plan for)

- Docker Desktop + images: **~8–15 GB**
- 3–5 practice/client projects: **~3–8 GB**
- Leave **≥40 GB free** on the iMac for comfortable builds

## 2. One-command bootstrap

```bash
cd ~/Projects/vincent-web-portfolio/studio
chmod +x scripts/*.sh
./scripts/bootstrap-imac.sh
```

The script installs missing Homebrew packages, checks Docker, copies `.env.example` → `.env`, and prints next steps.

## 3. First run

```bash
cd ~/Projects/vincent-web-portfolio/studio
make up
make smoke
# API docs: http://localhost:8000/docs
```

### Optional Postgres for studio API

1. In `.env` set:  
   `DATABASE_URL=postgresql+psycopg://studio:studio_dev_change_me@db:5432/studio`
2. `make up-db`

## 4. Showcase + new client

```bash
make showcase
# http://localhost:8090

make new-client NAME=sunrise-bakery
cd clients/sunrise-bakery
docker compose up --build
```

## 5. Cursor recommendations

Open the whole repo. Suggested extensions live in `studio/.vscode/extensions.json` (Python, Docker).

## 6. Secrets

- Copy `studio/.env.example` → `studio/.env`
- Copy each client’s `.env.example` → `.env`
- Never commit `.env` files (already gitignored)

## 7. Sync with MacBook

```bash
git pull
git push
```

Do **not** sync Docker volumes via iCloud — only git.

## 8. Wix work (unchanged)

No Docker required. Portfolio marketing copy stays in `profiles/`.
