namespace web_publisher.Commands
{
  public class RegisterShipment
  {
    public RegisterShipment(string to, string from, string externalId)
    {
      To = to;
      From = from;
      ExternalId = externalId;
    }
    public string To { get; }
    public string From { get; }
    public string ExternalId { get; }
  }
}
