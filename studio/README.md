# Web Studio (iMac build environment)

Docker + Python practice stack and **client project factory** for custom sites.  
The public Wix portfolio at the repo root stays separate and honest.

## Quick start (iMac)

```bash
./scripts/bootstrap-imac.sh
make up
make smoke
make showcase
make new-client NAME=demo-brand
```

| Doc | Contents |
|-----|----------|
| [docs/DESIGN_PLAN.md](docs/DESIGN_PLAN.md) | Architecture, tiers, design rules, phases |
| [docs/SETUP_IMAC.md](docs/SETUP_IMAC.md) | Software list & install steps |
| [docs/CLIENT_CHECKLIST.md](docs/CLIENT_CHECKLIST.md) | Per-project delivery checklist |
| [docs/templates/SCOPE_CONTRACT.md](docs/templates/SCOPE_CONTRACT.md) | Tier B scope / payment template |
| [docs/CLIENT_ACQUISITION.md](docs/CLIENT_ACQUISITION.md) | Vincere channel strategy & ideal clients |
| [showcase/valley-oak/](showcase/valley-oak/) | Committed practice demo |

## Layout

- `apps/studio-api` — shared FastAPI practice service (memory or Postgres)
- `templates/client-project` — copy source for each custom job
- `showcase/valley-oak` — polished demo matching design rules
- `clients/` — generated projects (`make new-client`)
- `scripts/` — bootstrap, scaffold, smoke
