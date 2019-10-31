defmodule Time1Web.PageController do
  use Time1Web, :controller

  def index(conn, _params) do
    IO.puts "index function in page controller."
    render(conn, "index.html")
  end

  def manager_page(conn, _params) do
    IO.puts "manager page function in page controller."
    render(conn, "manager_page.html")
  end
end
