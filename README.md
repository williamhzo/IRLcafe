# IRL café

[![CI](https://github.com/williamhzo/svoenix/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/williamhzo/svoenix/actions/workflows/CI.yml)

## Get started

1. Install dependencies: `mix deps.get`
2. Start database: `docker compose up -d db`
3. Create and migrate the database: `mix ecto.setup`
4. Start app: `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
