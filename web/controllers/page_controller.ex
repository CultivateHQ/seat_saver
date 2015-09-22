defmodule SeatSaver.PageController do
  use SeatSaver.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
