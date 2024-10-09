# selenium grid

Selenium Grid allows the execution of WebDriver scripts on remote machines (virtual or real) by routing commands sent by the client to remote browser instances. It aims to provide an easy way to run tests in parallel on multiple machines.

Selenium Grid allows us to run tests in parallel on multiple machines, and to manage different browser versions and browser configurations centrally (instead of in each individual test).

## bring up selenium grid

- To execute this docker compose yml file use `docker compose -f docker-compose-v3.yml up`
- Add the `-d` flag at the end for detached execution
- To stop the execution, hit Ctrl+C, and then `docker compose -f docker-compose-v3.yml down`
- to bring up specific driver

- docker compose -f selenium-grid-docker-compose.yml up -d --scale firefox=4
- navigate to http://localhost:4444/grid/console