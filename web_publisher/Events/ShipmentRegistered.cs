
using System;

namespace Mra.Events.Shipping
{
  public interface ShipmentRegistered : Event
  {
    string ShipmentId { get; }
    string To { get; }
    string From { get; }
    string ExternalId { get; }
    DateTimeOffset Timestamp { get; }
  }
}

namespace Mra.Events
{
  public interface Event
  { }
}


