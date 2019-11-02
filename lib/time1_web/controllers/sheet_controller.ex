defmodule Time1Web.SheetController do
  use Time1Web, :controller

  alias Time1.Sheets
  alias Time1.Sheets.Sheet

  def index(conn, %{"job_codes" => job_codes}) do
    # sheets = Sheets.list_sheets()
    render(conn, "index.html", job_codes: job_codes)
  end

  def worker_sheet_list(conn, _params) do
    worker_id = get_session(conn, :worker_id)
    sheets = Time1.Sheets.get_sheet_by_worker_id(worker_id)
    render(conn, "worker_sheet_list.html", worker_id: worker_id, sheets: sheets)
  end

  def worker_task_list(conn, %{"sheet_id" => sheet_id}) do
    {a, _} = Integer.parse(sheet_id)
    tasks = Time1.Tasks.get_task_by_sheet_id(a)
    tasks = Enum.map(tasks, fn ts -> {
      %{hour: ts.hour, job_code: Time1.Jobs.get_code_by_id(ts.job_id)}
    } end)
    render(conn, "worker_task_list.html", sheet_id: sheet_id, tasks: tasks)
  end

  def manager_sheet_list(conn, %{"worker_id"=> worker_id}) do
    {a, _} = Integer.parse(worker_id)
    sheets = Time1.Sheets.get_sheet_by_worker_id(a)
    render(conn, "manager_sheet_list.html", worker_id: worker_id, sheets: sheets)
  end

  def manager_task_list(conn, %{"sheet_id" => sheet_id}) do
    {a, _} = Integer.parse(sheet_id)
    tasks = Time1.Tasks.get_task_by_sheet_id(a)
    tasks = Enum.map(tasks, fn ts -> {
      %{hour: ts.hour, job_code: Time1.Jobs.get_code_by_id(ts.job_id)}
    } end)
    render(conn, "manager_task_list.html", sheet_id: sheet_id, tasks: tasks)
  end

  def manager_approve_sheet(conn, %{"sheet_id" => sheet_id}) do
    # change sheet approve_status
    IO.puts "aaaaaprove"
    IO.inspect sheet_id
    {a, _} = Integer.parse(sheet_id)
    
    Time1.Sheets.approve_sheet_by_id(a)
    render(conn, "manager_approve_sheet.html")

    # change job budget
  end

  def new(conn, _params) do
    changeset = Sheets.change_sheet(%Sheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sheet" => sheet_params}) do
    # IO.inspect conn
    sheet_params = Map.put(sheet_params, "worker_id", conn.assigns[:current_worker].id)
    case Sheets.create_sheet(sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet created successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    # job_codes = Time1.Jobs.list_job_codes()
    sheet = Sheets.get_sheet!(id)
    render(conn, "show.html", sheet: sheet)
  end

  def edit(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    changeset = Sheets.change_sheet(sheet)
    render(conn, "edit.html", sheet: sheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sheet" => sheet_params}) do
    sheet = Sheets.get_sheet!(id)

    case Sheets.update_sheet(sheet, sheet_params) do
      {:ok, sheet} ->
        conn
        |> put_flash(:info, "Sheet updated successfully.")
        |> redirect(to: Routes.sheet_path(conn, :show, sheet))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sheet: sheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sheet = Sheets.get_sheet!(id)
    {:ok, _sheet} = Sheets.delete_sheet(sheet)

    conn
    |> put_flash(:info, "Sheet deleted successfully.")
    |> redirect(to: Routes.sheet_path(conn, :index))
  end
end
