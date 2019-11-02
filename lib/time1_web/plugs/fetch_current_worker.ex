defmodule Time1Web.Plugs.FetchCurrentWorker do
  import Plug.Conn

  def init(args), do: args

  def call(conn, _args) do
    email = get_session(conn, :worker_email)
    IO.puts "email"
    IO.inspect email
    worker = Time1.Workers.get_worker_by_email(get_session(conn, :worker_email) || "")
    if worker do
      assign(conn, :current_worker, worker)
    else
      assign(conn, :current_worker, nil)
    end
  end
end