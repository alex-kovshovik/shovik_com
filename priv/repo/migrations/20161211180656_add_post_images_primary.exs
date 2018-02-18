defmodule ShovikCom.Repo.Migrations.AddPostImagesPrimary do
  use Ecto.Migration

  def change do
    alter table(:post_images) do
      add :primary, :boolean, default: :false
    end
  end
end
