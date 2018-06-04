defmodule DouyinExcavatorWeb.PageControllerTest do
  use DouyinExcavatorWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "解析视频"
  end
end
