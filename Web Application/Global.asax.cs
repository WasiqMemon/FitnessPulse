using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Http;
using System.Web.Routing;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using Newtonsoft.Json;

namespace FitnessPulse_Web
{
    public class Global : System.Web.HttpApplication
    {
        public class BrowserJsonFormatter : JsonMediaTypeFormatter
        {
            public BrowserJsonFormatter()
            {
                this.SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/html"));
                this.SerializerSettings.Formatting = Formatting.Indented;
            }

            public override void SetDefaultContentHeaders(Type type, HttpContentHeaders headers, MediaTypeHeaderValue mediaType)
            {
                base.SetDefaultContentHeaders(type, headers, mediaType);
                headers.ContentType = new MediaTypeHeaderValue("application/json");
            }
        }
        protected void Application_Start(object sender, EventArgs e)
        {
            RouteTable.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = System.Web.Http.RouteParameter.Optional }
                );
            var config = GlobalConfiguration.Configuration;
            config.Formatters.XmlFormatter.SupportedMediaTypes.Remove(
            config.Formatters.XmlFormatter.SupportedMediaTypes.FirstOrDefault(t => t.MediaType == "application/xml"));
            config.Formatters.Add(new BrowserJsonFormatter());
        }
    }
}