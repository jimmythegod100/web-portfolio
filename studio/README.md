# Web Studio (iMac build environment)

Docker + Python practice stack and **client project factory** for custom sites.  
The public Wix portfolio at the repo root stays separate and honest.

## Quick start (iMac)

```bash
./scripts/bootstrap-imac.sh
make up
make new-client NAME=demo-brand
```

| Doc | Contents |
|-----|----------|
| [docs/DESIGN_PLAN.md](docs/DESIGN_PLAN.md) | Architecture, tiers, design rules, phases |
| [docs/SETUP_IMAC.md](docs/SETUP_IMAC.md) | Software list & install steps |
| [docs/CLIENT_CHECKLIST.md](docs/CLIENT_CHECKLIST.md) | Per-project delivery checklist |

## Layout

- `apps/studio-api` — shared FastAPI practice service
- `templates/client-project` — copy source for each custom job
- `clients/` — generated projects (`make new-client`)
- `scripts/` — bootstrap + scaffolding
