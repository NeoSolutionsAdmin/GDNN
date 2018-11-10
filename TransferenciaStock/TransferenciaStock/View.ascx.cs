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
        
        public Data2.Class.Struct_Producto SPO; //OBJETO PRODUCTO ORIGEN
        public Data2.Class.Struct_Producto SPD; //OBJETO PRODUCTO DESTINO
        int LO;     //ID DEL LOCAL DE ORIGEN
        int LD;     //ID DEL LOCAL DE DESTINO
        int PO;     //ID DEL PRODUCTO ORIGEN
        int PD;     //ID DEL PRODUCTO DESTINO
        int C;   //CANTIDAD A AÑADIR/RESAR AL PRODUCTO



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

            //SE FIJA SI TODOS LOS PARÁMETROS TIENEN VALOR
            if(Request["LO"] != null &&
                Request["LD"] != null &&
                Request["PO"] != null &&
                Request["PD"] != null &&
                Request["C"] != null)
            {
                //GUARDA LOS VALORES EN LAS VARIABLES DE C#
                LO = int.Parse(Request["LO"]);
                LD = int.Parse(Request["LD"]);
                PO = int.Parse(Request["PO"]);
                PD = int.Parse(Request["PD"]);
                C = int.Parse(Request["C"]);


                //LLENA LOS OBJETOS
                SPO = Data2.Class.Struct_Producto.Get_SingleArticle(LO, PO);
                SPD = Data2.Class.Struct_Producto.Get_SingleArticle(LD, PD);

                //LLAMA A LA FUNCION DE ACTUALIZAR CANTIDAD
                actualizarCant();
                
            }

        }
        

        //ACTUALIZA LA CANTIDAD DE STOCK DE AMBOS OBJETOS
        private void actualizarCant()
        {
            SPO.UpdateStock((SPO.CantidadINT - C).ToString());
            SPD.UpdateStock((SPD.CantidadINT + C).ToString());
            Response.Redirect(DotNetNuke.Common.Globals.NavigateURL());
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