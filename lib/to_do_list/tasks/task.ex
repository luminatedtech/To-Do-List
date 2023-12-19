defmodule ToDoList.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :name, :string
    field :description, :string
    field :due_date, :string
    field :completion, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :due_date, :completion])
    |> validate_required([:name, :description, :due_date, :completion])
  end
end
