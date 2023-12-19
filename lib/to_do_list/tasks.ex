defmodule ToDoList.Tasks do
  @moduledoc """
  The Tasks context.
  """
  import Ecto.Query, warn: false
  alias ToDoList.Repo
  alias ToDoList.Tasks.Task

  @doc """
  Returns the list of tasks.
  """
  def get_task!(id), do: Repo.get!(Task, id)

  def list_tasks do
    Repo.all(from t in Task, where: t.completion == false, order_by: [desc: t.id])
  end

  def list_incomplete_tasks do
    Repo.all(from t in Task, where: t.completion == true)
  end

  @doc """
  Creates a Task
  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a Task
  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task
  """

  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
