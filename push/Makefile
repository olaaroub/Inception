COMPOSE_FILE = srcs/compose.yaml

all: up

up:
	docker compose -f $(COMPOSE_FILE) up --build -d

stop:
	docker compose -f $(COMPOSE_FILE) stop

down:
	docker compose -f $(COMPOSE_FILE) down

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

clean:
	docker compose -f $(COMPOSE_FILE) down -v

re: fclean all

.PHONY: all up stop down logs clean re
