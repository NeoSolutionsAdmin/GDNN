using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Data2.Class;
using Data2.Statics;

namespace Christoc.Modules.Turnero
{
    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ClearHeaders();
            //Parte de busqueda de tratamientos
            int idlocal = Conversion.ObtenerLocal( int.Parse(Request["LocalId"]) );
            string treatABuscar = Request["Name"];

            List<Struct_Treatment> treatmentResponse = Struct_Treatment.SearchTreatment(idlocal, treatABuscar);
            string jsonTreat = new JavaScriptSerializer().Serialize(treatmentResponse);

            //Parte de busqueda de clientes
            string clientABuscar = Request["RazonSocial"];
            List<Struct_Cliente> clientResponse = Struct_Cliente.SearchClient(clientABuscar, idlocal);
            string jsonClient = new JavaScriptSerializer().Serialize(clientResponse);

            if (Request["Name"] != null) Response.Write(jsonTreat);
            if (Request["RazonSocial"] != null) Response.Write(jsonClient);

            Response.Flush();
            Response.End();
        }
    }
}