.DEFAULT_GOAL := compose

clean:
	docker system prune -a -f

compose:
	docker-compose up --build -d

start:
	docker-compose start

stop:
	docker-compose stop

rebuild: stop clean compose
