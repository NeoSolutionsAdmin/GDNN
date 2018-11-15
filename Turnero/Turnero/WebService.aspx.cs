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
    public class coordenada
    {
        public int coordfecha;
        public int coordhora;
        public int idTurno;
        public string cliente;
    }

    public class tratasion
    {
        public Struct_Treatment tratamiento;
        public Struct_Turno turno;
    }

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
            List<coordenada> coordenadasTurnos = new List<coordenada>();
            if (turnosResponse != null)
            {
                foreach (Struct_Turno turno in turnosResponse)
                {
                    TimeSpan TS = turno.DiaReservacion - fechaBase;
                    DateTime aux = new DateTime(turno.DiaReservacion.Year, turno.DiaReservacion.Month,
                                                turno.DiaReservacion.Day, 0, 0, 0);
                    TimeSpan HR = turno.DiaReservacion - aux;

                    coordenada sesion = new coordenada();
                    sesion.coordfecha = TS.Days;
                    sesion.coordhora = Convert.ToInt32(Math.Round(HR.TotalHours * 2));
                    sesion.idTurno = turno.Id;
                    sesion.cliente = turno.CLIENTE.RS;
                    coordenadasTurnos.Add(sesion);
                }
            }
            //devuelve coordenadas de turnos en la tabla
            if (coordenadasTurnos != null)
            {
                string jsonTurnos = new JavaScriptSerializer().Serialize(coordenadasTurnos);
                Response.Write(jsonTurnos);
            }
        }

        private void getInfoTurno(int identSesion)
        {
            Struct_Turno aux = Struct_Turno.ObtenerTurnoById(identSesion);
            Struct_Treatment auxTreat = Struct_Treatment.GetTreatmentById(aux.SESION.IdTratamiento);
            tratasion returnable = new tratasion();
            returnable.turno = aux;
            returnable.tratamiento = auxTreat;
            string jsonTurno = new JavaScriptSerializer().Serialize(returnable);
            Response.Write(jsonTurno);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ClearHeaders();

            if (Request["Name"] != null) getTreatment(Conversion.ObtenerLocal(int.Parse(Request["LocalId"])), Request["Name"]);
            if (Request["RazonSocial"] != null) getCliente(Conversion.ObtenerLocal(int.Parse(Request["LocalId"])), Request["RazonSocial"]);
            if (Request["GetDate"] != null) Getdate(int.Parse(Request["GetDate"]));
            if (Request["fechaBase"] != null) getTurnos(Conversion.ObtenerLocal(int.Parse(Request["LocalId"])), Request["fechaBase"]);
            if (Request["identSesion"] != null) getInfoTurno(int.Parse(Request["identSesion"]));

            Response.Flush();
            Response.End();
        }
    }
}