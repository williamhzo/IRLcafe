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
    slug: "lisbon-cafe",
    label: "Lisbon Cafe",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "lisbon",
    slug: "lisbon-bar",
    label: "Lisbon Bar",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "lisbon",
    slug: "lisbon-restaurant",
    label: "Lisbon Restaurant",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "paris",
    slug: "paris-cafe",
    label: "Paris Cafe",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "paris",
    slug: "paris-bar",
    label: "Paris Bar",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "paris",
    slug: "paris-restaurant",
    label: "Paris Restaurant",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "london",
    slug: "london-cafe",
    label: "London Cafe",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "london",
    slug: "london-bar",
    label: "London Bar",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  },
  %{
    city: "london",
    slug: "london-restaurant",
    label: "London Restaurant",
    description: "The best place in town",
    x: "34.9899",
    y: "23.9899"
  }
]
|> Enum.map(&Svoenix.Places.create_place/1)
