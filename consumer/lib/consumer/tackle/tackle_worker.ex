defmodule Consumer.TackleWorker do
  use Tackle.Consumer,
    url: "amqp://localhost",
    exchange: "Mra.Events:Event",
    service: "Tackle-service",
    routing_key: "",
    count: 1

  import Consumer.GenericHandler

  def handle_message(message) do
    handle("Tackle", message)
  end
end
