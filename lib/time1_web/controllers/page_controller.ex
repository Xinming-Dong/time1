defmodule Time1Web.PageController do
  use Time1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
