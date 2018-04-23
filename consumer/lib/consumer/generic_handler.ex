defmodule Consumer.GenericHandler do

  require Logger

  def handle(message_type, payload) when is_map(payload) do
    Logger.warn "!! #{message_type} !!"

    IO.inspect payload.message
  end

  def handle(message_type, payload) when is_binary(payload) do
    Logger.warn "!! #{message_type} !!"

    msg = payload
    |> Jason.decode!
    # |> IO.inspect

    IO.inspect msg["message"]

  end

end
