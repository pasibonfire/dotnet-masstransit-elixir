using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MassTransit;
using Microsoft.AspNetCore.Mvc;
using web_publisher.Commands;

namespace web_publisher.Controllers
{
  [Route("api/[controller]")]
  public class ShipmentController : Controller
  {
    private IPublishEndpoint bus;
    public ShipmentController(IPublishEndpoint bus)
    {
      this.bus = bus;
    }

    [HttpGet("{id}", Name = "GetShipment")]
    public IActionResult GetById(long id)
    {
      return new ObjectResult(new { message = id });
    }


    [HttpPost]
    public IActionResult Create([FromBody] RegisterShipment registration)
    {
      if (registration == null)
        return BadRequest();

      string shipmentId = Guid.NewGuid().ToString();

      bus.Publish<Mra.Events.Shipping.ShipmentRegistered>(new
      {
        ExternalId = registration.ExternalId,
        ShipmentId = shipmentId,
        To = registration.To,
        From = registration.From,
        Timestamp = DateTimeOffset.UtcNow,
      });

      return CreatedAtRoute("GetShipment", new { id = shipmentId }, registration);
    }
  }
}
