defmodule Peepchat.Router do
  use Peepchat.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Peepchat do
    pipe_through :api

    # registration
    post "/register", RegistrationController, :create

    # login
    post "/token", SessionController, :create, as: :login
  end
end
