defmodule DouyinExcavatorWeb.Router do
  use DouyinExcavatorWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DouyinExcavatorWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", DouyinExcavatorWeb do
     pipe_through :api

     post "/aweme", AwemeController, :index
  end
end
