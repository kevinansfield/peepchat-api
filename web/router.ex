defmodule Peepchat.Router do
  use Peepchat.Web, :router

  # unauthenticated requests
  pipeline :api do
    plug :accepts, ["json", "json-api"]
  end

  # authenticated requests
  pipeline :api_auth do
    plug :accepts, ["json", "json-api"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  # unauthenticated requests
  scope "/api", Peepchat do
    pipe_through :api

    # registration
    post "/register", RegistrationController, :create

    # login
    post "/token", SessionController, :create, as: :login
  end

  # authenticated requests
  scope "/api", Peepchat do
    pipe_through :api_auth

    get "/user/current", UserController, :current
  end
end
