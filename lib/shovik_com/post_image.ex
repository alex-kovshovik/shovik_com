defmodule ShovikCom.PostImage do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  schema "post_images" do
    belongs_to :post, ShovikCom.Post

    field :picture, ShovikCom.Picture.Type
    field :primary, :boolean

    timestamps()
  end

  def changeset(post_image, params \\ %{}) do
    post_image
    |> cast(params, [:post_id, :primary])
    |> cast_attachments(params, [:picture])
    |> validate_required([:post_id, :picture])
  end

  def primary_image(query) do
    from c in query,
      where: c.primary == true
  end
end
