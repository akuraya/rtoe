defmodule RtoeWeb.Router do
  use RtoeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RtoeWeb do
    pipe_through :api
  end
end
