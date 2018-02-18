defmodule ShovikCom.Repo.Migrations.CreatePostPreviewField do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :preview, :text, default: :false
    end
  end
end
