# Client delivery checklist

Use once per custom (Tier B) project. Skip for pure Wix jobs.

## Kickoff
- [ ] Written scope (use `docs/templates/SCOPE_CONTRACT.md`)
- [ ] Brand assets received (logo, colors, fonts, photos)
- [ ] Domain / hosting plan agreed
- [ ] `make new-client NAME=...` created on iMac

## Design
- [ ] Wireframe approved (mobile + desktop)
- [ ] Typography + color tokens set in CSS variables
- [ ] Hero follows one-composition rule (brand, headline, CTA, visual)
- [ ] 2–3 intentional motions only

## Build
- [ ] Frontend complete + responsive
- [ ] Backend endpoints only for agreed features
- [ ] `.env` configured; no secrets in git
- [ ] `docker compose up --build` works on iMac

## Launch
- [ ] Client preview link shared
- [ ] Forms tested end-to-end
- [ ] DNS / hosting pointed
- [ ] `HANDOFF.md` filled and shared
- [ ] `make handoff NAME=… DO_ZIP=1` produced (no secrets) and smoke-tested from the zip folder
- [ ] `CLIENT-RUN.md` sent with the package
- [ ] `make smoke` (or project health URL) checked

## Aftercare
- [ ] Invoice sent
- [ ] Ask for testimonial (optional)
- [ ] Archive project folder on iMac (+ keep handoff zip in `studio/handoffs/`)
