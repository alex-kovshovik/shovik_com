defmodule ShovikCom.Post do
  use Ecto.Schema

  import Ecto.Changeset

  schema "posts" do
    belongs_to :author, ShovikCom.User
    has_many :post_images, ShovikCom.PostImage
    has_one :primary_image, ShovikCom.PostImage

    field :title, :string
    field :url, :string
    field :preview, :string
    field :body, :string
    field :publish_at, Timex.Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(post, params \\ %{}) do
    post
    |> cast(params, [:title, :url, :preview, :body, :publish_at, :author_id])
    |> validate_required([:title, :url, :preview, :body, :author_id])
  end

  def cache_key(post) do
    "post-#{post.id}-#{post.updated_at}"
  end
end
