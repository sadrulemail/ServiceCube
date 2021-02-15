using Microsoft.Owin;
using Owin;

/// <summary>
/// Summary description for Startup
/// </summary>
public class Startup
{
    public void Configuration(IAppBuilder app)
    {
        app.MapSignalR();
    }
}