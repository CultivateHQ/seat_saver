defmodule SeatSaver.PageControllerTest do
  use SeatSaver.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to Seat Saver"
  end
end
