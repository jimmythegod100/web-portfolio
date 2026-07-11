# Vincere Media Works — Client Acquisition Strategy

**Primary build machine:** iMac (`conductor`)  
**Public brand:** [Vincere Media Works](https://github.com/jimmythegod100/vincere-media-works-web) — video, brand design, social content, websites  
**Studio stack:** `~/Projects/web-portfolio/studio` (Tier B custom builds, private until 2–3 shipped)

---

## Ideal clients right now (Q3 2026)

Target projects that match current skills, fast turnaround, and honest pricing — not enterprise or custom-app overreach.

| Segment | Project types | Why now |
|---------|---------------|---------|
| **Local Modesto / Central Valley SMBs** | Wix 1–5 page sites, logo refresh, Google Business + social link setup | Chamber/BNI referrals; fast trust; $50–$300 band |
| **Musicians & creators** | Landing pages, Fiverr intro videos, lyric/social clips, link-in-bio sites | Portfolio + `interactive-avatar` demo prove capability |
| **Food / retail / service shops** | Menu sites, hours/maps, simple contact forms, seasonal promos | Valley Oak showcase pattern; mobile-first |
| **Veteran-owned small businesses** | Brand kit + Wix site + social starter pack | NaVOBA / veteran networks; mission-aligned positioning |
| **First-time website buyers** | “I need something professional but not agency pricing” | Honest Tier A offer on Upwork/Fiverr/LinkedIn |

**Deprioritize for now:** Toptal/Gun.io enterprise Python, multi-tenant SaaS, payments/auth stacks (Tier C), claims of large-team delivery.

---

## Channel playbook

| Channel | Positioning | Action |
|---------|-------------|--------|
| **Fiverr** | Video intros, Wix sites, logo + social bundles | Active seller profile; CV at `vincere-media-works-web/cv/` |
| **Upwork** | Wix builder, simple sites (honest youth/new-freelancer angle on Vincent portfolio) | Copy from `profiles/upwork.md` |
| **LinkedIn** | Media production + brand design for SMBs | `profiles/linkedin.md`; post before/after + short reels |
| **GitHub** | Open portfolio + practice demos (honest labeling) | Pages: vincent-web-portfolio + vincere-media-works-web |
| **Modesto Chamber** | Local web + media for members | Attend mixers; offer free 15-min site audit |
| **BNI** | Referral-based local trades/service pros | One specialty: “launch-ready Wix in 7 days” |
| **NaVOBA / veteran networks** | Vet-owned business brand + web packages | Discounted starter tier; highlight veteran founder story |
| **Braintrust / Toptal** | **Hold** — resume when Tier B has 2–3 case studies | Do not apply with Wix-only positioning |
| **Gun.io** | **Hold** — same as above | Custom Python only after studio smoke tests green |

---

## Service ladder (what to sell vs build)

1. **Tier A (advertise now):** Wix sites, logos, social setup, Fiverr video — $50–$300  
2. **Tier B (studio on iMac, private):** Docker + FastAPI + static frontends — quote after scope contract  
3. **Tier C (later):** Auth, payments, DB-heavy apps — only with proven Tier B deliveries  

Use `docs/templates/SCOPE_CONTRACT.md` for every Tier B job.

---

## Weekly rhythm (iMac)

| Day | Task |
|-----|------|
| Mon | `make smoke` — studio health; check Fiverr/Upwork inbox |
| Tue–Thu | Client build on iMac (`make new-client NAME=...`) or Wix in browser |
| Fri | Post one portfolio piece (GitHub Pages / LinkedIn) |
| Sat | Chamber/BNI follow-ups; NaVOBA outreach if applicable |

---

## Proof assets to point prospects at

- **Vincere site:** `~/Projects/vincere-media-works-web` (GitHub Pages)
- **Vincent portfolio:** `~/Projects/web-portfolio` + practice section
- **Showcase demo:** `make showcase` → http://localhost:8090 (Valley Oak)
- **Video / avatar:** `~/Projects/nexus/interactive-avatar` (Fiverr intro pipeline)

---

## Success metrics (90 days)

- [ ] 3+ paid Tier A Wix/logo jobs closed
- [ ] 1 Tier B studio client delivered with signed scope contract
- [ ] 2 testimonials on Fiverr or Upwork
- [ ] Chamber or BNI: 1 referral conversation → paid project
- [ ] `make up && make smoke` green on iMac every week

---

## Run from iMac

```bash
# Studio stack
cd ~/Projects/web-portfolio/studio
make up && make smoke
make showcase   # http://localhost:8090

# New custom client
make new-client NAME=client-slug
```

Symlink (optional, matches docs):  
`ln -sf ~/Projects/web-portfolio ~/Projects/vincent-web-portfolio`
