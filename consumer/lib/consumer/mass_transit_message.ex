defmodule ShipmentReceived do
  defstruct shipmentId: "",
            sortingCode: "",
            timestamp: DateTime.utc_now()
end

defmodule MassTransitHost do
  defstruct assembly: "",
            assemblyVersion: "",
            frameworkVersion: "",
            machineName: "",
            massTransitVersion: "",
            operatingSystemVersion: "",
            processId: "",
            processName: ""
end

defmodule MassTransitMessage do
  defstruct conversationId: "",
            destinationAddress: "",
            headers: %{},
            host: %MassTransitHost{},
            message: %{},
            messageId: "",
            messageType: [],
            sourceAddress: ""
end

# %{
#   "conversationId" => "c3010000-e828-2200-3cf2-08d5a4463a5a",
#   "destinationAddress" => "rabbitmq://localhost/Mra.Events.Shipping:ShipmentRegistered",
#   "headers" => %{},
#   "host" => %{
#     "assembly" => "publisher",
#     "assemblyVersion" => "1.0.0.0",
#     "frameworkVersion" => "4.0.30319.42000",
#     "machineName" => "pasikokko",
#     "massTransitVersion" => "4.0.1.1390",
#     "operatingSystemVersion" => "Unix 17.5.0.0",
#     "processId" => 99803,
#     "processName" => "dotnet"
#   },
#   "message" => %{
#     "shipmentId" => "3",
#     "sortingCode" => "fi-sei-81",
#     "timestamp" => "2018-04-17T09:33:13.321561+00:00"
#   },
#   "messageId" => "c3010000-e828-2200-3b26-08d5a4463a5a",
#   "messageType" => [
#     "urn:message:Mra.Events.Shipping:ShipmentRegistered",
#     "urn:message:Mra.Events:Event"
#   ],
#   "sourceAddress" =>
#     "rabbitmq://localhost/bus-pasikokko-dotnet-acyoyy8efytyy35cbdk48rmxny?durable=false&autodelete=true"
# }
