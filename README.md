# Web Portfolio — Deployment Guide

Your client-ready portfolio website and platform profile copy.

## What's Included

| File / Folder | Purpose |
|---|---|
| `index.html` | Main portfolio website |
| `css/style.css` | Styles |
| `js/main.js` | Mobile nav & interactions |
| `profiles/upwork.md` | Upwork bio, skills, portfolio entries |
| `profiles/fiverr.md` | Fiverr gigs, packages, FAQ |
| `profiles/linkedin.md` | LinkedIn headline, about, templates |

## Preview Locally

```bash
cd ~/Projects/web-portfolio
python3 -m http.server 8080
```

Open http://localhost:8080 in your browser.

## Deploy (Free Options)

### Option 1: Netlify Drop (fastest — no account needed to test)
1. Go to https://app.netlify.com/drop
2. Drag the entire `web-portfolio` folder onto the page
3. You get a live URL instantly (e.g. `random-name.netlify.app`)
4. Create a free Netlify account to claim and customize the URL

### Option 2: GitHub Pages
```bash
cd ~/Projects/web-portfolio
git add .
git commit -m "Add portfolio website"
git remote add origin https://github.com/YOUR_USERNAME/web-portfolio.git
git push -u origin main
```
Then in GitHub repo Settings → Pages → Source: Deploy from branch → `main` / root.

Your site will be at `https://YOUR_USERNAME.github.io/web-portfolio/`

### Option 3: Vercel
```bash
npx vercel --cwd ~/Projects/web-portfolio
```
Follow prompts. Free tier includes custom domains.

## Customize Before Going Live

1. **Name & email** — Search/replace "Andrew Martinez" and email if needed (currently set to andrewjamesmartinez91@gmail.com)
2. **Stats** — Update "35+ websites" etc. to match your real numbers
3. **Projects** — Replace demo projects with your actual work (or keep as concept portfolio until you have real clients)
4. **Pricing** — Adjust packages to match your rates
5. **Testimonials** — Swap in real client quotes when available
6. **Portfolio URL** — Add your live URL to the profile files in `profiles/`

## Upload to Client Platforms

### Upwork
1. Copy content from `profiles/upwork.md`
2. Add portfolio items with screenshots (take screenshots of your deployed site sections, or use the project cards as visuals)
3. Upload 1–3 screenshots per portfolio entry

### Fiverr
1. Create 2–3 gigs using titles/descriptions from `profiles/fiverr.md`
2. Use screenshots of your portfolio site as gig gallery images
3. Record a 30–60 sec intro video (optional but boosts orders significantly)

### LinkedIn
1. Paste headline and about from `profiles/linkedin.md`
2. Add deployed portfolio URL to Featured section
3. Pin web development skills

### Other Platforms
- **Contra / Toptal / Freelancer** — Use the Upwork overview as base
- **Instagram / TikTok bio** — "Web developer · I build sites that convert · Free quote ↓ [link]"
- **Google Business Profile** — If offering local web services

## Screenshot Tips for Gig Galleries

Take these screenshots from your deployed site:
1. Full homepage hero (above the fold)
2. Projects/work section
3. Mobile view (use browser dev tools → iPhone size)
4. Pricing section
5. Contact section

## Next Steps

- [ ] Deploy to Netlify/Vercel/GitHub Pages
- [ ] Replace demo projects with real work as you complete projects
- [ ] Add Google Analytics (optional: paste GA script in `<head>` of index.html)
- [ ] Connect a custom domain (yourname.com) via Netlify/Vercel DNS settings
- [ ] Update profile files with your live portfolio URL
