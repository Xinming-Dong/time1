defmodule Time1.Repo.Migrations.AddPasswordHash do
  use Ecto.Migration

  def change do
    alter table("managers") do
      add :password_hash, :string, default: "", null: false
    end
  end
end
