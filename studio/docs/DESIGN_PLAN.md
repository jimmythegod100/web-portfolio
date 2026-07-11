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
- **Postgres:** only when the site needs stored data (leads, bookings)
- **Nginx:** one URL for site + API in production-like local runs

---

## 4. Repo layout

```
web-portfolio/                 # public portfolio (unchanged role)
├── index.html …               # GitHub Pages site
├── profiles/                  # Upwork / Fiverr / LinkedIn copy
└── studio/                    # iMac build + client factory
    ├── docs/                  # plans & checklists
    ├── scripts/               # bootstrap + new-client
    ├── templates/client-project/
    ├── clients/               # real client clones (gitignored contents ok)
    ├── apps/studio-api/       # shared practice API
    ├── docker-compose.yml     # studio-wide stack
    └── Makefile
```

---

## 5. Design system (client frontends)

Keep visual work intentional and non-generic:

- **Typography:** pick one display + one body per brand (avoid Inter/Roboto/Arial defaults)
- **Atmosphere:** gradient or photo plane in the hero — not flat gray
- **First viewport:** brand, one headline, one sentence, one CTA group, one dominant visual
- **No hero cards / floating badges** unless the brand already uses them
- **Motion:** 2–3 purposeful animations (entrance, hover, scroll) — not noise
- **Responsive:** desktop + mobile from day one

Wireframes before Wix or before code: sketch → approve with client → build.

---

## 6. iMac workflow (day to day)

1. Open Cursor on the iMac → `~/Projects/web-portfolio`
2. Start studio stack: `cd studio && make up`
3. New custom job: `make new-client NAME=acme-co`
4. Design in `clients/acme-co/frontend/`
5. API work in `clients/acme-co/backend/`
6. Preview: http://localhost:8088 (compose maps ports per project)
7. Ship: static → Netlify/GitHub Pages; full stack → host that supports Docker

Wix jobs stay outside Docker — use the browser + Wix editor as today.

---

## 7. Phased rollout

| Phase | When | Deliverable |
|-------|------|-------------|
| **0** | Now | Studio folders, configs, iMac bootstrap script |
| **1** | This week | Run `bootstrap-imac.sh` on iMac; `make up` succeeds |
| **2** | Practice | One demo site from template (your own fictional brand) |
| **3** | Portfolio update | Add “Custom practice builds” only after demo looks good |
| **4** | Paid Tier B | First real custom client under a clear scope contract |

---

## 8. Storage & performance (why iMac)

| Asset | Rough size | Keep on iMac |
|-------|------------|--------------|
| Docker images (Python, Nginx, Postgres) | 2–6 GB | Yes |
| Per-client `node_modules` / build cache | 200–800 MB | Yes |
| Client photos / video | varies | Yes (`clients/*/assets`) |
| Portfolio static site | tiny | Sync both machines via git |

MacBook: git pull + edit docs/HTML. Heavy `docker compose build` → iMac.

---

## 9. Success criteria

- [ ] iMac has Docker (or Podman) + Python 3.12+ + Node 20+ + Git + gh
- [ ] `studio/make up` serves the practice API health check
- [ ] `make new-client NAME=demo` creates a runnable project
- [ ] One demo frontend matches the design rules in §5
- [ ] Secrets only in `.env` (never committed)

---

## 10. Out of scope (for now)

- Electron wrappers, Toptal/Gun.io positioning
- Claiming enterprise Python chops on public profiles
- Auto-deploy CI for every client (add when you have a host)
