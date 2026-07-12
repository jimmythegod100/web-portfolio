# __CLIENT_NAME__ — how to run this site

You received a Docker package of your website.

## Start

```bash
cp .env.example .env
docker compose up --build
```

- Site: http://localhost:8088 (or `FRONTEND_PORT` in `.env`)
- API docs: http://localhost:8001/docs
- Health: http://localhost:8088/health

Stop: `Ctrl+C` or `docker compose down`.

## Edit

| Path | Purpose |
|------|---------|
| `frontend/` | Pages, CSS, images |
| `backend/` | Contact/API (if included) |
| `HANDOFF.md` | Access + support notes |

## Hosting

Keep `docker compose up -d` on a VPS, or publish `frontend/` to Netlify / GitHub Pages.
