defmodule ShovikComWeb.BlogController do
  use ShovikComWeb, :controller

  alias ShovikCom.Repo
  alias ShovikCom.Post

  import Ecto.Query

  def index(conn, params) do
    page =
      posts_query()
      |> Repo.paginate(params)

    render conn, "index.html", page: page, title: "Blog"
  end

  def show(conn, %{"id" => id}) do
    id = id |> String.split("-") |> hd

    post =
      Post
      |> Repo.get!(id)
      |> Repo.preload(:author)

    render conn, "show.html", post: post, title: post.title
  end

  defp posts_query do
    now = Timex.now

    from p in Post,
    where: p.publish_at <= ^now,
    order_by: [desc: p.publish_at],
    preload: [:author]
  end
end
