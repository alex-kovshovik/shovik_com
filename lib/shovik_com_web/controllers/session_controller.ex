defmodule ShovikComWeb.SessionController do
  use ShovikComWeb, :controller

  alias ShovikCom.Repo
  alias ShovikCom.User

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}})
  when not is_nil(email) and not is_nil(password) do
    User
    |> Repo.get_by(email: email)
    |> sign_in(password, conn)
  end

  def create(conn, _), do: failed_login(conn)

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> assign(:current_user, nil)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: page_path(conn, :index))
  end

  defp sign_in(user, _password, conn) when is_nil(user), do: failed_login(conn)

  defp sign_in(user, password, conn) do
    if checkpw(password, user.password_digest) do
      conn
      |> put_session(:current_user, %User{id: user.id})
      |> put_flash(:info, "Sign in successful!")
      |> redirect(to: page_path(conn, :index))
    else
      failed_login(conn)
    end
  end

  defp failed_login(conn) do
    dummy_checkpw()

    conn
    |> put_session(:current_user, nil)
    |> put_flash(:error, "Invalid email/password combination!")
    |> redirect(to: session_path(conn, :new))
    |> halt()
  end
end
