defmodule ToDoListWeb.TasksLive do
  use ToDoListWeb, :live_view
  alias ToDoList.Tasks
  alias ToDoList.Tasks.Task

  @doc "To show completed tasks or not"



  def mount(_params, _session, socket) do
    incomplete_tasks = Tasks.list_tasks()
    completed_tasks = Tasks.list_incomplete_tasks()
    changeset = Tasks.change_task(%Task{})

    socket =
      socket
      |> assign(:incomplete_tasks, incomplete_tasks)
      |> assign(:form, to_form(changeset))
      |> assign(:completed, false)
      |> assign(:completed_tasks, completed_tasks)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-4xl mx-auto mt-10 ">
      <div class="flex flex-col mt-10 mb-10">
        <.form
          for={@form}
          phx-submit="save"
          class="flex items-baseline justify-around px-6 py-4 mb-8 border-2 border-dashed border-slate-400"
        >
          <.input field={@form[:name]} placeholder="Task" autocomplete="off" />
          <.input field={@form[:description]} placeholder="Description" autocomplete="off" />
          <.input field={@form[:due_date]} placeholder="Due Date" autocomplete="off" />
          <.button phx-disable-with="Saving...">
            Add Task
          </.button>
        </.form>
        <div :for={task <- @incomplete_tasks} class="overflow-hidden bg-gray-300 border-2 border-dashed rounded max-w-l">
          <div class="pt-6 pb-6 pl-4 pr-4">
            <div class="pb-3 text-xl font-bold text-center">
              <%= task.name %>
            </div>
            <div class="flex justify-between pl-6 pr-6 mt-2">
              <span class="description">
                <%= task.description %>
              </span>
              <span class="due_date">
                <%= task.due_date %>
              </span>
              <button
                phx-click="complete"
                phx-value-id={task.id}
                class="rounded-md bg-indigo-600 px-2.5 py-1.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
              >
                Complete
              </button>
                <.link
                href={~p"/edittasks"}
                >
                    Edit
                </.link>
            </div>
          </div>
        </div>
        <div :if={@completed} :for={task <- @completed_tasks} >
          <div class="pt-6 pb-6 pl-4 pr-4">
            <div class="pb-3 text-xl font-bold text-center">
              <%= task.name %>
            </div>
            <div class="flex justify-between pl-6 pr-6 mt-2">
              <span class="description">
                <%= task.description %>
              </span>
              <span class="due_date">
                <%= task.due_date %>
              </span>
            </div>
          </div>
        </div>
      </div>
      <button :if={!@completed} phx-click="show_completed">
          View Completed Tasks
      </button>
      <button :if={@completed} phx-click="hide_completed">
          Hide Completed Tasks
      </button>
    </div>
    """
  end

  def handle_event("complete", %{"id" => task_id}, socket) do
    task = Tasks.get_task!(task_id)
    {:ok, updated_task} = Tasks.update_task(task, %{completion: true})

    socket =
      update(
        socket,
        :tasks,
        fn tasks -> [updated_task | tasks] end
      )

    changeset = Tasks.change_task(%Task{})
    {:noreply, assign(socket, :form, to_form(changeset))}
  end

  def handle_event("save", %{"task" => task_params}, socket) do
    case Tasks.create_task(task_params) do
      {:ok, task} ->
        socket =
          update(
            socket,
            :tasks,
            fn tasks -> [task | tasks] end
          )

        changeset = Tasks.change_task(%Task{})
        {:noreply, assign(socket, :form, to_form(changeset))}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  def handle_event("show_completed", _, socket) do
    IO.inspect(:completed)
    {:noreply, assign(socket, completed: true)}
  end

  def handle_event("hide_completed", _unsigned_params, socket) do
    {:noreply, assign(socket, completed: false)}
  end


end
