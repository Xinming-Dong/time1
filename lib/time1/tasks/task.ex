defmodule Time1.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :hour, :integer
    field :note, :string
    # field :sheet_id, :id
    # field :job_id, :id

    belongs_to :sheet, Time1.Sheets.Sheet
    belongs_to :job, Time1.Jobs.Job

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    IO.inspect "changeset"
    IO.inspect attrs
    task
    |> cast(attrs, [:hour, :note, :job_id, :sheet_id])
    |> validate_required([:hour, :note, :job_id, :sheet_id])
  end
end
