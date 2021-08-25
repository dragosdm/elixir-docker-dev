# Local development environment for Elixir/Phoenix

This is my setup for local dev environment for elixir/phoenix. My goal is to have a repeatable process for setting up and developing elixir projects independently of the local machine.

## How I work
For local development, I create a docker image called `phoenix:VERSION` (where VERSION is the Phoenix version I'm using or just `latest`) from the Dockerfile in this repo. I do all the work from the terminal (interactive terminal) in this docker container.

## Creating new projects
There are 4 files in this repo: `.env`, `Dockerfile`, `docker-compose.yml` and `Makefile` and I have 2 was for creating new projects:

1. Clone this repo
2. Edit `.env` file 
3. Chose one of the following paths:
    - Everything from `make`
        - `make setup`
        - edit `$APP_NAME/config/dev.exs`
        - `cd $APP_NAME`
        - `docker compose --env-file ../.env up`
    - Interactive way
        - `make cli`
        - `Mix`: `mix new new_mix_project` *OR*
        - `Phoenix`: `mix phx.new new_phx_project --install --live`
        - now you have a new folder called `new_mix_project` and you can `eixt` the container or run mix phx.server and play with it
        - copy `docker-compose.yml` to your newly created folder `cp docker-compose.yml new_$TYPE_project`
4. Edit `config/dev.exs` and change `host` from `localhost` to `db`
5. `docker compose build` - to build the images that docker compose will use.
6. `docker compose up` - will start the phoenix app and the postgres container and all being well, you can start development.
7. `docker run --interactive --tty --rm --volume $(pwd):/app phoenix:$TAG` will give you an elixir environment where you can run other `mix` tasks or `iex` sessions

## Other useful docker commands
- show running containers: `docker compose ps`
- shut down everything: `docker compose down`
- rebuild the container before start: `docker compose up --build`
- start db only: `docker compose up db`
