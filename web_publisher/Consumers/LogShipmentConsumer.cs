using System;
using System.Threading.Tasks;
using MassTransit;
using Microsoft.Extensions.Logging;
using Mra.Events.Shipping;

public class LogShipmentConsumer :
    IConsumer<ShipmentRegistered>
{
  private readonly ILogger<LogShipmentConsumer> logger;

  public LogShipmentConsumer(ILogger<LogShipmentConsumer> logger)
  {
    this.logger = logger;
  }

  public Task Consume(ConsumeContext<ShipmentRegistered> context)
  {
    logger.LogDebug($"Shipment was registered: {context.Message.ShipmentId}");
    return Task.CompletedTask;
  }
}