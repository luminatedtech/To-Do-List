defmodule ToDoListWeb.TaskController do
  use ToDoListWeb, :controller
  alias ToDoList.Tasks
  alias ToDoList.Tasks.Task

  def index(conn, _params) do
    render(conn, :index)
  end

  def incomplete(conn, _parmas) do
    tasks = Tasks.list_incomplete_tasks()
    render(conn, "incomplete.html", tasks: tasks)
  end
end
