using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using Data2.Class;

namespace Christoc.Modules.ConsumoLocalStock
{    

    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            string busqueda = "%";
            string json = "";


            if(Request["buscarT"] != null)  //Busqueda de TRATAMIENTO
            {
                busqueda = Request["buscarT"].ToString();
                List<Struct_Treatment> resultado = Data2.Class.Struct_Treatment.SearchTreatment(
                    int.Parse(Request["id"].ToString()),
                    busqueda);
                if (resultado != null && resultado.Count > 0)
                {
                    json = new JavaScriptSerializer().Serialize(resultado);
                }
            }


             if (Request["buscarP"] != null)    //Busqueda de PRODUCTO
             {
                busqueda = Request["buscarP"].ToString();
                List<Struct_Producto> resultado = Struct_Producto.SearchProducto(
                    int.Parse(Request["id"]),
                    busqueda,
                    Data2.Connection.D_Articles.SearchCondition.PorDescripcion,
                    -1);

                if (resultado != null && resultado.Count > 0)
                {
                    json = new JavaScriptSerializer().Serialize(resultado);
                }
             }

             if (Request["buscarST"] != null)
             {
                int idTratamiento = int.Parse(Request["buscarST"]);

                List<Struct_ConsumoLocalStock> LSCLS =
                    Struct_ConsumoLocalStock.getStockTratamientoByIdTratamiento(
                        int.Parse(Request["id"]),
                        idTratamiento);
                
                List<StockTratamiento> LST = new List<StockTratamiento>();
                if (LSCLS != null)
                {
                    foreach (Struct_ConsumoLocalStock a in LSCLS)
                    {
                        StockTratamiento ST = new StockTratamiento();
                        ST.stock = Struct_Producto.Get_SingleArticle(
                            int.Parse(Request["id"]),
                            a.idArticulo);
                        ST.cantidadDECTratamiento = a.cantDEC;
                        ST.cantidadINTTratamiento = a.cantINT;
                        ST.idTratamientoAsociado = a.idTratamiento;
                        LST.Add(ST);
                    }
                    if (LST != null && LST.Count > 0)
                    {
                        json = new JavaScriptSerializer().Serialize(LST);
                    }
                }
                else
                {
                    json = "Lista vacía";
                }

             }

            if (Request["fechas"] != null)
            {
                

            }


             

            Response.Clear();
            Response.ClearHeaders();
            Response.Write(json);
            Response.Flush();
            Response.End();
        }
    }
}