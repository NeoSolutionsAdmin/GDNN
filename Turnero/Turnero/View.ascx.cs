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

namespace Christoc.Modules.Turnero
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from TurneroModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : TurneroModuleBase, IActionable
    {

        //Prueba modulo CS Turno
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["addtrat"] != null)
            {
                string idtrat = Request.QueryString["addtrat"];
                Data2.Class.Struct_Treatment ST = Data2.Class.Struct_Treatment.GetTreatmentById(int.Parse(idtrat));
                Session.Remove("tratamiento");
                Session.Add("tratamiento", ST);

            }
            if (Request["addclient"] != null)
            {
                string idclient = Request.QueryString["addclient"];
                Data2.Class.Struct_Cliente SC = Data2.Class.Struct_Cliente.GetClient(int.Parse(idclient), UserId);
               
                Session.Remove("cliente");
                Session.Add("cliente", SC);
            }

            llenarCampos();

            try
            {

            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
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

        public void llenarCampos()
        {
            if(Session["cliente"] != null)
            {                                                
                Data2.Class.Struct_Cliente SC = Session["cliente"] as Data2.Class.Struct_Cliente;
                labelrs.Text = SC.RS;
                labeldni.Text = SC.DNI;
            }

            if (Session["tratamiento"] != null)
            {
                Data2.Class.Struct_Treatment ST = Session["tratamiento"] as Data2.Class.Struct_Treatment;
                labeltratamiento.Text = ST.Nombre;
            }
        }

        protected void guardar_Click(object sender, EventArgs e)
        {
            Session.Remove("cliente");
            Session.Remove("tratamiento");
        }
    }
}