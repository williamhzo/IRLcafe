defmodule Svoenix.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix installed.
  """

  @app :svoenix

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  def seed do
    :code.priv_dir(:svoenix)
    |> Path.join(["repo/seeds.exs"])
    |> Code.eval_file()
  end

  ### Helpers

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
