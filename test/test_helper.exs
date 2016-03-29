ExUnit.start

Mix.Task.run "ecto.create", ~w(-r SeatSaver.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r SeatSaver.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(SeatSaver.Repo)

