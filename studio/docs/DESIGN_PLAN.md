# Studio Design Plan — Vincent Martinez Web Studio

**Build machine:** iMac (primary) · MacBook for light edits  
**Portfolio (live):** static Wix-focused site at repo root → GitHub Pages  
**Studio (this folder):** Docker + Python practice/build environment for custom client work

---

## 1. Goals

| Goal | Why |
|------|-----|
| One reliable build machine | iMac has storage + CPU headroom for Docker images, node_modules, client assets |
| Honest service tiers | Keep Wix/simple sites as the public offer; grow custom stack privately until ready |
| Repeatable client delivery | Every custom project starts from the same template (frontend + Python API + Docker) |
| Clean handoff | Clients (or you) can run the same stack locally/staging/production via containers |

---

## 2. Service tiers (what you sell vs what you build)

### Tier A — Current public offer (portfolio stays honest)
- Wix 1–5 page sites, logos, social links, basic SEO
- Price band: $50–$300
- Tools: Wix, Canva, browser, this static portfolio

### Tier B — Studio practice → future offer
- Custom static or lightly dynamic sites (HTML/CSS/JS + optional Python API)
- Contact forms, small dashboards, booking-style flows
- Tools: this `studio/` stack on the iMac
- Do **not** advertise Tier B on LinkedIn/Upwork until you have 2–3 real projects

### Tier C — Later (only after Tier B comfort)
- Auth, payments, databases, multi-service apps
- Same Docker layout; more backend modules

---

## 3. Architecture (Tier B template)

```
Browser
   │
   ▼
┌─────────────┐     ┌──────────────────┐     ┌────────────┐
│  Nginx      │────▶│  Frontend static │     │  Postgres  │
│  (reverse   │     │  (HTML/CSS/JS)   │     │  (optional)│
│   proxy)    │────▶│  FastAPI backend │────▶│            │
└─────────────┘     └──────────────────┘     └────────────┘
         ▲
         │  All packaged with Docker Compose
```

**Roles**
- **Frontend:** visual design (the “web design” clients see)
- **Python (FastAPI):** forms, APIs, business rules — the “engine”
- **Docker:** identical run environment on iMac → staging → host
- **Postgres:** optional via Compose `--profile db` + `DATABASE_URL` (otherwise in-memory)
- **Nginx:** one URL for site + API in production-like local runs

---

## 4. Repo layout

```
vincent-web-portfolio/         # public portfolio
├── index.html …               # GitHub Pages site
├── profiles/                  # Upwork / Fiverr / LinkedIn copy
└── studio/                    # iMac build + client factory
    ├── docs/                  # plans, checklists, scope contract
    ├── scripts/               # bootstrap, new-client, smoke
    ├── templates/client-project/
    ├── showcase/valley-oak/   # committed practice demo
    ├── clients/               # generated jobs (gitignored)
    ├── apps/studio-api/       # shared practice API
    ├── docker-compose.yml
    └── Makefile
```

---

## 5. Design system (client frontends)

- **Typography:** one display + one body per brand (avoid Inter/Roboto/Arial defaults)
- **Atmosphere:** gradient or photo plane in the hero — not flat gray
- **First viewport:** brand, one headline, one sentence, one CTA group, one dominant visual
- **No hero cards / floating badges** unless the brand already uses them
- **Motion:** 2–3 purposeful animations (entrance, hover, scroll reveal)
- **Responsive:** desktop + mobile from day one

Wireframes before Wix or before code: sketch → approve with client → build.

---

## 6. iMac workflow (day to day)

1. Open Cursor on the iMac → `~/Projects/vincent-web-portfolio`
2. Start studio stack: `cd studio && make up`
3. Smoke test: `make smoke`
4. New custom job: `make new-client NAME=acme-co`
5. Design in `clients/acme-co/frontend/`
6. Optional DB: set `DATABASE_URL` + `make up-db` (or client `docker compose --profile db up`)
7. Showcase demo: `make showcase` → http://localhost:8090
8. Ship: static → Netlify/GitHub Pages; full stack → host that supports Docker

Wix jobs stay outside Docker — use the browser + Wix editor as today.

---

## 7. Phased rollout

| Phase | Status | Deliverable |
|-------|--------|-------------|
| **0** | Done | Studio folders, configs, iMac bootstrap script |
| **1** | Ready on iMac | `bootstrap-imac.sh` + `make up` + `make smoke` |
| **2** | Done | Showcase: `studio/showcase/valley-oak` |
| **3** | Done | Portfolio `#practice` section (honest labeling) |
| **4** | Template ready | Scope contract in `docs/templates/SCOPE_CONTRACT.md` |

---

## 8. Storage & performance (why iMac)

| Asset | Rough size | Keep on iMac |
|-------|------------|--------------|
| Docker images (Python, Nginx, Postgres) | 2–6 GB | Yes |
| Per-client build cache | 200–800 MB | Yes |
| Client photos / video | varies | Yes (`clients/*/assets`) |
| Portfolio static site | tiny | Sync both machines via git |

MacBook: git pull + edit docs/HTML. Heavy `docker compose build` → iMac.

---

## 9. Success criteria

- [x] Studio structure + bootstrap in repo
- [x] Showcase demo matches design rules (§5)
- [x] Portfolio practice section (honest, not sold as client work)
- [x] Optional Postgres persistence path
- [x] Healthchecks + smoke script
- [x] Scope contract + handoff templates
- [x] iMac has Docker Desktop + Python 3.12+ + Node + Git + gh
- [x] `make up` + `make smoke` green on iMac

---

## 10. Out of scope (still)

- Electron wrappers, Toptal/Gun.io positioning
- Claiming enterprise Python chops on public profiles
- Auto-deploy CI for every client (add when you have a host)
