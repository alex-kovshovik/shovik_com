defmodule ShovikComWeb.PageControllerTest do
  use ShovikComWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Alex Kovshovik's personal website"
  end
end
