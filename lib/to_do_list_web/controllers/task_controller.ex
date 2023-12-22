defmodule ToDoListWeb.TaskController do
  use ToDoListWeb, :controller


  def index(conn, _params) do
    render(conn, :index)
  end

end
