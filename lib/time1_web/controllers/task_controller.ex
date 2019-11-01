defmodule Time1Web.TaskController do
  use Time1Web, :controller

  alias Time1.Tasks
  alias Time1.Tasks.Task

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Tasks.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  # def create(conn, %{"task" => task_params}) do
  #   # IO.inspect conn
  #   task_params = Map.put(task_params, "worker_id", conn.assigns[:current_worker].id)
  #   case Sheets.create_sheet(sheet_params) do
  #     {:ok, sheet} ->
  #       conn
  #       |> put_flash(:info, "Sheet created successfully.")
  #       |> redirect(to: Routes.sheet_path(conn, :show, sheet))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  def create(conn, %{"date" => date, "job_code1" => job_code1, "job_code2" => job_code2, "job_code3" => job_code3, "job_code4" => job_code4, 
  "job_code5" => job_code5, "job_code6" => job_code6, "job_code7" => job_code7, "job_code8" => job_code8,
  "hours1" => hours1, "hours2" => hours2, "hours3" => hours3, "hours4" => hours4, 
  "hours5" => hours5, "hours6" => hours6, "hours7" => hours7, "hours8" => hours8}) do
    code = [job_code1, job_code2, job_code3, job_code4, job_code5, job_code6, job_code7, job_code8]
    hour = [hours1, hours2, hours3, hours4, hours5, hours6, hours7, hours8]
    # IO.inspect hour
    hour = Enum.map(hour, fn h -> (
      if h == "" do
        0
      else
        {a, _} = Integer.parse(h)
        a
      end
    )end)
    hour_sum = Enum.reduce(hour, fn h, acc -> h + acc end)
    if hour_sum === 8 do
      worker_id = get_session(conn, :worker_id)
      # IO.puts "aaaaaaaaaaaaaaaa"
      # IO.puts worker_id
      case Time1.Sheets.create_sheet(%{worker_id: worker_id, date: date, approve_status: false}) do
        {:ok, sheet} ->
          entry = Enum.zip(code, hour)
          # job_id = Time1.Jobs.get_jobid_by_code(code)
          Enum.map(entry, fn {c, h} -> {
            if h != 0 do
              IO.inspect Time1.Tasks.create_task(%{sheet_id: sheet.id, job_id: Time1.Jobs.get_jobid_by_code(c), hour: h, note: "a task created."})
            end
          } end)
          conn
          |> put_flash(:info, "Sheet created successfully.")
          |> redirect(to: Routes.sheet_path(conn, :show, sheet))
        {:error, %Ecto.Changeset{} = changeset} ->
          conn
          |> put_flash(:error, "Creation error.")
          render(conn, "create_error.html", hour_sum: hour_sum)
          # render(conn, "new.html", changeset: changeset)
      end
    else
      conn
      |> put_flash(:error, "Total working hour should be 8.")
      render(conn, "create_error.html", hour_sum: hour_sum)
    end

    # tasks = Tasks.list_tasks()
    # render(conn, "index.html", tasks: tasks)
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    changeset = Tasks.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    {:ok, _task} = Tasks.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end
end
