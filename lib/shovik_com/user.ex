defmodule ShovikCom.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    has_many :posts, ShovikCom.Post, foreign_key: :author_id

    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_digest, :string

    timestamps()

    # Virtual fields
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :first_name, :last_name, :password, :password_confirmation])
    |> validate_required([:email, :first_name, :last_name, :password, :password_confirmation])
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
      |> put_change(:password_digest, hashpwsalt(password))
    else
      changeset
    end
  end
end
