OS = $(shell uname)

ifeq ($(OS), Linux)
		_RED	= \e[31;5;184m
		_GREEN	= \e[38;5;46m
		_YELLOW	= \e[38;5;184m
		_RESET	= \e[0m
else
		_RED	= \x1b[31m
		_GREEN	= \x1b[32m
		_YELLOW	= \x1b[33m
		_RESET	= \x1b[0m
endif

all:	up

up: setup_vols
	@if [ -f ./srcs/.env ]; then \
			docker network create inception-network; \
			cd srcs && docker-compose up --build -d; \
			cd requirements/tools && sudo bash hosts.sh add; \
			echo "$(_GREEN)-------------------------------------------$(_RESET)"; \
			echo "$(_GREEN)-------------------------------------------$(_RESET)"; \
			echo "$(_GREEN)-----------------Docker up-----------------$(_RESET)"; \
			echo "$(_GREEN)-------------------------------------------$(_RESET)"; \
			echo "$(_GREEN)-------------------------------------------$(_RESET)"; \
		else \
			echo "$(_RED)Missing .env file!$(_RESET)"; \
	fi

down:
	@docker network rm inception-network || true
	@cd srcs && docker-compose down --rmi all || true
	@cd srcs/requirements/tools && sudo bash hosts.sh delete || true
	@echo "$(_RED)-------------------------------------------$(_RESET)"
	@echo "$(_RED)-------------------------------------------$(_RESET)"
	@echo "$(_RED)----------------Docker down----------------$(_RESET)"
	@echo "$(_RED)-------------------------------------------$(_RESET)"
	@echo "$(_RED)-------------------------------------------$(_RESET)"

delete: down del_vols

re: down up

delre: delete up

setup_vols:
	@sudo mkdir -p /home/${USER}/data/mariadb_volume
	@sudo mkdir -p /home/${USER}/data/wordpress_volume
	@echo volumes created

del_vols:
	@sudo rm -rf /home/${USER}/data/mariadb_volume
	@sudo rm -rf /home/${USER}/data/wordpress_volume
	@sudo rm -rf /home/${USER}/data
	docker volume rm `docker volume ls -q` || true
	docker rmi -f `docker image ls -qa` || true
	docker rm `docker ps -qa` || true
	@echo volumes deleted

maria:
	@docker exec -it mariadb bash

nginx:
	@docker exec -it nginx bash

wordpress:
	@docker exec -it wordpress bash

logs:
	docker-compose --project-directory srcs/ logs --follow