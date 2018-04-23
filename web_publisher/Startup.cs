using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MassTransit;
using MassTransit.ExtensionsDependencyInjectionIntegration;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.SpaServices.Webpack;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace web_publisher
{
  public class Startup
  {
    public Startup(IConfiguration configuration)
    {
      Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    // This method gets called by the runtime. Use this method to add services to the container.
    public void ConfigureServices(IServiceCollection services)
    {
      services.AddMvc();

      services.AddMassTransit(c =>
      {
        c.AddConsumer<LogShipmentConsumer>();
        // c.AddConsumer<MyOtherConsumer>();

        // // or sagas
        // c.AddSaga<MySaga>();
      });

      services.AddScoped<LogShipmentConsumer>();

      var bus = Bus.Factory.CreateUsingRabbitMq(sbc =>
          {
            var host = sbc.Host(new Uri("rabbitmq://localhost"), h =>
                {
                  h.Username("guest");
                  h.Password("guest");
                });

            sbc.ReceiveEndpoint(host, "dotnet-receive-queue", e =>
            {
              //   e.Consumer<LogShipmentConsumer>();
              e.LoadFrom(services.BuildServiceProvider());
            });
          });

      services.AddSingleton<IBusControl>(bus)
          .AddSingleton<IBus>(bus)
          .AddSingleton<IPublishEndpoint>(bus);


      // you still need to register the consumers/sagas
      // services.AddScoped<LogShipmentConsumer>();
      //   services.AddScoped<MyOtherConsumer>();
      //   services.AddSingleton<ISagaRepository<MySaga>, InMemorySagaRepository<MySaga>>();

      //   services.BuildServiceProvider();

    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    public void Configure(IApplicationBuilder app, IHostingEnvironment env, IApplicationLifetime applicationLifetime, IServiceProvider serviceProvider)
    {
      if (env.IsDevelopment())
      {
        app.UseDeveloperExceptionPage();
        app.UseWebpackDevMiddleware(new WebpackDevMiddlewareOptions
        {
          HotModuleReplacement = true
        });
      }
      else
      {
        app.UseExceptionHandler("/Home/Error");
      }


      var bus = serviceProvider.GetService<IBusControl>();

      // start/stop the bus with the web application
      applicationLifetime.ApplicationStarted.Register(bus.Start);
      applicationLifetime.ApplicationStopped.Register(bus.Stop);


      app.UseStaticFiles();

      app.UseMvc(routes =>
      {
        routes.MapRoute(
                  name: "default",
                  template: "{controller=Home}/{action=Index}/{id?}");

        routes.MapSpaFallbackRoute(
                  name: "spa-fallback",
                  defaults: new { controller = "Home", action = "Index" });
      });
    }
  }
}
