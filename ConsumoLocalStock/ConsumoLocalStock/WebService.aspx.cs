using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace Christoc.Modules.ConsumoLocalStock
{
    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string busqueda = "%";
            string json = "";


            if(Request["buscarT"] != null)
            {
                busqueda = Request["buscarT"].ToString();
                List<Data2.Class.Struct_Treatment> resultado = Data2.Class.Struct_Treatment.SearchTreatment(
                    int.Parse(Request["id"].ToString()),
                    busqueda);
                if (resultado != null && resultado.Count > 0)
                {
                    json = new JavaScriptSerializer().Serialize(resultado);
                }
            }


             if (Request["buscarP"] != null)
             {
                busqueda = Request["buscarP"].ToString();
                List<Data2.Class.Struct_Producto> resultado = Data2.Class.Struct_Producto.SearchProducto(
                    int.Parse(Request["id"].ToString()),
                    busqueda,
                    Data2.Connection.D_Articles.SearchCondition.PorDescripcion,
                    -1);

                if (resultado != null && resultado.Count > 0)
                {
                    json = new JavaScriptSerializer().Serialize(resultado);
                }
             }
             

            Response.Clear();
            Response.ClearHeaders();
            Response.Write(json);
            Response.Flush();
            Response.End();
        }
    }
}