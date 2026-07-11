# iMac Setup — Required Software & Config

Run this on the **iMac** (primary build machine). MacBook can stay light: Git + Cursor + browser.

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

**Alternative to Docker Desktop:** Podman (`brew install podman`) — already present on some machines; Docker Desktop is simpler for learning.

### Disk budget (plan for)

- Docker Desktop + images: **~8–15 GB**
- 3–5 practice/client projects: **~3–8 GB**
- Leave **≥40 GB free** on the iMac for comfortable builds

## 2. One-command bootstrap

On the iMac, after cloning this repo:

```bash
cd ~/Projects/web-portfolio/studio
chmod +x scripts/*.sh
./scripts/bootstrap-imac.sh
```

The script installs missing Homebrew packages, checks Docker, copies `.env.example` → `.env`, and prints next steps.

## 3. First run

```bash
cd ~/Projects/web-portfolio/studio
make up
curl -s http://localhost:8000/health
# expect: {"status":"ok"}
```

Practice API docs: http://localhost:8000/docs

## 4. New client project from template

```bash
make new-client NAME=sunrise-bakery
cd clients/sunrise-bakery
docker compose up --build
# site: http://localhost:8088
# api:  http://localhost:8001/docs
```

## 5. Cursor / editor settings (optional)

- Open folder: `~/Projects/web-portfolio` (whole repo)
- Python interpreter: Homebrew 3.12+
- Enable Docker extension if you use VS Code/Cursor Docker UI

## 6. Secrets

- Copy `studio/.env.example` → `studio/.env`
- Copy each client’s `.env.example` → `.env`
- Never commit `.env` files (already gitignored)

## 7. Sync with MacBook

```bash
# on either machine
git pull
git push
```

Do **not** sync Docker volumes or `node_modules` via iCloud — only git.

## 8. Wix work (unchanged)

No Docker required. Use Chrome/Safari + Wix editor. Portfolio marketing copy stays in `profiles/`.
