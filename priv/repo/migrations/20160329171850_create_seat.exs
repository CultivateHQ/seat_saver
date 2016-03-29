defmodule SeatSaver.Repo.Migrations.CreateSeat do
  use Ecto.Migration

  def change do
    create table(:seats) do
      add :seat_no, :integer
      add :occupied, :boolean, default: false

      timestamps
    end

  end
end
