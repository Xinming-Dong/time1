defmodule Time1.Workers.Worker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workers" do
    field :email, :string
    field :name, :string
    # field :manager_id, :id
    belongs_to :manager, Time1.Managers.Manager
    
    has_many :sheets, Time1.Sheets.Sheet

    timestamps()
  end

  @doc false
  def changeset(worker, attrs) do
    worker
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
