defmodule ConsumerWeb.EventChannel do
  use Phoenix.Channel

  def join("events:" <> event_type, _message, socket) do
    {:ok, socket}
  end
  # def join("room:" <> _private_room_id, _params, _socket) do
  #   {:error, %{reason: "unauthorized"}}
  # end
end
