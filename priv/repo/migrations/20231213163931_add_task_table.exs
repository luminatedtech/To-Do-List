defmodule ToDoList.Repo.Migrations.AddTaskTable do
  use Ecto.Migration

  def change do
    create table("tasks") do
      add :name, :string
      add :description, :string
      add :due_date, :string
      add :completion, :boolean

      timestamps()
    end
  end
end
