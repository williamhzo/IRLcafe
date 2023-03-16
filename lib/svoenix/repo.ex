defmodule Svoenix.Repo do
  use Ecto.Repo,
    otp_app: :svoenix,
    adapter: Ecto.Adapters.Postgres
end
