defmodule ToDoListWeb.PageController do
  use ToDoListWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def edit_task(conn, _params) do
    render(conn, :edit_task, layout: false)
  end

end
