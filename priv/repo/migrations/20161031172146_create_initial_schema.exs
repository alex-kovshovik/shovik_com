defmodule ShovikCom.Repo.Migrations.CreateInitialSchema do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :password_digest, :string

      timestamps()
    end

    create index(:users, [:email])
    create index(:users, [:last_name, :first_name])

    create table(:posts) do
      add :title, :string
      add :url, :string
      add :body, :text
      add :author_id, references(:users)
      add :publish_at, :datetime

      timestamps()
    end

    create index(:posts, [:author_id])
    create index(:posts, [:publish_at])
  end
end
