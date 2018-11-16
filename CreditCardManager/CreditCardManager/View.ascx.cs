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

namespace Christoc.Modules.CreditCardManager
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from CreditCardManagerModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : CreditCardManagerModuleBase, IActionable
    {

        public void Page_Load(object sender, EventArgs e)
        {
            string nombre;
            decimal recargo;
            int idlocal;
            int idT;
            

            try
            {

            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
 
            idLocalHidden.Value = Data2.Statics.Conversion.ObtenerLocal(UserId).ToString();

            if (Request["nombre"] != null && Request["recargo"] != null)
            {

                recargo = Data2.Statics.Conversion.GetDecimal(Request["recargo"].ToString());            
                nombre = Request["nombre"].ToString();
                idlocal = int.Parse(Request["idL"]);

                Data2.Class.Struct_Tarjeta.NuevaTarjeta(idlocal, recargo, nombre);
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL());
            }

            if (Request["idT"] != null && Request["h"] != null)
            {
                idT = int.Parse(Request["idT"]);
                Data2.Class.Struct_Tarjeta ST = Data2.Class.Struct_Tarjeta.GetTarjetaById(idT);
                if (Request["h"] == "1")
                {
                    ST.HabilitarTarjeta();
                }
                if (Request["h"] == "0")
                {
                    ST.DeshabilitarTarjeta();
                }
                Response.Redirect(DotNetNuke.Common.Globals.NavigateURL());


            }

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