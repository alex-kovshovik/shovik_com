defmodule ShovikCom.Admin.ForceUserPlug do
  @moduledoc """
  Forces the logged in user for all controllers that use this plug
  """
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  alias ShovikComWeb.LayoutView

  def init(default), do: default
  def call(conn, _opts) do
    if LayoutView.current_user(conn) do
      conn
    else
      conn
      |> put_flash(:error, "You are not authorized, kindly navigate away.")
      |> redirect(to: "/")
      |> halt
    end
  end
end
