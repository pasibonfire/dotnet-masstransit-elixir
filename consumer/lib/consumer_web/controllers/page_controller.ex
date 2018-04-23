defmodule ConsumerWeb.PageController do
  use ConsumerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
