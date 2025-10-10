COMPOSE_FILE = srcs/compose.yaml

.PHONY: all up down fclean re logs


all: up

up:
	docker compose -f $(COMPOSE_FILE) up --build -d

stop:
	docker compose -f $(COMPOSE_FILE) stop

down:
	docker compose -f $(COMPOSE_FILE) down


fclean:
	docker compose -f $(COMPOSE_FILE) down -v


re: fclean all

logs:
	docker compose -f $(COMPOSE_FILE) logs -f
