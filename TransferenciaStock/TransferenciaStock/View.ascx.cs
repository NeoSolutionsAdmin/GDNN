/*
' Copyright (c) 2018  Christoc.com
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Christoc.Modules.TransferenciaStock
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from TransferenciaStockModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : TransferenciaStockModuleBase, IActionable
    {
        
        int idLD;
        int idP;
        
        string newCant;
        string oppNewCant;
        public Data2.Class.Struct_Producto SPO;
        public Data2.Class.Struct_Producto SPD;




        protected void Page_Load(object sender, EventArgs e)
        {
            
            IDLO.Value = Data2.Statics.Conversion.ObtenerLocal(UserId).ToString();

            try
            {

            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }

            ////ID LOCAL ORIGEN
            //idLO = Data2.Statics.Conversion.ObtenerLocal(UserId);
            //Session.Add("idLO", idLO);

            ////ID LOCAL DESTINO
            //if (Request["idL"] != null)
            //{
            //    idLD = int.Parse(Request["idL"]);
            //    Session.Add("idLD", idLD);
            //}
            ////ID PRODUCTO
            //if (Request["idP"] != null)
            //{
            //    idP = int.Parse(Request["idP"]);
            //    Session.Add("idP", idP);
            //}
            ////SI TENGO LOS DOS DATOS
            //if (idP > 0 && idLD > 0)
            //{
            //    //PRODUCTO ORIGEN
            //    SPO = Data2.Class.Struct_Producto.Get_SingleArticle(idLO, idP);
            //    Session.Add("SPO", SPO);

            //    //PRODUCTO DESTINO
            //    SPD = Data2.Class.Struct_Producto.Get_SingleArticle(idLD, idP);
            //    Session.Add("SPD", SPD);
            //}









            ////ID LOCAL DESTINO
            //if (Request["idL"] != null)
            //{
            //    idLD = int.Parse(Request["idL"]);
            //    Session.Add("idLD", idLD);
            //}



            ////ID PRODUCTO DESTINO
            //if (Request["idP"] != null)
            //{
            //    idP = int.Parse(Request["idP"]);
            //    Session.Add("idP", idP);


            //}










        }

        protected string cantButton_click(object sender, EventArgs e)
        {
            if (int.Parse(txtCant.Text) > 0)
            {
                newCant = "+" + int.Parse(txtCant.Text);
                Session.Add("newCant", newCant);
                oppNewCant = "-" + int.Parse(txtCant.Text);
                Session.Add("oppNewCant", oppNewCant);
            }           

            return newCant;
        }

        

        private void actualizarCant()
        {
            SPO.UpdateStock(Session["oppNewcant"].ToString());
            SPD.UpdateStock(Session["newCant"].ToString());
        }

        public ModuleActionCollection ModuleActions
        {
            get
            {
                var actions = new ModuleActionCollection
                    {
                        {
                            GetNextActionID(), Localization.GetString("EditModule", LocalResourceFile), "", "", "",
                            EditUrl(), false, SecurityAccessLevel.Edit, true, false
                        }
                    };
                return actions;
            }
        }

    }
}