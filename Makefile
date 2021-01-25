#!/bin/bash

.PHONY: help

help:
	@echo "\033[32mmake install \033[0m- up containers and install all dependencies"
	@echo "\033[32mmake php \033[0m- go into php container"
	@echo "\033[32mmake cache \033[0m- clear cache (for dev and test environments)"

up:
	@echo "\033[32mStarting containers...\033[0m"
	@docker-compose up -d

install_sh:
	@docker-compose exec php ./app/bin/install.sh


install:
	@echo "\033[32mInstalling all...\033[0m"

	@echo "\033[33mUp containers...\033[0m"
	@docker-compose up -d --build --force-recreate


	@echo "\033[32mInstall shopware... \033[0m"
	@docker-compose exec php ./app/bin/install.sh
	@docker-compose exec php composer install

php:
	@echo "\033[32mEntering into php container...\033[0m"
	@docker-compose exec php bash

cache:
	@echo "\033[32mCleaning cache for dev and test enironments...\033[0m"
	@docker-compose exec -T php bin/console sw:cache:clear
	@docker-compose exec -T php bin/console sw:theme:cache:generate

