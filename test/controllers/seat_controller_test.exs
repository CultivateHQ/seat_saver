defmodule SeatSaver.SeatControllerTest do
  use SeatSaver.ConnCase

  alias SeatSaver.Seat
  @valid_attrs %{occupied: true, seat_no: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, seat_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    seat = Repo.insert! %Seat{}
    conn = get conn, seat_path(conn, :show, seat)
    assert json_response(conn, 200)["data"] == %{"id" => seat.id,
      "seatNo" => seat.seat_no,
      "occupied" => seat.occupied}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, seat_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, seat_path(conn, :create), seat: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Seat, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, seat_path(conn, :create), seat: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    seat = Repo.insert! %Seat{}
    conn = put conn, seat_path(conn, :update, seat), seat: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Seat, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    seat = Repo.insert! %Seat{}
    conn = put conn, seat_path(conn, :update, seat), seat: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    seat = Repo.insert! %Seat{}
    conn = delete conn, seat_path(conn, :delete, seat)
    assert response(conn, 204)
    refute Repo.get(Seat, seat.id)
  end
end
