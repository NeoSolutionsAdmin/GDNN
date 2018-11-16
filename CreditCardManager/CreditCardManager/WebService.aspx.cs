using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace Christoc.Modules.CreditCardManager
{
    public partial class WebService : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string json = "null";
            int idUser;
            
            if(Request["id"] != null)
            {
                idUser = int.Parse(Request["id"]);
                List<Data2.Class.Struct_Tarjeta> Tarjetas =
                Data2.Class.Struct_Tarjeta.GetAllCreditCards(idUser);                
                json = new JavaScriptSerializer().Serialize(Tarjetas);
            }
            else
            {
                json = "null";
            }

            

            

            



            Response.Clear();
            Response.ClearHeaders();
            Response.Write(json);
            Response.Flush();
            Response.End();
        }
    }
}