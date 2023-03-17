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

[
  %{
    city: "lisbon",
    label: "Lisbon Cafe",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "lisbon",
    label: "Lisbon Bar",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "lisbon",
    label: "Lisbon Restaurant",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "paris",
    label: "Paris Cafe",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "paris",
    label: "Paris Bar",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "paris",
    label: "Paris Restaurant",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "london",
    label: "London Cafe",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "london",
    label: "London Bar",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "london",
    label: "London Restaurant",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  }
]
|> Enum.map(&Svoenix.Places.create_place/1)
