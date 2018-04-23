defimpl Lapin.Message.Payload, for: ShipmentReceived do
  def content_type(_payload), do: "application/vnd.masstransit+json"
  def encode(payload), do: Jason.encode(payload)
  def decode_into(payload, data) do
    # IO.puts "payload: #{inspect payload}"
    IO.inspect data
    # Poison.decode(data["message"], as: payload)
    # # %ShipmentReceived{}
    data["message"]
  end
end

defimpl Lapin.Message.Payload, for: MassTransitMessage do
  def content_type(_payload), do: "application/vnd.masstransit+json"
  def encode(payload), do: Jason.encode(payload)
  def decode_into(payload, data) do
    # IO.puts "payload: #{inspect payload}"
    # IO.inspect data
    Poison.decode(data, as: payload)
    # # %ShipmentReceived{}
    # data["message"]
  end
end

