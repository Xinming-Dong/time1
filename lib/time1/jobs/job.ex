defmodule Time1.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :budget, :integer
    field :description, :string
    field :job_code, :string
    field :name, :string
    # field :manager_id, :id
    belongs_to :manager, Time1.Managers.Manager

    has_many :tasks, Time1.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:name, :job_code, :budget, :description])
    |> validate_required([:name, :job_code, :budget, :description])
  end
end
