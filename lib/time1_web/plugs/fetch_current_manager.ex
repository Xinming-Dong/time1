defmodule Time1Web.Plugs.FetchCurrentManager do
    import Plug.Conn
  
    def init(args), do: args
  
    def call(conn, _args) do
      manager = Time1.Managers.get_manager(get_session(conn, :manager_id) || -1)
      if manager do
        assign(conn, :current_manager, manager)
      else
        assign(conn, :current_manager, nil)
      end
    end
  end