defmodule SeatSaver.SeatChannel do
  use SeatSaver.Web, :channel

  import Ecto.Query

  alias SeatSaver.Seat

  def join("seats:planner", payload, socket) do
    query = from s in Seat, order_by: [asc: s.seat_no]
    seats = query |> Repo.all
    {:ok, seats, socket}
  end
end
