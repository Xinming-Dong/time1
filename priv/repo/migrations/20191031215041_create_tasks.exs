defmodule Time1.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :hour, :integer, null: false
      add :note, :text
      add :sheet_id, references(:sheets, on_delete: :nothing)
      add :job_id, references(:jobs, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:sheet_id])
    create index(:tasks, [:job_id])
  end
end
