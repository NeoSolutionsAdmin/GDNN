using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Christoc.Modules.ConfiguracionAlertaStock
{
    public partial class WebService : System.Web.UI.Page
    {

        private string BuscarArticulo(string busqueda, int LocalId)
        {
            List<Data2.Class.Struct_Producto> SP = Data2.Class.Struct_Producto.SearchProducto(LocalId, busqueda, Data2.Connection.D_Articles.SearchCondition.PorDescripcion);
            if (SP != null && SP.Count > 0)
            {
                System.Web.Script.Serialization.JavaScriptSerializer Serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                return Serializer.Serialize(SP);
            }
            else
            {
                return "null";
            }

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string respuesta = null;

            Response.Clear();
            Response.ClearHeaders();

            if (Request["busqueda"] != null && Request["LocalId"]!=null)
            {
                respuesta = BuscarArticulo(Request["buesqueda"].ToString(), int.Parse(Request["LocalId"].ToString()));
            }
            Response.Write(respuesta);
            Response.Flush();
            Response.End();
        }
    }
}