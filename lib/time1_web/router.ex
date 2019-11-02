defmodule Time1Web.Router do
  use Time1Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug Time1Web.Plugs.FetchCurrentWorker
    plug Time1Web.Plugs.FetchCurrentManager
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Time1Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/manager_page", PageController, :manager_page
    get "/worker_page", PageController, :worker_page
    resources "/managers", ManagerController
    resources "/workers", WorkerController
    resources "/jobs", JobController
    resources "/sheets", SheetController
    resources "/tasks", TaskController

    get "/sheet/worker_sheet_list", SheetController, :worker_sheet_list
    get "/sheet/worker_task_list", SheetController, :worker_task_list
    get "/sheet/manager_sheet_list", SheetController, :manager_sheet_list
    get "/sheet/manager_task_list", SheetController, :manager_task_list
    get "/sheet/manager_approve_sheet", SheetController, :manager_approve_sheet
    get "/sheet/create_sheet_success", SheetController, :create_sheet_success

  
    get "/worker/manager_worker_list", WorkerController, :manager_worker_list
    

    resources "/sessions", SessionController, 
      only: [:new, :create, :delete], singleton: true
  end

  # Other scopes may use custom stacks.
  # scope "/api", Time1Web do
  #   pipe_through :api
  # end
end
