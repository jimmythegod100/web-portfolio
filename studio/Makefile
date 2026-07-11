.PHONY: up down logs health new-client bootstrap ps

up:
	docker compose up --build -d

down:
	docker compose down

logs:
	docker compose logs -f studio-api

ps:
	docker compose ps

health:
	curl -s http://localhost:$${STUDIO_API_PORT:-8000}/health | python3 -m json.tool

bootstrap:
	./scripts/bootstrap-imac.sh

new-client:
	@test -n "$(NAME)" || (echo 'Usage: make new-client NAME=client-slug'; exit 1)
	./scripts/new-client.sh "$(NAME)"
