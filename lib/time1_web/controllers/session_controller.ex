defmodule Time1Web.SessionController do
    use Time1Web, :controller
  
    def new(conn, %{"type" => t}) do
      cond do
        t == "manager" ->
          render(conn, "new_manager.html")
        t == "worker" ->
          render(conn, "new_worker.html")
      end
      
    end
  
    def create(conn, %{"email" => email}) do
      manager = Time1.Managers.get_manager_by_email(email)
      if manager do
        conn
        |> put_session(:manager_id, manager.id)
        |> put_flash(:info, "Welcome back #{manager.email}")
        |> redirect(to: Routes.page_path(conn, :manager_page))
      else
        conn
        |> put_flash(:error, "Login failed.")
        |> redirect(to: Routes.page_path(conn, :index))
      end
    end
  
    def delete(conn, _params) do
      conn
      |> delete_session(:manager_id)
      |> put_flash(:info, "Logged out.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end