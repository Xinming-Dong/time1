# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Time1.Repo.insert!(%Time1.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Time1.Repo
alias Time1.Managers.Manager

Repo.insert!(%Manager{name: "Alice", email: "alice@acme.com"})
Repo.insert!(%Manager{name: "Bob", email: "bob@acme.com"})
