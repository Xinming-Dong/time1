defmodule Time1.Sheets.Sheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sheets" do
    field :approve_status, :boolean, default: false
    field :date, :date
    # field :worker_id, :id

    belongs_to :worker, Time1.Workers.Worker

    has_many :tasks, Time1.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(sheet, attrs) do
    sheet
    |> cast(attrs, [:date, :approve_status, :worker_id])
    |> validate_required([:date, :approve_status, :worker_id])
  end
end
