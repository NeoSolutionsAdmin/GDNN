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

        private void Getdate(int offset)
        {
            DateTime begin = DateTime.Now.AddDays(offset);
            List<string> MiListaDeDias = new List<string>();
            for (int a = 0; a < 5; a++)
            {
                DateTime currentday = begin.AddDays(a);
                string fecha = currentday.Day + "/" + currentday.Month + "/" + currentday.Year;
                MiListaDeDias.Add(fecha);
            }
            string jsonDates = new JavaScriptSerializer().Serialize(MiListaDeDias);
            Response.Write(jsonDates);

        }

        private void getCliente(int idLocal, string clientABuscar)
        {
            List<Struct_Cliente> clientResponse = Struct_Cliente.SearchClient(clientABuscar, idLocal);
            string jsonClient = new JavaScriptSerializer().Serialize(clientResponse);
            Response.Write(jsonClient);
        }

        private void getTreatment(int idLocal, string treatABuscar)
        {
            List<Struct_Treatment> treatmentResponse = Struct_Treatment.SearchTreatment(idLocal, treatABuscar);
            string jsonTreat = new JavaScriptSerializer().Serialize(treatmentResponse);
            Response.Write(jsonTreat);
        }

        private void getTurnos(int idLocal, string baseDate)
        {
            string[] fecha = baseDate.Split('/');
            DateTime fechaBase = new DateTime(int.Parse(fecha[2]), int.Parse(fecha[1]), int.Parse(fecha[0]));
            List<Struct_Turno> turnosResponse = Struct_Turno.ObtenerTurnosEntreDias(fechaBase,fechaBase.AddDays(5), idLocal);
            //devuelve coordenadas de turnos en la tabla
            //string jsonTurnos = new JavaScriptSerializer().Serialize(turnosResponse);
            //Response.Write(jsonTurnos);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ClearHeaders();

            if (Request["Name"] != null) getTreatment(Conversion.ObtenerLocal(int.Parse(Request["LocalId"])), Request["Name"]);
            if (Request["RazonSocial"] != null) getCliente(Conversion.ObtenerLocal(int.Parse(Request["LocalId"])), Request["RazonSocial"]);
            if (Request["GetDate"] != null) Getdate(int.Parse(Request["GetDate"]));
            if (Request["fechaBase"] != null) getTurnos(Conversion.ObtenerLocal(int.Parse(Request["LocalId"])), Request["fechaBase"]);

            Response.Flush();
            Response.End();
        }
    }
}