defmodule ShovikComWeb.BlogView do
  use ShovikComWeb, :view

  import Ecto
  import Scrivener.HTML

  alias ShovikCom.Repo
  alias ShovikCom.Post
  alias ShovikCom.PostImage

  def render_post(post) do
    cache_key = Post.cache_key(post)

    {status, cached_post} =
      Cachex.get(:shovik_cache, cache_key)

    case status do
      :ok ->
        cached_post

      _ ->
        post_body = markdown(post.body)
        Cachex.set(:shovik_cache, cache_key, post_body)
        post_body
    end
  end

  def markdown(body) do
    body
    |> Earmark.as_html!(%Earmark.Options{breaks: true})
    |> raw
  end

  def format_posted_at(publish_at) do
    {:ok, date_string} = publish_at |> Timex.format("{YYYY}-{M}-{D}")
    date_string
  end

  def post_url(post) do
    "#{post.id}-#{post.url}"
  end

  def post_preview(post) do
    post.preview
    |> markdown
  end

  def post_image(post) do
    post
    |> assoc(:post_images)
    |> PostImage.primary_image
    |> Repo.one
    |> post_image_url
  end

  def post_image_url(image) when is_nil(image), do: nil
  def post_image_url(image), do: ShovikCom.Picture.url({image.picture, image}, :thumb)
end
