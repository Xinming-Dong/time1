defmodule Time1.Managers.Manager do
  use Ecto.Schema
  import Ecto.Changeset

  # TODO: did not add any virtual field (lecture 15)
  schema "managers" do
    field :email, :string
    field :name, :string
    # field :password_hash, :string
    has_many :workers, Time1.Workers.Worker
    has_many :jobs, Time1.Jobs.Job

    timestamps()
  end

  @doc false
  def changeset(manager, attrs) do
    manager
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end
end
