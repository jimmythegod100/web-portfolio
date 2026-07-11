# Application Development Case Study — LocalBites

**Agency:** Vincere Media Works  
**Role:** Software Architect  
**Concept:** Local food delivery app optimized for small restaurants and cafés  
**Audience:** Portfolio / proposal technical outline (mock product)

---

## Problem framing

National delivery platforms take high commissions and bury independent kitchens in generic discovery feeds. LocalBites is a city-scoped app where small businesses own their storefront experience, keep more margin, and push real-time order status to customers without enterprise complexity.

---

## User workflow (account creation → checkout)

### 1. Account creation
- Sign up with email or phone (OTP).
- Optional Apple/Google SSO.
- Collect delivery address + default tip preference.
- Push notification permission requested after first successful order (not on splash).

### 2. Discovery
- Home feed: open-now merchants within delivery radius, sorted by ETA then rating.
- Search + filters: cuisine, dietary tags, pickup vs delivery, under-$15 meals.
- Merchant page: menu sections, prep-time estimate, minimum order, photo gallery.

### 3. Cart & customization
- Item modifiers (size, add-ons, notes) validated against merchant rules.
- Cart persists locally; revalidated when merchant hours or item availability change.
- Promo codes applied at cart; tax/fees shown before payment.

### 4. Checkout
- Confirm address on map pin (adjustable).
- Choose delivery window or “ASAP.”
- Pay via card (Stripe PaymentSheet) or cash-on-delivery where merchant allows.
- Order placed → confirmation screen with live status timeline.

### 5. Post-order
- Track driver/courier ETA.
- In-app support thread tied to `order_id`.
- Rate meal + courier; ratings feed merchant dashboard (not public flame wars).

**Merchant-side parallel flow:** Accept/reject → prep timer → ready for pickup → handoff to courier → complete.

---

## Recommended technical stack

| Layer | Choice | Why |
|-------|--------|-----|
| Mobile apps | React Native (Expo) | One codebase for iOS/Android; fast SMB iteration |
| Merchant web | Next.js (React) | Dashboard for menus, hours, orders on desktop |
| API | Node.js + NestJS (or FastAPI) | Clear module boundaries for orders, payments, users |
| Primary DB | PostgreSQL | Relational integrity for orders, inventory, settlements |
| Cache / sessions | Redis | Cart locks, rate limits, OTP, pub/sub fan-out |
| Realtime | WebSockets (Socket.IO or native WS) + FCM/APNs | Live tracking + push fallback |
| Maps / ETA | Mapbox or Google Maps Platform | Geocoding, distance matrix, courier map |
| Payments | Stripe Connect | Marketplace splits to small businesses |
| Media | S3-compatible object storage + CDN | Menu photos |
| Observability | OpenTelemetry + structured logs | Trace order failures end-to-end |

---

## Architecture: real-time order tracking

```
[Customer App] ──WS──┐
[Courier App] ──WS──┼──► Realtime Gateway ──► Redis pub/sub
[Merchant POS] ─WS──┘              │
                                   ▼
                            Order Service ◄──► PostgreSQL
                                   │
                     status events: placed → accepted →
                     preparing → ready → picked_up → delivered
                                   │
                                   ▼
                         Push Worker (FCM/APNs)
```

### How tracking works

1. **Order state machine** lives in the Order Service. Every transition is an append-only event (`order_events`) plus a current `orders.status` column for fast reads.
2. **Realtime Gateway** subscribes to Redis channels keyed by `order:{id}` and `merchant:{id}`. Clients join rooms only for orders they are authorized to see (JWT-scoped).
3. **Courier location** (optional MVP+): courier app posts GPS every N seconds; gateway broadcasts a throttled location payload to the customer room. ETA recalculated by Maps distance matrix on a short interval, not on every GPS tick.
4. **Fallback:** if the WebSocket drops, the app polls `GET /orders/:id` every 15s and still receives push notifications on major state changes.
5. **Idempotency:** checkout and status updates use idempotency keys so flaky mobile networks don’t double-charge or duplicate orders.

### Security & tenancy notes
- Merchants are isolated by `merchant_id` on every query.
- Customers cannot subscribe to another user’s order channel.
- Payment webhooks update order state only after Stripe signature verification.

---

## MVP scope vs later

| MVP | Later |
|-----|-------|
| Delivery + pickup in one city | Multi-city expansion |
| Stripe card payments | Wallets, store credit |
| Manual courier assignment | Auto-dispatch optimization |
| Basic merchant dashboard | Inventory sync / POS plugins |

---

## Business outcome (concept targets)

- Lower commission than national aggregators for participating SMBs.  
- Faster “order → first status update” under 10 seconds via WebSockets.  
- Transparent tracking that reduces “where is my food?” support volume.

---

*Prepared as a Vincere Media Works application development portfolio sample.*
