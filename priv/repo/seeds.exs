# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ToDoList.Repo.insert!(%ToDoList.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ToDoList.Repo
alias ToDoList.Tasks.Task

%Task{
  name: "Take out the Garbage",
  description:
    "Empty out the trash bins in the kitchen and bathroom and move out the trash can to the front of the house",
  due_date: "12/8",
  completion: false
}
|> Repo.insert!()

%Task{
  name: "Order HDMI cable",
  description: "Order a 20 feet cable from Amazon",
  due_date: "12/9",
  completion: false
}
|> Repo.insert!()

%Task{
  name: "Buy Groceries",
  description: "Buy garlic, onions, red wine, pasta, and tomato sauce from Whole Foods",
  due_date: "12/11",
  completion: false
}
|> Repo.insert!()
