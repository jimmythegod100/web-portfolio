# Web Portfolio — Ready to Use

**Live site:** https://jimmythegod100.github.io/web-portfolio/

Your portfolio is fully built — photos, project screenshots, about section, FAQ, pricing, testimonials, and a working contact form. No manual fill-in required.

## What's Live

| Section | Status |
|---------|--------|
| Hero + workspace photo | Done |
| About + headshot | Done |
| 6 project screenshots | Done |
| Services, pricing, process | Done |
| FAQ + tech stack | Done |
| Contact form → your email | Done |
| OG/social preview image | Done |
| Platform profile copy (`profiles/`) | Done |

## Contact Form

Submissions go to **vincentmartinez9410@gmail.com** via FormSubmit. The first submission triggers a one-time activation email — click the link once and every future inquiry arrives automatically.

## Use on Client Platforms

Copy-paste from these files — all include the live URL:

- `profiles/upwork.md` — bio, skills, 6 portfolio entries
- `profiles/fiverr.md` — gigs, packages, FAQ
- `profiles/linkedin.md` — headline, about, featured link

## Preview Locally

```bash
cd ~/Projects/web-portfolio
python3 -m http.server 8080
```

Open http://localhost:8080

## Deploy URLs

| Host | URL |
|------|-----|
| **GitHub Pages (primary)** | https://jimmythegod100.github.io/web-portfolio/ |
| Netlify (optional) | Re-deploy with `npx netlify-cli deploy --prod --dir=.` after `netlify login` |

## Next Steps (optional)

- [x] Deploy to GitHub Pages
- [x] Add images and full content
- [x] Update profile files with live URL
- [ ] Connect custom domain (yourname.com) via GitHub Pages or Netlify DNS
- [ ] Add Google Analytics when you have a tracking ID
