# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ShovikCom.Repo.insert!(%ShovikCom.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Ecto.Query

alias ShovikCom.Repo
alias ShovikCom.User

find_or_create_user = fn email ->
  case Repo.all(from u in User, where: u.email == ^email) do
    [] ->
      %User{}
      |> User.changeset(%{email: "alex@shovik.com",
                          first_name: "Alex",
                          last_name: "Kovshovik",
                          password: "12341234",
                          password_confirmation: "12341234"})
      |> Repo.insert!
    _ ->
      IO.puts "User #{email} already exists, skipping"
  end
end

find_or_create_user.("alex@shovik.com")
