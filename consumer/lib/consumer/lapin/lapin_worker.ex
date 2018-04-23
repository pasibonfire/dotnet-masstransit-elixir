defmodule Consumer.LapinWorker do
  use Lapin.Connection

  import Consumer.GenericHandler

  def handle_deliver(channel, message) do

    IO.inspect message.payload

    handle("Lapin", message.payload)

    # Logger.debug fn -> "received #{inspect message} on #{inspect channel}" end
    :ok
  end

  def payload_for(arg0, arg1) do
    %MassTransitMessage{}
  end

end



