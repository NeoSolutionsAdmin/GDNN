using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace Christoc.Modules.TransferenciaStock
{
    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string busqueda = "%";
            string json = "";

            if (Request["buscarL"] != null)
            {
                busqueda = Request["buscarL"].ToString();
                List<Data2.Class.Struct_Sucursales> ResultadosS =
                Data2.Class.Struct_Sucursales.searchLocales(busqueda);
                json = new JavaScriptSerializer().Serialize(ResultadosS);
            }
            if(Request["buscarP"] != null)
            {
                busqueda = Request["buscarP"].ToString();

                List<Data2.Class.Struct_Producto> ResultadosP =
                    Data2.Class.Struct_Producto.SearchProducto(
                       int.Parse(Request["Id"].ToString()),
                        busqueda,
                        Data2.Connection.D_Articles.SearchCondition.PorDescripcion,
                        -1);
                if (ResultadosP != null && ResultadosP.Count > 0)
                {
                    json = new JavaScriptSerializer().Serialize(ResultadosP);
                }
                else { json = "null"; }
            }
            


                Response.Clear();
            Response.ClearHeaders();
            Response.Write(json);
            Response.Flush();
            Response.End();
            



        }
    }
}