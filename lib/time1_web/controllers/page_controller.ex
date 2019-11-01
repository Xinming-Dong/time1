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

  def worker_page(conn, %{"job_codes" => job_codes}) do
    IO.puts "worker page function in page controller."
    render(conn, "worker_page.html", job_codes: job_codes)
  end
end
