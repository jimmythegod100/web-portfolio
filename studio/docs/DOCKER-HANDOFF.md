# Docker handoff — client delivery

How we package finished web work so a client can run the same stack we built.

**Runtime on this iMac:** Podman (`docker` CLI → podman). Docker Desktop is optional.

## Two delivery paths

| Path | When | Command |
|------|------|---------|
| **Studio (Tier B)** — nginx + optional API/DB | Custom sites from `studio/templates/client-project` | `make handoff NAME=slug DO_ZIP=1` |
| **Static kits** — HTML / portfolio from `client-site-starter` | Brochure / portfolio sites | `~/workspace/nexus/client-site-starter/bin/handoff-package.sh SITE --zip` |

## One-time runtime prep

```bash
cd ~/Projects/vincent-web-portfolio/studio
make ensure-runtime    # starts Podman machine if needed
make bootstrap         # packages + .env
make up && make smoke
make showcase          # Valley Oak demo → http://localhost:8090
```

## Studio client → zip for client

```bash
make new-client NAME=sunrise-bakery
# …build the site…
make handoff NAME=sunrise-bakery DO_ZIP=1
# → studio/handoffs/sunrise-bakery-handoff-YYYYMMDD.zip
```

Showcase practice package:

```bash
make handoff NAME=valley-oak SHOWCASE=1 DO_ZIP=1
```

Each package includes:

- Full project (no `.env` secrets)
- `docker-compose.yml` + nginx/API as scoped
- `CLIENT-RUN.md` — client instructions
- `HANDOFF.md` — fill URLs + support window before send

```bash
make handoff NAME=sunrise-bakery DO_ZIP=1
# → studio/handoffs/sunrise-bakery-handoff-YYYYMMDD.zip
```

> Note: use `DO_ZIP=1` (not `ZIP=1`). Info-ZIP treats the `ZIP` env var as the archive filename.
## Static HTML kit → zip

```bash
cd ~/workspace/nexus/client-site-starter
./bin/new-client.sh acme-plumbing --out /tmp
# …edit site…
./bin/preview-docker.sh /tmp/acme-plumbing          # local nginx preview
./bin/handoff-package.sh /tmp/acme-plumbing --zip   # deliverable
```

Or via organizer wrapper:

```bash
~/.organized/bin/client-handoff studio valley-oak --showcase --zip
~/.organized/bin/client-handoff static /path/to/site --zip
~/.organized/bin/client-handoff ensure
```

## What the client runs

```bash
unzip *-handoff-*.zip
cd *-handoff-*
cp .env.example .env   # if needed
docker compose up --build
# open http://localhost:8088 (studio) or :8080 (static)
```

## Checklist before you email the zip

- [ ] `docker compose up --build` works from the handoff folder
- [ ] No secrets in the zip (script refuses obvious tokens)
- [ ] `HANDOFF.md` has production URL + support window
- [ ] `CLIENT-RUN.md` is the top of the email / Drive folder
- [ ] Invoice / payment status noted

## Related

- Studio setup: [SETUP_IMAC.md](SETUP_IMAC.md)
- Client checklist: [CLIENT_CHECKLIST.md](CLIENT_CHECKLIST.md)
- Static kits: `~/workspace/nexus/client-site-starter/CLIENT-WEBSITE-SYSTEM.md`
- Host runtime status: `~/.organized/docs/DOCKER-STATUS.md`
