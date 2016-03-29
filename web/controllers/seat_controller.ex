defmodule SeatSaver.SeatController do
  use SeatSaver.Web, :controller

  alias SeatSaver.Seat

  plug :scrub_params, "seat" when action in [:create, :update]

  def index(conn, _params) do
    seats = Repo.all(Seat)
    render(conn, "index.json", seats: seats)
  end

  def create(conn, %{"seat" => seat_params}) do
    changeset = Seat.changeset(%Seat{}, seat_params)

    case Repo.insert(changeset) do
      {:ok, seat} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", seat_path(conn, :show, seat))
        |> render("show.json", seat: seat)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SeatSaver.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    seat = Repo.get!(Seat, id)
    render(conn, "show.json", seat: seat)
  end

  def update(conn, %{"id" => id, "seat" => seat_params}) do
    seat = Repo.get!(Seat, id)
    changeset = Seat.changeset(seat, seat_params)

    case Repo.update(changeset) do
      {:ok, seat} ->
        render(conn, "show.json", seat: seat)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SeatSaver.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    seat = Repo.get!(Seat, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(seat)

    send_resp(conn, :no_content, "")
  end
end
