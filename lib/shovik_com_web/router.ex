defmodule ShovikComWeb.Router do
  use ShovikComWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ShovikCom.CurrentUserPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin do
    plug ShovikCom.Admin.ForceUserPlug
  end

  scope "/", ShovikComWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/blog", BlogController, only: [:index, :show]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
