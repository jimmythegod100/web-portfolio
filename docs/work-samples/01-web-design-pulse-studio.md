# Web Design Concept — Pulse Studio (Mock Client)

**Agency:** Vincere Media Works  
**Role:** Senior UI/UX Designer  
**Client:** Pulse Studio — local boutique fitness studio  
**Goal:** Increase online class bookings and reduce no-shows from phone/DM scheduling

---

## Project overview

Pulse Studio offers small-group reformer Pilates, strength circuits, and early-morning mobility classes. Most bookings still happen over Instagram DMs and a paper signup sheet at the front desk. Vincere Media Works designed a conversion-first website concept that makes class discovery, schedule browsing, and booking feel as fast as scrolling a feed—without looking like a generic gym template.

**Primary KPI:** Online booking completion rate  
**Secondary KPIs:** Mobile session → booking CTA click rate; schedule page bounce rate

---

## Color palette

| Role | Name | Hex | Usage |
|------|------|-----|-------|
| Primary | Deep Charcoal | `#1C1F24` | Headlines, nav, footer |
| Accent | Pulse Coral | `#E85D4C` | Primary CTAs, active states, “spots left” badges |
| Support | Warm Stone | `#F3EDE6` | Page background, section bands |
| Surface | Soft Ivory | `#FFFAF6` | Cards, form panels |
| Text secondary | Slate | `#5C6570` | Body copy, captions |
| Success | Sage | `#3D7A5F` | Confirmed booking states |
| Alert | Amber | `#C9862A` | Low-capacity warnings (≤3 spots) |

**Rationale:** Warm stone + coral reads energetic and boutique (not neon “big box gym”). Charcoal keeps typography crisp on mobile. Coral is reserved almost exclusively for booking actions so the conversion path is visually obvious.

---

## Typography

| Role | Font | Weight / size | Notes |
|------|------|---------------|-------|
| Display | **Fraunces** | 600–700, 40–56px | Headlines with slight optical warmth |
| Body | **Source Sans 3** | 400/600, 16–18px | High legibility for schedules and forms |
| UI / labels | **Source Sans 3** | 600, 12–14px uppercase tracking | Class tags, filters, microcopy |

**Pairing rule:** One expressive serif for brand moments; one clean sans for everything interactive. Avoid mixing more than two families.

---

## Homepage wireframe outline

```
┌─────────────────────────────────────────────────────────┐
│  [Logo]   Classes  Schedule  Instructors  Pricing  [Book]│
├─────────────────────────────────────────────────────────┤
│  HERO (full-bleed studio photo, soft dark gradient)     │
│  Headline: “Small classes. Real progress.”              │
│  Sub: neighborhood boutique fitness · book in under 60s │
│  [Book a class]  [View today’s schedule]                │
├─────────────────────────────────────────────────────────┤
│  TODAY’S CLASSES (horizontal scroll cards on mobile)    │
│  Time · Class · Instructor · Spots left · [Reserve]     │
├─────────────────────────────────────────────────────────┤
│  WHY PULSE (3 benefit rows: size, coaching, community)  │
├─────────────────────────────────────────────────────────┤
│  CLASS TYPES (Pilates / Strength / Mobility tiles)      │
├─────────────────────────────────────────────────────────┤
│  INSTRUCTORS (photo + specialty + “next class” link)    │
├─────────────────────────────────────────────────────────┤
│  SOCIAL PROOF (short quotes + Google rating strip)      │
├─────────────────────────────────────────────────────────┤
│  FINAL CTA band: “Your next class is one tap away”      │
│  [Book now]                                             │
├─────────────────────────────────────────────────────────┤
│  Footer: hours, map pin, Instagram, email               │
└─────────────────────────────────────────────────────────┘
```

**Scroll priority:** Hero → live inventory of today’s classes → trust → secondary explore. Pricing is linked from nav but not forced into the first viewport.

---

## Key UI elements (UX → conversion)

1. **Sticky “Book a class” CTA**  
   Always visible on mobile after 20% scroll. Opens a bottom sheet with date → class → spot confirmation—not a separate multi-page maze.

2. **Live capacity badges**  
   “5 spots left” / “Waitlist” using coral vs amber. Scarcity is factual (from the booking system), not marketing fluff.

3. **Class cards with one primary action**  
   Each card has a single solid button (`Reserve`). Secondary info (duration, level) stays as text links to avoid competing CTAs.

4. **Filter chips on Schedule**  
   Morning / Evening / Beginner-friendly / Reformer. Chips update the list instantly; default filter = “Today.”

5. **Booking confirmation micro-flow**  
   Name + email + optional SMS reminder → confirmation screen with Add to Calendar + “Share with a friend” (referral without discount spam).

6. **Trust strip near first booking CTA**  
   Star rating + “Cancel up to 4 hours before” policy. Reduces hesitation for first-time bookers.

7. **Accessible focus & tap targets**  
   Minimum 44×44px controls; coral buttons meet WCAG contrast on charcoal/ivory surfaces; reduced-motion respects `prefers-reduced-motion` for card scrolls.

---

## Success criteria for this concept

- First-time visitor can book a class from the homepage in ≤3 taps on mobile.  
- Schedule inventory is the second content block (not buried below long brand essays).  
- Visual system is distinctive enough that removing the Pulse logo still feels like a boutique studio—not a template gym site.

---

*Prepared as a Vincere Media Works portfolio design sample.*
