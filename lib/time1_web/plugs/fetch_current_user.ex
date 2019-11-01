defmodule LensWeb.Plugs.FetchCurrentUser do
  import Plug.Conn

  def init(args), do: args

  def call(conn, _args) do
    email = get_session(conn, :manager_email)
    IO.puts "email"
    IO.inspect email
    manager = Time1.Managers.get_manager_by_email(get_session(conn, :manager_email) || "")
    worker = Time1.Workers.get_worker_by_email(get_session(conn, :worker_email) || "")
    IO.inspect manager
    IO.inspect worker
    
    
    if manager == "" && worker == "" do
      assign(conn, :current_worker, nil)
    else
      if manager != "" do
        assign(conn, :current_manager, manager)
      else
        assign(conn, :current_worker, worker)
      end
      
    end
    # else
    #   assign(conn, :current_manager, nil)
    # end
  end
end