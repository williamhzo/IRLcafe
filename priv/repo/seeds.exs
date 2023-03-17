# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Svoenix.Repo.insert!(%Svoenix.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# insert cities "Lisbon", "Paris" and "London" as database seeds
[
  %{name: "Lisbon", slug: "lisbon"},
  %{name: "Paris", slug: "paris"},
  %{name: "London", slug: "london"}
]
|> Enum.map(&Svoenix.Cities.create_city/1)
