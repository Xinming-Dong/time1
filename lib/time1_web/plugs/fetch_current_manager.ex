defmodule Time1Web.Plugs.FetchCurrentManager do
    import Plug.Conn
  
    def init(args), do: args
  
    def call(conn, _args) do
      email = get_session(conn, :manager_email)
      IO.puts "email"
      IO.inspect email
      manager = Time1.Managers.get_manager_by_email(get_session(conn, :manager_email) || "")
      if manager do
        assign(conn, :current_manager, manager)
      else
        assign(conn, :current_manager, nil)
      end
    end
  end