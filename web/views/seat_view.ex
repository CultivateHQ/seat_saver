defmodule SeatSaver.SeatView do
  use SeatSaver.Web, :view

  def render("index.json", %{seats: seats}) do
    %{data: render_many(seats, SeatSaver.SeatView, "seat.json")}
  end

  def render("show.json", %{seat: seat}) do
    %{data: render_one(seat, SeatSaver.SeatView, "seat.json")}
  end

  def render("seat.json", %{seat: seat}) do
    %{id: seat.id,
      seatNo: seat.seat_no,
      occupied: seat.occupied}
  end
end
