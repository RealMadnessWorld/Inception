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
			cd ../tools && sudo bash hosts.sh add; \
			echo "$(_GREEN)-------------------------------------------$(_RESET)"; \
			echo "$(_GREEN)-------------------------------------------$(_RESET)"; \
			echo "$(_GREEN)-----------------Docker up-----------------$(_RESET)"; \
			echo "$(_GREEN)-------------------------------------------$(_RESET)"; \
			echo "$(_GREEN)-------------------------------------------$(_RESET)"; \
		else \
			echo "$(_RED)Missing .env file!$(_RESET)"; \
	fi

down:
	@docker network rm inception-network
	@cd srcs && docker-compose down
	@cd tools && sudo bash hosts.sh delete
	@echo "$(_RED)-------------------------------------------$(_RESET)"
	@echo "$(_RED)-------------------------------------------$(_RESET)"
	@echo "$(_RED)----------------Docker down----------------$(_RESET)"
	@echo "$(_RED)-------------------------------------------$(_RESET)"
	@echo "$(_RED)-------------------------------------------$(_RESET)"

delete: down del_vols

setup_vols:
	@sudo mkdir -p /home/flirt/data/mariadb_volume
	@sudo mkdir -p /home/flirt/data/wordpress_volume
	@echo volumes created

del_vols:
	@sudo rm -rf /home/flirt/data/mariadb_volume
	@sudo rm -rf /home/flirt/data/wordpress_volume
	@echo volumes deleted