defmodule SeatSaver.SeatChannel do
  use SeatSaver.Web, :channel

  import Ecto.Query

  alias SeatSaver.Seat

  def join("seats:planner", _payload, socket) do
    query = from s in Seat, order_by: [asc: s.seat_no]
    seats = query |> Repo.all
    {:ok, seats, socket}
  end

  def handle_in("request_seat", payload, socket) do
    seat = Repo.get!(SeatSaver.Seat, payload["seatNo"])

    seat_params = %{"occupied" => !payload["occupied"]}
    changeset = SeatSaver.Seat.changeset(seat, seat_params)

    case Repo.update(changeset) do
      {:ok, seat} ->
        broadcast socket, "updated", seat
        {:noreply, socket}
      {:error, _changeset} ->
        {:reply, {:error, %{message: "Something went wrong."}}, socket}
    end
  end
end
