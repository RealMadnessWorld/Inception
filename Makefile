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

up:
	@docker network create inception-network
	@cd srcs && docker-compose up --build -d
	@echo "$(_GREEN)-----docker up-----$(_RESET)"

down:
	@docker network rm inception-network
	@cd srcs && docker-compose down
	@echo "$(_RED)-----docker down-----$(_RESET)"