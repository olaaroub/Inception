COMPOSE_FILE = srcs/compose.yaml



all: up

up:
	docker compose -f $(COMPOSE_FILE) up --build -d

stop:
	docker compose -f $(COMPOSE_FILE) stop

down:
	docker compose -f $(COMPOSE_FILE) down

fclean:
	docker compose -f $(COMPOSE_FILE) down -v


logs:
	docker compose -f $(COMPOSE_FILE) logs -f

re: fclean all

.PHONY: all up down fclean re logs
