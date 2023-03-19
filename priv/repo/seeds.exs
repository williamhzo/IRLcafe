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

alias Svoenix.Repo
alias Svoenix.Accounts.User
alias Svoenix.Cities
alias Svoenix.Places

# insert users
Repo.insert(
  %User{
    email: "basile@irl.cafe",
    hashed_password: Bcrypt.hash_pwd_salt("hellohellohello")
  },
  on_conflict: :nothing
)

Repo.insert(
  %User{
    email: "william@irl.cafe",
    hashed_password: Bcrypt.hash_pwd_salt("hellohellohello")
  },
  on_conflict: :nothing
)

# insert cities "Lisbon", "Paris" and "London" as database seeds
case Enum.map(
       [
         %{name: "Lisbon", slug: "lisbon"},
         %{name: "Paris", slug: "paris"},
         %{name: "London", slug: "london"}
       ],
       &Cities.create_city/1
     ) do
  [{:ok, lisbon}, {:ok, paris}, {:ok, london}] ->
    Enum.map(
      [
        %{
          city_id: lisbon.id,
          slug: "lisbon-cafe",
          label: "Lisbon Cafe",
          description: "The best place in town",
          img_url:
            "https://images.unsplash.com/photo-1509870449717-5609536a5393?ixid=Mnw0MjQxMjF8MHwxfHNlYXJjaHwzfHxsaXNib24lMjBjYWZlfGVufDB8fHx8MTY3OTE3MTIzMg&ixlib=rb-4.0.3",
          x: "34.9899",
          y: "23.9899"
        },
        %{
          city_id: lisbon.id,
          slug: "lisbon-bar",
          label: "Lisbon Bar",
          description: "The best place in town",
          img_url:
            "https://images.unsplash.com/photo-1619834092768-9ee9d433d8b1?ixid=Mnw0MjQxMjF8MHwxfHNlYXJjaHwxfHxsaXNib24lMjBiYXJ8ZW58MHx8fHwxNjc5MTcxMjY5&ixlib=rb-4.0.3",
          x: "34.9899",
          y: "23.9899"
        },
        %{
          city_id: lisbon.id,
          slug: "lisbon-restaurant",
          label: "Lisbon Restaurant",
          description: "The best place in town",
          img_url:
            "https://images.unsplash.com/photo-1584346133934-a3afd2a33c4c?ixid=Mnw0MjQxMjF8MHwxfHNlYXJjaHwxMHx8bGlzYm9uJTIwcmVzdGF1cmFudHxlbnwwfHx8fDE2NzkxNzEyOTg&ixlib=rb-4.0.3",
          x: "34.9899",
          y: "23.9899"
        },
        %{
          city_id: paris.id,
          slug: "paris-cafe",
          label: "Paris Cafe",
          description: "The best place in town",
          img_url:
            "https://images.unsplash.com/photo-1509870449717-5609536a5393?ixid=Mnw0MjQxMjF8MHwxfHNlYXJjaHwzfHxsaXNib24lMjBjYWZlfGVufDB8fHx8MTY3OTE3MTIzMg&ixlib=rb-4.0.3",
          x: "34.9899",
          y: "23.9899"
        },
        %{
          city_id: paris.id,
          slug: "paris-bar",
          label: "Paris Bar",
          description: "The best place in town",
          img_url:
            "https://images.unsplash.com/photo-1619834092768-9ee9d433d8b1?ixid=Mnw0MjQxMjF8MHwxfHNlYXJjaHwxfHxsaXNib24lMjBiYXJ8ZW58MHx8fHwxNjc5MTcxMjY5&ixlib=rb-4.0.3",
          x: "34.9899",
          y: "23.9899"
        },
        %{
          city_id: paris.id,
          slug: "paris-restaurant",
          label: "Paris Restaurant",
          description: "The best place in town",
          img_url:
            "https://images.unsplash.com/photo-1619834092768-9ee9d433d8b1?ixid=Mnw0MjQxMjF8MHwxfHNlYXJjaHwxfHxsaXNib24lMjBiYXJ8ZW58MHx8fHwxNjc5MTcxMjY5&ixlib=rb-4.0.3",
          x: "34.9899",
          y: "23.9899"
        },
        %{
          city_id: london.id,
          slug: "london-cafe",
          label: "London Cafe",
          description: "The best place in town",
          img_url:
            "https://images.unsplash.com/photo-1584346133934-a3afd2a33c4c?ixid=Mnw0MjQxMjF8MHwxfHNlYXJjaHwxMHx8bGlzYm9uJTIwcmVzdGF1cmFudHxlbnwwfHx8fDE2NzkxNzEyOTg&ixlib=rb-4.0.3",
          x: "34.9899",
          y: "23.9899"
        },
        %{
          city_id: london.id,
          slug: "london-bar",
          label: "London Bar",
          description: "The best place in town",
          img_url:
            "https://images.unsplash.com/photo-1619834092768-9ee9d433d8b1?ixid=Mnw0MjQxMjF8MHwxfHNlYXJjaHwxfHxsaXNib24lMjBiYXJ8ZW58MHx8fHwxNjc5MTcxMjY5&ixlib=rb-4.0.3",
          x: "34.9899",
          y: "23.9899"
        },
        %{
          city_id: london.id,
          slug: "london-restaurant",
          label: "London Restaurant",
          description: "The best place in town",
          img_url:
            "https://images.unsplash.com/photo-1584346133934-a3afd2a33c4c?ixid=Mnw0MjQxMjF8MHwxfHNlYXJjaHwxMHx8bGlzYm9uJTIwcmVzdGF1cmFudHxlbnwwfHx8fDE2NzkxNzEyOTg&ixlib=rb-4.0.3",
          x: "34.9899",
          y: "23.9899"
        }
      ],
      &Places.create_place/1
    )

  _ ->
    :noop
end
