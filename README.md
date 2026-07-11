# Vincent's Web Portfolio — Vincent Martinez

**Live site:** https://jimmythegod100.github.io/vincent-web-portfolio/

Honest portfolio for a 16-year-old Wix website builder — logos, social media setup, and simple front-end sites at beginner-friendly rates.

## What the site reflects

| Topic | Approach |
|-------|----------|
| Experience | Young, newer freelancer — stated clearly |
| Platform | Wix (not custom React/WordPress agency work) |
| Services | Webpages, logos, social links, basic SEO |
| Pricing | $50–$300 depending on scope |
| Work section | **Example styles**, not fake client case studies |
| Testimonials | Removed — replaced with "Why work with me" |

## Contact

- **Email:** vincentmartinez9410@gmail.com
- **Form:** FormSubmit → same email (one-time activation on first submission)

## Integrations (Calendly, social, payments)

Edit `js/site-config.js` — see **docs/INTEGRATIONS.md** for copy-paste examples.

## Platform copy

Ready to paste into client platforms:

- `profiles/upwork.md`
- `profiles/fiverr.md`
- `profiles/linkedin.md`

## Preview locally

```bash
cd ~/Projects/vincent-web-portfolio
python3 -m http.server 8080
```

Open http://localhost:8080

## Process docs

- `docs/PROCESS.md` — full build/deploy workflow
- `docs/INTEGRATIONS.md` — add Calendly, social, payment links job-by-job

## Studio (iMac build environment)

Custom Docker + Python practice stack and client project factory live in [`studio/`](studio/).  
Primary build machine: **iMac** (storage + Docker). See:

- [studio/docs/DESIGN_PLAN.md](studio/docs/DESIGN_PLAN.md) — architecture & design rules
- [studio/docs/SETUP_IMAC.md](studio/docs/SETUP_IMAC.md) — software install checklist
- [studio/README.md](studio/README.md) — quick start (`bootstrap-imac.sh`, `make up`, `make new-client`)

Wix client work stays on the public portfolio path above; the studio is for learning and future custom builds.
