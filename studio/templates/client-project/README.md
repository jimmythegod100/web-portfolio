# __CLIENT_NAME__

Custom site scaffold generated from `studio/templates/client-project`.

## Run on iMac

```bash
cp .env.example .env
docker compose up --build
```

- Site: http://localhost:8088  
- API docs: http://localhost:8001/docs  
- Health: http://localhost:8088/health  

## Customize

1. Replace copy in `frontend/index.html`
2. Adjust colors/fonts in `frontend/css/style.css` (`:root` variables)
3. Extend API routes in `backend/app/routers/`
