defmodule ShovikCom.Repo.Migrations.AddPostImages do
  use Ecto.Migration

  def change do
    create table(:post_images) do
      add :post_id, :integer
      add :picture, :string

      timestamps()
    end
  end
end
