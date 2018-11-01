using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Config_notif_stock.Startup))]
namespace Config_notif_stock
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
