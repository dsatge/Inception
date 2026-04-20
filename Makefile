USER_NAME = $(USER)

# Swap path depending on Linux or Mac
ifeq ($(shell uname), Linux)
    DATA_PATH = /home/$(USER_NAME)/data
else
    DATA_PATH = /Users/$(USER_NAME)/data
endif

# --- VARIABLES ---
COMPOSE_FILE = srcs/docker-compose.yml
GREEN = \033[0;32m
RED = \033[0;31m
RESET = \033[0m

all: setup build

setup:
	@echo "$(GREEN)Détection de l'utilisateur : $(USER_NAME)$(RESET)"
	@echo "$(GREEN)Dossier de données : $(DATA_PATH)$(RESET)"
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@if ! grep -q "DATA_PATH" srcs/.env; then \
		echo "DATA_PATH=$(DATA_PATH)" >> srcs/.env; \
	fi

build:
	@echo "$(GREEN)Lancement de Docker Compose...$(RESET)"
	@DATA_PATH=$(DATA_PATH) docker-compose -f $(COMPOSE_FILE) up --build -d

stop:
	@echo "$(RED)Arrêt des conteneurs...$(RESET)"
	@docker-compose -f $(COMPOSE_FILE) stop

# clean: stop
# 	@echo "$(RED)Suppression des conteneurs...$(RESET)"
# 	@docker-compose -f $(COMPOSE_FILE) down

clean:
	@echo "$(RED)Suppression des conteneurs...$(RESET)"
	@DATA_PATH=$(DATA_PATH) docker-compose -f $(COMPOSE_FILE) down -v

fclean:
	@echo "$(RED)Arrêt et nettoyage complet...$(RESET)"
	@DATA_PATH=$(DATA_PATH) docker-compose -f $(COMPOSE_FILE) down -v
	@docker system prune -af
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	@echo "$(GREEN)Nettoyage terminé.$(RESET)"

re: fclean all

logs:
	@docker logs -f wordpress

.PHONY: all setup build stop clean fclean re logs