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
  
    def create(conn, %{"type" => type, "email" => email}) when type == "manager" do
      manager = Time1.Managers.get_manager_by_email(email)
      manager = Time1.Managers.authenticate(email)
      
      if manager do
        conn
        |> put_session(:manager_email, manager.email)
        |> put_session(:manager_id, manager.id)
        |> put_flash(:info, "Welcome back #{manager.email}")
        |> redirect(to: Routes.page_path(conn, :manager_page))
      else
        conn
        |> put_flash(:error, "Login failed.")
        |> redirect(to: Routes.page_path(conn, :index))
      end
    end

    def create(conn, %{"type" => type, "email" => email}) when type == "worker" do
      worker = Time1.Workers.get_worker_by_email(email)
      worker = Time1.Workers.authenticate(email)
      job_codes = Time1.Jobs.list_job_codes()
      if worker do
        conn
        |> put_session(:worker_email, worker.email)
        |> put_session(:worker_id, worker.id)
        |> put_flash(:info, "Welcome back #{worker.email}")
        |> redirect(to: Routes.page_path(conn, :worker_page, job_codes: job_codes))
      else
        conn
        |> put_flash(:error, "Login failed.")
        |> redirect(to: Routes.page_path(conn, :index))
      end
    end
  
    def delete(conn, %{"type" => type}) when type == "worker" do
      conn
      |> delete_session(:worker_id)
      |> delete_session(:worker_email)
      |> put_flash(:info, "Logged out.")
      |> redirect(to: Routes.page_path(conn, :index))
    end

    def delete(conn, %{"type" => type}) when type == "manager" do
      conn
      |> delete_session(:manager_id)
      |> delete_session(:manager_email)
      |> put_flash(:info, "Logged out.")
      |> redirect(to: Routes.page_path(conn, :index))
    end
  end