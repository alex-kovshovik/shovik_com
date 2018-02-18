defmodule ShovikCom.CurrentUserPlug do
  @moduledoc """
  Loads current user before every request.
  """
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  alias ShovikCom.Repo
  alias ShovikCom.User

  def init(default), do: default
  def call(conn, _opts) do
    if session_user = get_session(conn, :current_user) do
      load_current_user(conn, session_user)
    else
      conn
    end
  end

  defp load_current_user(conn, session_user) do
    db_user = Repo.get(User, session_user.id)

    if db_user do
      conn
      |> assign(:current_user, db_user)
    else
      conn
      |> put_flash(:error, "You're not logged in")
      |> redirect(to: "/sessions/new")
      |> halt
    end
  end
end
